//
//  URRouteManager.m
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/27.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import "URRouteManager.h"
#import "URRoute.h"
#import "URConfig.h"
#import "URRouteFileCache.h"

@interface URRouteManager ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, assign) BOOL updatingRoutes;
@property (nonatomic, strong, readwrite) NSArray<URRoute *> *routes;
@property (nonatomic, strong) NSMutableArray *updateRoutesCompletions;

@end

@implementation URRouteManager

+ (URRouteManager *)shareInstance {
    static URRouteManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[URRouteManager alloc] init];
        instance.routesMapURL = [URConfig routesMapURL];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[[NSOperationQueue alloc] init]];
        _updateRoutesCompletions = [NSMutableArray array];
    }
    return self;
}

- (void)setRoutesMapURL:(NSURL *)routesMapURL {
    if (_routesMapURL != routesMapURL) {
        _routesMapURL = [routesMapURL copy];
        self.routes = [self _ur_routesWithData:[[URRouteFileCache sharedInstance] routesMapFile]];
    }
}

- (void)setCachePath:(NSString *)cachePath {
    URRouteFileCache *routeFileCache = [URRouteFileCache sharedInstance];
    routeFileCache.cachePath = cachePath;
    self.routes = [self _ur_routesWithData:[routeFileCache routesMapFile]];
}

- (void)setResoucePath:(NSString *)resourcePath {
    URRouteFileCache *routeFileCache = [URRouteFileCache sharedInstance];
    routeFileCache.resourcePath = resourcePath;
    self.routes = [self _ur_routesWithData:[routeFileCache routesMapFile]];
}

- (void)updateRoutesWithCompletion:(void (^)(BOOL))completion {
    NSParameterAssert([NSThread mainThread]);
    
    if (self.routesMapURL == nil) {
        return;
    }
    
    if (completion) {
        [self.updateRoutesCompletions addObject:completion];
    }
    
    if (self.updatingRoutes) {
        return;
    }
    self.updatingRoutes = YES;
    void (^APICompletion)(BOOL) = ^(BOOL success){
        dispatch_async(dispatch_get_main_queue(), ^{
            for (void (^item)(BOOL) in self.updateRoutesCompletions) {
                item(success);
            }
            [self.updateRoutesCompletions removeAllObjects];
            self.updatingRoutes = NO;
        });
    };
    //请求路由表API
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.routesMapURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (((NSHTTPURLResponse *)response).statusCode != 200) {
            APICompletion(NO);
            return;
        }
        
        //下载最新routes中的资源文件. 只有成功后，才会更新`routes.json`及内存中的`routes`
        NSArray *routes = [self _ur_routesWithData:data];
        [self _ur_downloadFilesWithinRoutes:routes completion:^(BOOL success) {
            if (success) {
                self.routes = routes;
                URRouteFileCache *routeFileCache = [URRouteFileCache sharedInstance];
                [routeFileCache saveRoutesMapFile:data];
            }
            APICompletion(success);
        }];
    }] resume];
}

- (NSURL *)localHtmlURLForURI:(NSURL *)uri {
    NSURL *remoteHtmlURL = [self remoteHtmlURLForURI:uri];
    URRouteFileCache *routeFileCache = [URRouteFileCache sharedInstance];
    return [routeFileCache routeFileURLForRemoteURL:remoteHtmlURL];
}

- (NSURL *)remoteHtmlURLForURI:(NSURL *)uri {
    URRoute *route = [self _ur_routeForURI:uri];
    if (route) {
        return route.remoteHTML;
    }
    return nil;
}

#pragma mark - Private

- (URRoute *)_ur_routeForURI:(NSURL *)uri {
    NSString *uriString = uri.absoluteString;
    if (uriString.length == 0) {
        return nil;
    }
    
    for (URRoute *route in self.routes) {
        if ([route.URIRegex numberOfMatchesInString:uriString options:0 range:NSMakeRange(0, uriString.length)] > 0) {
            return route;
        }
    }
    return nil;
}

- (NSArray *)_ur_routesWithData:(NSData *)data {
    if (data == nil) {
        return nil;
    }
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if (JSON == nil) {
        return nil;
    }
    
    //TODO: key值需要和后台商定
    //页面级别的 route
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSDictionary *item in [JSON objectForKey:@"items"]) {
        [items addObject:[[URRoute alloc] initWithDictionary:item]];
    }
    
    for (NSDictionary *item in [JSON objectForKey:@"partial_items"]) {
        [items addObject:[[URRoute alloc] initWithDictionary:item]];
    }
    return items;
}

- (void)_ur_downloadFilesWithinRoutes:(NSArray *)routes completion:(void (^)(BOOL success))completion {
    dispatch_group_t downloadGroup = nil;
    if (completion) {
        downloadGroup = dispatch_group_create();
    }
    BOOL __block success = YES;
    for (URRoute *route in routes) {
        //如果文件在本地文件存在（可能在缓存，可能在资源文件夹），则不去下载
        if ([[URRouteFileCache sharedInstance] routeFileURLForRemoteURL:route.remoteHTML]) {
            continue;
        }
        if (downloadGroup) {
            dispatch_group_enter(downloadGroup);
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:route.remoteHTML cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
        [[self.session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error || ((NSHTTPURLResponse *)response).statusCode != 200) {
                success = NO;
                if (downloadGroup) { dispatch_group_leave(downloadGroup); }
                
                return;
            }
            
            NSData *data = [NSData dataWithContentsOfURL:location];
            [[URRouteFileCache sharedInstance] saveRouteFileData:data withRemoteURL:response.URL];
            
            if (downloadGroup) {
                dispatch_group_leave(downloadGroup);
            }
        }] resume];
    }
    
    if (downloadGroup) {
        dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
            completion(success);
        });
    }
}

@end
