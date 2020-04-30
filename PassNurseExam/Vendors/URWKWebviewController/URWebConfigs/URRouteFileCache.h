//
//  URRouteFileCache.h
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/31.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  `URRouteFileCache` 提供对 Route files 的读取
 *  Route files 包括用于渲染 web 页面的静态 html 文件
 *  机制：优先从本地缓存获取；如果没有，则查询资源文件中是否中存在
 */

@interface URRouteFileCache : NSObject

//cachePath, 如果是相对路径的话，则认为其是相对于应用缓存路径。
@property (nonatomic, copy) NSString *cachePath;

//资源地址, 会在打包应用时，打包进入 ipa。如果是相对路径的话，则认为其是相对于 main bundle 路径。
@property (nonatomic, copy) NSString *resourcePath;

+ (URRouteFileCache *)sharedInstance;

//Route Map File，名字为`routes.json`
- (void)saveRoutesMapFile:(NSData *)data;
- (NSData *)routesMapFile;

//缓存`url`下载下来的资源数据
- (void)saveRouteFileData:(NSData *)data withRemoteURL:(NSURL *)url;
- (NSData *)routeFileDataForRemoteURL:(NSURL *)url;
- (NSURL *)routeFileURLForRemoteURL:(NSURL *)url;

//清理缓存
- (void)cleanCache;

@end
