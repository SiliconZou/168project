//
//  WKWebViewJSBridge.h
//  WKWebViewJSBridge
//
//  Created by chenyong on 2017/8/1.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WKWebViewJSBridge : NSObject <WKScriptMessageHandler>

@property (nonatomic, strong, readonly) NSString *injectJS;

/**
 *  It a manager handler for URWKWebViewController. It main to receive the javascript message from web,
 *  and divide messages to different kind of widgets. The widgets response to specific work, and do not
 *  need couple with web controller.
 */
+ (instancetype)shareInstance;

/**
 *  The web view need various kind of config. you can choose your own ideas or get a default one providing by us.
 */
- (WKWebViewConfiguration *)defaultConfiguration;

+ (void)bridgeWebView:(WKWebView *)webView;
+ (void)bridgeWebView:(WKWebView *)webView webVC:(UIViewController *)controller;

@end
