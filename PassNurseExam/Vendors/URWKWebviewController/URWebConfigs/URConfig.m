//
//  URConfig.m
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/27.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import "URConfig.h"
#import "URRouteManager.h"

static NSURL *sRoutesMapURL;
static NSString *sRoutesCachePath;
static NSString *sRoutesResourcePath;
static BOOL sIsCacheEnable = YES;

@implementation URConfig

+ (void)setRoutesMapURL:(NSURL *)routesMapURL {
    @synchronized (self) {
        sRoutesMapURL = routesMapURL;
    }
}

+ (NSURL *)routesMapURL {
    return sRoutesMapURL;
}

+ (void)setRoutesCachePath:(NSString *)routesCachePath {
    @synchronized (self) {
        sRoutesCachePath = routesCachePath;
    }
}

+ (NSString *)routesCachePath {
    return sRoutesCachePath;
}

+ (void)setRoutesResourcePath:(NSString *)routesResourcePath {
    @synchronized (self) {
        sRoutesResourcePath = routesResourcePath;
    }
}

+ (NSString *)routesResourcePath {
    return sRoutesResourcePath;
}

+ (void)setCacheEnable:(BOOL)isCacheEnable {
    @synchronized (self) {
        sIsCacheEnable = isCacheEnable;
    }
}

+ (BOOL)isCacheEnable {
    return sIsCacheEnable;
}

- (void)updateConfig {
    URRouteManager *routeManager = [URRouteManager shareInstance];
    routeManager.routesMapURL = sRoutesMapURL;
    [routeManager setCachePath:sRoutesCachePath];
    [routeManager setResoucePath:sRoutesResourcePath];
}

@end
