//
//  URRouteFileCache.m
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/31.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import "URRouteFileCache.h"
#import "URConfig.h"
#import "NSData+UREncription.h"

static NSString * const RoutesMapFile = @"routes.json";

@implementation URRouteFileCache

+ (URRouteFileCache *)sharedInstance {
    static URRouteFileCache *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[URRouteFileCache alloc] init];
        instance.cachePath = [URConfig routesCachePath];
        instance.resourcePath = [URConfig routesResourcePath];
    });
    return instance;
}

- (instancetype)initWithCachePath:(NSString *)cachePath
                     resourcePath:(NSString *)resourcePath {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - Setter & Getter
- (void)setCachePath:(NSString *)cachePath {
    if (!cachePath) {
        // 默认缓存路径: <Cache>/<bundle identifier>.rubikWebVC
        cachePath = [[[NSBundle mainBundle] bundleIdentifier] stringByAppendingString:@".rubikWebVC"];
    }
    if (![cachePath isAbsolutePath]) {
        cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:cachePath];
    }
    _cachePath = [cachePath copy];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:_cachePath withIntermediateDirectories:YES attributes:@{} error:&error];
    if (error) {
    }
}

- (void)setResourcePath:(NSString *)resourcePath {
    if (!resourcePath && [resourcePath length] > 0) {
        // 默认资源路径: <Bundle>/rubikWebVC
        resourcePath = [[NSBundle mainBundle] pathForResource:@"rubikWebVC" ofType:nil];
    }
    if (![resourcePath isAbsolutePath]) {
        resourcePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:resourcePath];
    }
    _resourcePath = [resourcePath copy];
}

- (void)cleanCache {
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:self.cachePath error:nil];
    [manager createDirectoryAtPath:self.cachePath
       withIntermediateDirectories:YES
                        attributes:@{}
                             error:NULL];
}

#pragma mark - Public
- (void)saveRoutesMapFile:(NSData *)data {
    NSString *filePath = [self.cachePath stringByAppendingPathComponent:RoutesMapFile];
    if (data == nil) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    } else {
        [data writeToFile:filePath atomically:YES];
    }
}

- (NSData *)routesMapFile {
    NSString *filePath = [self.cachePath stringByAppendingPathComponent:RoutesMapFile];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSData dataWithContentsOfFile:filePath];
    }
    
    filePath = [self.resourcePath stringByAppendingPathComponent:RoutesMapFile];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSData dataWithContentsOfFile:filePath];
    }
    
    return nil;
}

- (void)saveRouteFileData:(NSData *)data withRemoteURL:(NSURL *)url {
    NSString *filePath = [self _ur_cachedRouteFilePathForRemoteURL:url];
    if (data == nil) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    } else {
        [data writeToFile:filePath atomically:YES];
    }
}

- (NSData *)routeFileDataForRemoteURL:(NSURL *)url {
    NSString *filePath = [self routeFilePathForRemoteURL:url];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSData dataWithContentsOfFile:filePath];
    }
    
    return nil;
}

- (NSURL *)routeFileURLForRemoteURL:(NSURL *)url {
    if (url == nil) {
        return nil;
    }
    
    NSString *filePath = [self routeFilePathForRemoteURL:url];
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath] ? [NSURL fileURLWithPath:filePath] : nil;
}

#pragma mark - Private
- (NSString *)routeFilePathForRemoteURL:(NSURL *)url {
    //优先从缓存路径中查找
    NSString *filePath = [self _ur_cachedRouteFilePathForRemoteURL:url];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return filePath;
    }
    
    //再从资源路径中查找
    filePath = [self _ur_resourceRouteFilePathForRemoteURL:url];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return filePath;
    }
    
    return nil;
}

- (NSString *)_ur_cachedRouteFilePathForRemoteURL:(NSURL *)url {
    NSString *md5 = [[url.absoluteString dataUsingEncoding:NSUTF8StringEncoding] md5];
    NSString *fileName = [self.cachePath stringByAppendingPathComponent:md5];
    return [fileName stringByAppendingPathExtension:url.pathExtension];
}

- (NSString *)_ur_resourceRouteFilePathForRemoteURL:(NSURL *)url {
    NSString *filename = nil;
    NSArray *pathComps = url.pathComponents;
    if (pathComps.count > 2) { //TODO: 目前取后两位作为文件路径，需要和接口提供方商量路径的定义规范
        filename = [[pathComps subarrayWithRange:NSMakeRange(pathComps.count - 2, 2)] componentsJoinedByString:@"/"];
    } else {
        filename = url.path;
    }
    return [self.resourcePath stringByAppendingPathComponent:filename];
}

@end
