//
//  WKWebViewJSBridge.m
//  WKWebViewJSBridge
//
//  Created by chenyong on 2017/8/1.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import "WKWebViewJSBridge.h"
#import "URWKWebViewController.h"
#import "URWebWidgetManager.h"
#import "UIImage+Utility.h"
#import "URSharedView.h"
NSString * const RbJSBridgeEvent = @"RbJSBridgeEvent";

static WKWebViewJSBridge *manager = nil;

@interface WKWebViewJSBridge ()

@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) URWKWebViewController *webVC;
@property (nonatomic, strong, readwrite) NSString *injectJS;

@end

@implementation WKWebViewJSBridge

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WKWebViewJSBridge alloc] init];
        manager.injectJS = [manager getJsString];
    });
    return manager;
}

#pragma mark - public
+ (void)bridgeWebView:(WKWebView *)webView {
    [WKWebViewJSBridge shareInstance].webView = webView;
}

+ (void)bridgeWebView:(WKWebView *)webView webVC:(UIViewController *)controller {
    [WKWebViewJSBridge shareInstance].webView = webView;
    
    if ([controller isKindOfClass:[URWKWebViewController class]]) {
        [WKWebViewJSBridge shareInstance].webVC = (URWKWebViewController *)controller;
    }
}

- (WKWebViewConfiguration *)defaultConfiguration {
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.allowsInlineMediaPlayback = YES;  //在线播放
//    configuration.selectionGranularity = YES;   //与网页交互, 选择视图
    configuration.processPool = [[WKProcessPool alloc] init];
    configuration.suppressesIncrementalRendering = YES;
    
    configuration.preferences = [[WKPreferences alloc] init];
    configuration.preferences.minimumFontSize = 40;    // 默认为0
    configuration.preferences.javaScriptEnabled = YES;
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    configuration.userContentController = [[WKUserContentController alloc] init];
    WKUserScript *usrScript = [[WKUserScript alloc] initWithSource:[WKWebViewJSBridge shareInstance].injectJS injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [configuration.userContentController addUserScript:usrScript];
    [configuration.userContentController addScriptMessageHandler:[WKWebViewJSBridge shareInstance] name:RbJSBridgeEvent];
    [configuration.userContentController addScriptMessageHandler:self name:@"iosJs"];
    [configuration.userContentController addScriptMessageHandler:self name:@"SelectImg"];
    [configuration.userContentController addScriptMessageHandler:self name:@"showToast"];
    [configuration.userContentController addScriptMessageHandler:self name:@"closeweb"];
    [configuration.userContentController addScriptMessageHandler:self name:@"wxiosPay"];
    [configuration.userContentController addScriptMessageHandler:self name:@"aliiosPay"];
    [configuration.userContentController addScriptMessageHandler:self name:@"uploadImg"];
    [configuration.userContentController addScriptMessageHandler:self name:@"daohang"];
    [configuration.userContentController addScriptMessageHandler:self name:@"webshare"];
    [configuration.userContentController addScriptMessageHandler:self name:@"iosDownload"];
    return configuration;
}

#pragma mark - private
- (NSString *)getJsString {
    NSString *path =[[NSBundle mainBundle] pathForResource:@"URWKWebViewBridge_JS" ofType:@"txt"];
    NSString *handlerJS = [NSString stringWithContentsOfFile:path encoding:kCFStringEncodingUTF8 error:nil];
    return handlerJS;
}

- (void)interactWitMethodName:(NSString *)methodName params:(NSDictionary *)params {
    NSMutableArray *paramArray = [[NSMutableArray alloc] init];
    if (params != nil) {
        [paramArray addObject:params];
    }
    NSString *pureMethodName = methodName;
    methodName = [NSString stringWithFormat:@"%@:",methodName];
    SEL selector =NSSelectorFromString(methodName);
    [URWebWidgetManager ur_performSelectorWithTargetName:pureMethodName selector:selector withObjects:paramArray];
}

- (id)JKperformSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    NSUInteger i = 1;
    
    for (id object in objects) {
        id tempObject = object;
        [invocation setArgument:&tempObject atIndex:++i];
    }
    [invocation invoke];
    
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:RbJSBridgeEvent]) {
        if ([message.body hasPrefix:@"_QUEUE_SET_RESULT&"]) {
            NSString *string = (NSString *)message.body;
            NSString *dataStr = [string substringWithRange:NSMakeRange(18, string.length - 18)];
            NSData *data = [[NSData alloc] initWithBase64EncodedString:dataStr options:0];
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary *)result;
                NSString *methodName = dict[@"func"];
                NSDictionary *params = dict[@"params"];
                NSString *callBackId = dict[@"__callback_id"];
                BOOL needCallback = [dict[@"needCallback"] boolValue];
                
                //把webView和webVC拼进params, 交互方法可能需要该参数
                NSMutableDictionary *sendParams = nil;
                if ([params isKindOfClass:[NSDictionary class]]) {
                    sendParams = [NSMutableDictionary dictionaryWithDictionary:params];
                } else {
                    sendParams = [[NSMutableDictionary alloc] init];
                }
                if (_webView != nil) {
                    [sendParams setObject:_webView forKey:@"webView"];
                }
                if (_webVC != nil) {
                    [sendParams setObject:_webVC forKey:@"webVC"];
                }
        
                if (needCallback) {
                    __weak WKWebView *weakWebView = _webView;
                    __weak __typeof(self) weakSelf = self;
                    void (^callBack)(id response) = ^(id response) {
                        NSString *jsonParameter = [weakSelf jsonParameterWithResponse:response callbackId:callBackId];
                        NSString *js = [NSString stringWithFormat:@"RbJSBridge._handleMessageFromApp('%@');", jsonParameter];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakWebView evaluateJavaScript:js completionHandler:^(id _Nullable data, NSError * _Nullable error) {
                            }];
                        });
                    };
                    [sendParams setObject:callBack forKey:@"callBack"];
                    [self interactWitMethodName:methodName params:sendParams ];
                } else {
                    [self interactWitMethodName:methodName params:sendParams];
                }
            }
        }
    } else if ([message.name isEqualToString:@"iosJs"]) { //返回
        [self.getCurrentVC.navigationController popViewControllerAnimated:YES];
    } else if ([message.name isEqualToString:@"showToast"]) { //扫码
        HomePageScanViewController * scanViewController = [[HomePageScanViewController  alloc] init];
        scanViewController.scanBtnBlock = ^(NSString * _Nonnull scanResult) {
            NSLog(@"扫码结果%@",scanResult);
            NSString *jsName = [NSString stringWithFormat:@"AndroidcallJS('%@')",scanResult];
            [self.webView evaluateJavaScript:jsName completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
                NSLog(@"-- %@  %@", obj, error);
                [self.getCurrentVC.navigationController popViewControllerAnimated:YES];
            }];
        };
        [self.getCurrentVC.navigationController pushViewController:scanViewController animated:YES];
    } else if ([message.name isEqualToString:@"SelectImg"]) { //选择照片
        [self.getCurrentVC selectImageWithAllowsEditing:YES title:@"请选择要上传的图片" completeBlock:^(UIImage *image) {
            UIImage *compressImage = [UIImage ur_imageCompression:image];
            [[URCommonApiManager sharedInstance] sendUploadImageRequestWithFile:compressImage requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                if ([responseDict[@"code"] intValue] == 200) {
                    NSString *jsName = [NSString stringWithFormat:@"AndroidcallJSselectimg('%@')",responseDict[@"data"]];
                    [self.webView evaluateJavaScript:jsName completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
                        NSLog(@"-- %@  %@", obj, error);
                    }];
                }
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        }];
    } else if ([message.name isEqualToString:@"wxiosPay"]) {
        NSDictionary *dic = message.body;
        if (dic != nil && [dic isKindOfClass:[NSDictionary class]]){
            PayReq * request = [[PayReq alloc]init];
            request.partnerId = dic[@"partnerid"];
            request.prepayId = dic[@"prepayid"];;
            request.package = dic[@"package"];;
            request.nonceStr = dic[@"noncestr"];;
            request.timeStamp = (UInt32)[dic[@"timestamp"] integerValue];
            request.sign = dic[@"sign"];
//            [WXApi sendReq:request];
            [WXApi sendReq:request completion:^(BOOL success) {
                NSLog(@"发送微信支付%d",success);
            }];
        }
    } else if ([message.name isEqualToString:@"aliiosPay"]) {
        [[AlipaySDK  defaultService] payOrder:message.body fromScheme:@"EducationAliPaySchme" callback:^(NSDictionary *resultDic) {
            NSLog(@"支付宝支付成功");
        }];
    } else if ([message.name isEqualToString:@"uploadImg"]) {
        [self.getCurrentVC selectImageWithAllowsEditing:YES title:@"请选择要上传的图片" completeBlock:^(UIImage *image) {
            UIImage *compressImage = [UIImage ur_imageCompression:image];
            [[URCommonApiManager sharedInstance] sendUploadImageRequestWithFile:compressImage requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                if ([responseDict[@"code"] intValue] == 200) {
                    NSString *jsName = [NSString stringWithFormat:@"uploadReturn('%@')",responseDict[@"data"]];
                    [self.webView evaluateJavaScript:jsName completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
                        NSLog(@"-- %@  %@", obj, error);
                    }];
                }
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        }];
    } else if ([message.name isEqualToString:@"daohang"]) { //返回
        [self.getCurrentVC.navigationController popViewControllerAnimated:YES];
    } else if ([message.name isEqualToString:@"webshare"]) {
        NSString *pathStr = [NSString stringWithFormat:@"pages/market/market?indexst=%@",message.body];
        NSDictionary *shareInfo = @{@"title":@"招聘",@"descr":@"咸阳招聘",@"shareUrl":@"https://www.baidu.com",@"path":pathStr,@"userName":@"gh_a8bc08217cb8",@"imgName":@"zhaopin"};
        URSharedView *shareView = [[URSharedView alloc] init];
        [shareView shareMiniProgramWithDict:shareInfo];
    } else if ([message.name isEqualToString:@"iosDownload"]) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:message.body]];
        UIImage *image = [UIImage imageWithData:data]; // 取得图片
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

    }
}

#pragma mark 系统的完成保存图片的方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if (error != NULL) {
        msg = @"保存图片失败" ;
    } else {
        msg = @"保存图片成功" ;
    }
    [URToastHelper showErrorWithStatus:msg];
}


- (NSString *)jsonParameterWithResponse:(NSDictionary *)response callbackId:(NSString *)callbackId {
    if (response != nil && callbackId.length > 0) {
        NSDictionary *dict = @{@"__callback_id" : callbackId, @"__params" : response, @"__msg_type" : @"callback"};
        NSData *json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonParameter = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        jsonParameter = [jsonParameter stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
        jsonParameter = [jsonParameter stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        jsonParameter = [jsonParameter stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
        jsonParameter = [jsonParameter stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        jsonParameter = [jsonParameter stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
        jsonParameter = [jsonParameter stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
        jsonParameter = [jsonParameter stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
        jsonParameter = [jsonParameter stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
        return jsonParameter;
    }
    return nil;
}

@end
