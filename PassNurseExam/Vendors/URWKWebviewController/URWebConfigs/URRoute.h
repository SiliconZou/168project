//
//  URRoute.h
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/27.
//  Copyright © 2017年 chenyong. All rights reserved.
//


/**
 *  根据提供的dictionary获取正则规则和HTML地址
 */

//TODO：路由的具体内容需要和后台协商，包括html地址、路由规则等，目前代码中使用正则表达式来匹配地址

#import <Foundation/Foundation.h>

@interface URRoute : NSObject

@property (nonatomic, readonly) NSRegularExpression *URIRegex;
@property (nonatomic, readonly) NSURL *remoteHTML;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
