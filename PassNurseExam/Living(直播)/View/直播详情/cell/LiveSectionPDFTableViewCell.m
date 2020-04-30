//
//  LiveSectionPDFTableViewCell.m
//  PassNurseExam
//
//  Created by quchao on 2019/11/18.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionPDFTableViewCell.h"
#import <WebKit/WebKit.h>
#import "WKWebViewJSBridge.h"


@interface LiveSectionPDFTableViewCell ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic,strong) WKWebView * wkWebView;

@property (nonatomic,copy) NSString * linkUrl;


@end

@implementation LiveSectionPDFTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        [self.contentView  addSubview:self.wkWebView];
        [self.wkWebView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0) ;
            make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 280* AUTO_WIDTH));
            make.bottom.mas_equalTo(0) ;
        }] ;
        
    }
    return self ;
}

-(void)setSectionModel:(LiveSectionDetailData1SectionModel *)sectionModel{
    
    _sectionModel = sectionModel ;
    
    self.linkUrl = sectionModel.pdf ? : @"" ;
    
    [self.wkWebView  loadRequest:[NSURLRequest  requestWithURL:[NSURL  URLWithString:sectionModel.pdf?:@""]]] ;

}

-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [WKWebViewJSBridge shareInstance].defaultConfiguration;
        if (@available(iOS 11.0 , *)) {// 解决iOS11 加载微信网址不全的问题
            configuration.preferences.minimumFontSize = 0 ;
        }
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) configuration:configuration];
        [WKWebViewJSBridge bridgeWebView:_wkWebView webVC:self.currentViewController];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        _wkWebView.allowsBackForwardNavigationGestures = YES;
    }
    return _wkWebView ;
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
    
    self.linkUrl = webView.URL.absoluteString;

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    self.linkUrl  = webView.URL.absoluteString;
    
    if([error code] == NSURLErrorCancelled) {
        return;
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.linkUrl  = webView.URL.absoluteString;
    
    if (![self.linkUrl  isEqualToString:self.sectionModel.pdf]) {
        
        URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:self.linkUrl];
        wkWebViewController.hidesBottomBarWhenPushed = YES ;
        [self.currentViewController.navigationController pushViewController:wkWebViewController animated:YES];
    }
}

////HTTPS触发，若需要证书验证可处理，若不需要直接回调
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
//    completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
//}

//解决内存消耗过大时造成的白屏问题
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
