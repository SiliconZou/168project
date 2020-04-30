//
//  URWKWebViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URWKWebViewController.h"
#import "NSURLProtocol+WebKitSupport.h"
#import <WebKit/WebKit.h>
#import "WKWebViewJSBridge.h"
#import "URRouteManager.h"
#import "URConfig.h"

static void *URWkWebViewContext = &URWkWebViewContext;


@interface URWKWebViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, copy, readwrite) NSURL *uri;
@property (nonatomic, strong) NSString *currLinkUrl;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation URWKWebViewController{
    NSUInteger _injectTimerFlag;
    CGFloat web_y;
    CGFloat web_H;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(title))];
}

- (instancetype)initWithLinkUrl:(NSString *)linkUrl {
    return [self initWithURI:[NSURL  URLWithString:@""] linkUrl:linkUrl];
}

- (instancetype)initWithURI:(NSURL *)uri linkUrl:(NSString *)linkUrl {
    if (self) {
        self.uri = uri;
        self.linkUrl = linkUrl;
        self.currLinkUrl = self.linkUrl;
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isShowNav) {
        [self.cViewNav setHidden:YES];
        web_y = URSafeAreaStateHeight();
    } else {
        [self.cViewNav setHidden:NO];
        web_y = URSafeAreaNavHeight();
    }
    if (_isCiecleVC) {
        web_H = URSafeAreaTabBarHeight();
    } else {
        web_H = 0;
    }
    if (_isNews) {
        [self.cBtnRight setTitle:@"收藏" forState:UIControlStateNormal];
    }
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    self.view.backgroundColor = [UIColor whiteColor];
    //WKWebView注册NSURLProtocol拦截请求会导致post请求的body被清空，目前业务不需要拦截请求，暂时先不开放该功能
    //    [self registerURLProtocol];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self loadWebView];
}

//-(void)navLeftPressed{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}
-(void)navRightPressed:(id)sender {
    NSString *idStr = [self.linkUrl substringFromIndex:self.linkUrl.length-2];
    [[URCommonApiManager sharedInstance] collectArticleWithArticleId:idStr token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        [URToastHelper showErrorWithStatus:responseDict[@"msg"]];
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
    //WKWebView注册NSURLProtocol拦截请求会导致post请求的body被清空，目前业务不需要拦截请求，暂时先不开放该功能
    //    [self registerURLProtocol];
    
    //解决内存消耗过大引起的白屏问题
    if (self.webView.title == nil) {
        [self.webView reload];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    //禁止缩放
    [self.webView evaluateJavaScript:@" $('meta[name=description]').remove(); $('head').append( '<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">' );" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSLog(@"-- %@  %@", obj, error);
    }];
}

- (void)registerURLProtocol {
    for (NSString* scheme in @[@"http", @"https"]) {
        [NSURLProtocol wk_registerScheme:scheme];
    }
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
//    if (@available(iOS 11.0, *)) {
//        CGRect frame = self.webView.frame;
//        frame.origin.x = self.view.safeAreaInsets.left;
//        frame.size.width = self.view.frame.size.width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right;
//        frame.size.height = self.view.frame.size.height - self.view.safeAreaInsets.bottom;
//        self.webView.frame = frame;
//    }
}

-(void)setItemTitle:(NSString *)itemTitle{
    _itemTitle = itemTitle ;
    
    self.lblTitle.text = self.itemTitle ;
}

#pragma mark - Public

- (void)gotoRootViewController {
    if ([self.navigationController.viewControllers.firstObject isKindOfClass:[UITabBarController class]]) {
        UITabBarController *navigationController = (UITabBarController *)self.navigationController.viewControllers.firstObject;
        if (navigationController.selectedIndex != 0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            navigationController.selectedIndex = 0;
        }
    } else if ([self.navigationController.viewControllers.firstObject isKindOfClass:[UIViewController class]]) {
        if (self.navigationController.viewControllers.count == 1) {
            [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.linkUrl]]];
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

#pragma mark - Observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        self.progressView.alpha = 1.0f;
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
        
        if (self.webView.estimatedProgress > 0.999f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))] && object == self.webView) {
        if (self.itemTitle.length>0) {
            self.lblTitle.text = self.itemTitle ;
        } else {
            self.lblTitle.text = self.webView.title;
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKNavigationDelegate
//类比webView的shouldStartLoadWithRequest方法
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        //可增加域名判断, 对跨域手动跳转
        decisionHandler(WKNavigationActionPolicyAllow);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    _currLinkUrl = webView.URL.absoluteString;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    _currLinkUrl = webView.URL.absoluteString;
    
    //一个页面没有被完全加载之前收到下一个请求，此时迅速会出现此error,error=-999。此时可能已经加载完成，则忽略此error，继续进行加载。
    if([error code] == NSURLErrorCancelled) {
        return;
    }
    
    UIButton *bgView = [[UIButton alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView addTarget:self action:@selector(reloadWebView) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:bgView aboveSubview:self.webView];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake((self.view.frame.size.width - 100)/2, (self.view.frame.size.height - 100)/2 - 50, 100, 100);
    imgView.image = [UIImage imageNamed:@"ur_mainview_refresh"];
    [bgView addSubview:imgView];
    
    UILabel *refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 300)/2, CGRectGetMaxY(imgView.frame), 300, 50)];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    refreshLabel.text = @"网络出错，轻触屏幕重新加载";
    refreshLabel.font = [UIFont systemFontOfSize:20.0f];
    refreshLabel.textColor = [UIColor lightGrayColor];
    [bgView addSubview:refreshLabel];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    _currLinkUrl = webView.URL.absoluteString;
    [self.navigationItem setRightBarButtonItem:nil];
    self.progressView.hidden = NO;
    [self handleWKWebViewBusinessWithWebView:webView];
}

////HTTPS触发，若需要证书验证可处理，若不需要直接回调
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
//    completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
//}

//解决内存消耗过大时造成的白屏问题
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}

#pragma mark - Private
- (void)loadWebView {
    __weak typeof(self) weakSelf = self;
    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSString *userAgent = result;
        if (![result hasSuffix:@" MonkeyCenter/1.0.0 rubikui"]) {
            NSString *newUserAgent = [userAgent stringByAppendingString:@" MonkeyCenter/1.0.0 rubikui"];
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":newUserAgent}];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        NSURL *requestURL = [self requestURLWithURI:self.uri linkUrl:self.linkUrl];
        if (!self.linkUrl) {
            requestURL = self.uri;
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [strongSelf.webView loadRequest:request];
    }];
}

- (void)reloadWebView {
    __weak typeof(self) weakSelf = self;
    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSString *userAgent = result;
        if (![result hasSuffix:@" MonkeyCenter/1.0.0 rubikui"]) {
            NSString *newUserAgent = [userAgent stringByAppendingString:@" MonkeyCenter/1.0.0 rubikui"];
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":newUserAgent}];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        NSURL *requestURL = [self requestURLWithURI:self.uri linkUrl:_currLinkUrl];
        if (!self.linkUrl) {
            requestURL = self.uri;
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [strongSelf.webView loadRequest:request];
    }];
}

- (NSURL *)requestURLWithURI:(NSURL *)uri linkUrl:(NSString *)linkUrl {
    if (!linkUrl) {
        //没有提供linkUrl，使用本地html文件或者服务器html文件
        linkUrl = [[URRouteManager shareInstance] remoteHtmlURLForURI:self.uri].absoluteString;
        if ([URConfig isCacheEnable]) {
            NSURL *localURL = [[URRouteManager shareInstance] localHtmlURLForURI:self.uri];
            if (localURL) {
                linkUrl = localURL.absoluteString;
            }
        }
    }
    NSString *uriText = uri.absoluteString.stringByRemovingPercentEncoding;
    // 把 uri 的原始文本所有内容全部 escape。
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@""];
    uriText = [uriText stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    return  [NSURL URLWithString:[NSString stringWithFormat:@"%@", linkUrl]];
}

- (void)handleWKWebViewBusinessWithWebView:(WKWebView *)webView {
    if ([webView.URL.absoluteString hasPrefix:@"tel:"]) {
        [[UIApplication sharedApplication] openURL:webView.URL];
    }
}


#pragma mark - Lazy init
- (WKWebView *)webView {
    if (_webView == nil) {
        WKWebViewConfiguration *configuration = [WKWebViewJSBridge shareInstance].defaultConfiguration;
        if (@available(iOS 11.0 , *)) {// 解决iOS11 加载微信网址不全的问题
            configuration.preferences.minimumFontSize = 0 ;
        }
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, web_y, self.view.frame.size.width, self.view.frame.size.height - web_y - web_H) configuration:configuration];
        [WKWebViewJSBridge bridgeWebView:_webView webVC:self];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        [_webView sizeToFit];
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:URWkWebViewContext];
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(title)) options:NSKeyValueObservingOptionNew context:URWkWebViewContext];
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, URSafeAreaNavHeight()+1, self.view.bounds.size.width, 3);
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = UR_ColorFromValue(0x22a7f0);
    }
    return _progressView;
}


@end
