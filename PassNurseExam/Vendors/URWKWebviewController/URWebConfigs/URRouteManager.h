//
//  URRouteManager.h
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/27.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class URRoute;

@interface URRouteManager : NSObject

//uri 和 linkUrl 的对应关系表
@property (nonatomic, strong, readonly) NSArray<URRoute *> *routes;
//读取 Routes Map 信息的 URL 地址。路由表应该由服务器提供，也可以在本地提供。
@property (nonatomic, copy) NSURL *routesMapURL;

+ (URRouteManager *)shareInstance;

//设置缓存地址。如果是相对路径的话，则认为其是相对于 Cahce 的路径
- (void)setCachePath:(NSString *)cachePath;

//设置资源地址。如果是相对路径的话，则认为其是相对于 main bundle 的路径。
- (void)setResoucePath:(NSString *)resourcePath;

//查找 uri 对应的本地 html 文件 URL。先查 Cache，再查 Resource
- (NSURL *)localHtmlURLForURI:(NSURL *)uri;

//查找 uri 对应的服务器上 html 文件。
- (NSURL *)remoteHtmlURLForURI:(NSURL *)uri;

/**
 * 立即同步路由表。
 * @param completion 同步完成后的回调，可以为 nil
 */
- (void)updateRoutesWithCompletion:(void (^)(BOOL success))completion;


@end
