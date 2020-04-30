//
//  URConfig.h
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/27.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URConfig : NSObject

//设置 Routes Map URL。
+ (void)setRoutesMapURL:(NSURL *)routesMapURL;

//读取 Routes Map URL。
+ (NSURL *)routesMapURL;

//设置 Route Files 的 Cache URL。
+ (void)setRoutesCachePath:(NSString *)routesCachePath;

//读取 Route Files 的 Cache URL。
+ (NSString *)routesCachePath;

//设置 Route Files 的 Resource Path。
+ (void)setRoutesResourcePath:(NSString *)routesResourcePath;

//读取 Route Files 的 Resource Path。
+ (NSString *)routesResourcePath;

/**
 *  全局设置 URWKWebViewController 是否使用本地缓存
 *  如果使用，优先读取本地缓存的html文件；如果不使用，每次直接获取服务器的html资源
 */
+ (void)setCacheEnable:(BOOL)isCacheEnable;

//缺省是允许缓存的
+ (BOOL)isCacheEnable;

//更新全局配置
- (void)updateConfig;

@end
