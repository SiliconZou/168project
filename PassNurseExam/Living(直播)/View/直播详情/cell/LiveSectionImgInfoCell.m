//
//  LiveSectionImgInfoCell.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionImgInfoCell.h"

@implementation LiveSectionImgInfoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.detailImg = [UIImageView new];
    [self.contentView addSubview:self.detailImg];
    
    [self.detailImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(URScreenWidth());
    }];
}


/*
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self.contentView addSubview:self.detailsWebView];
    
    [self.detailsWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(URScreenWidth());
    }];
}

- (void)setImageArr:(NSArray *)imageArr
{    
    _imageArr = imageArr;
    [self loadWebWithImgarr:imageArr];
}

//图片数组，用web加载
- (void)loadWebWithImgarr:(NSArray *)imgs
{
    self.detailsWebView.backgroundColor = [UIColor whiteColor];
    NSString * htmlStr = @"";
    for (int i = 0; i < imgs.count; i++) {
        NSString *str = [NSString stringWithFormat:@"<div style='width:100%%'\"\"><img src=\"%@\" style='width:100%%'/></div>",imgs[i]];
        htmlStr = [NSString stringWithFormat:@"%@%@",htmlStr,str];
    }
    [self.detailsWebView loadHTMLString:htmlStr baseURL:nil];    
}
 
 
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    //获取网页的高度
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error){

        self.detailsWebView.frame = CGRectMake(0, 0, URScreenWidth(), [result floatValue]);
        [self.detailsWebView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo([result floatValue]);
        }];
    }];
}
     
- (WKWebView *)detailsWebView
{
    if (_detailsWebView == nil) {
        _detailsWebView = [[WKWebView alloc] init];
        _detailsWebView.UIDelegate = self;
        _detailsWebView.navigationDelegate = self;
        _detailsWebView.scrollView.scrollEnabled = YES;
        _detailsWebView.scrollView.delegate = self;
    }
    return _detailsWebView;
}
*/

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
