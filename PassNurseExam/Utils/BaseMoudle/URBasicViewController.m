//
//  URBasicViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

@interface URBasicViewController ()

@end

@implementation URBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏状态栏的字体颜色为白色
    if (([UIDevice currentDevice].systemVersion.intValue) >= 7){ // 判断是否是IOS7或以上
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
#pragma clang diagnostic pop
    }
    
    
    self.view.backgroundColor = UR_COLOR_BACKGROUND_ALL ;
    
    [self initNavView];
    
    self.navigationController.navigationBar.hidden = YES;  
}

- (void)initNavView{

    //导航栏
    _cViewNav = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, URSafeAreaNavHeight())];
    _cViewNav.image = [UIImage imageNamed:@"nav"];
    _cViewNav.userInteractionEnabled = YES;

    [self.view addSubview:_cViewNav];

    //标题
    _lblTitle  = [[UILabel alloc] initWithFrame:CGRectMake(70, URSafeAreaStateHeight(), [UIScreen mainScreen].bounds.size.width-140, 44)];
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    _lblTitle.font          = BoldFont(18.0f);
    _lblTitle.textColor     = UR_ColorFromValue(0xFFFFFF);
    [_cViewNav addSubview:_lblTitle];
    
    //左按钮
    _cBtnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cBtnLeft setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];//设置导航栏返回键图标
    _cBtnLeft.imageEdgeInsets=UIEdgeInsetsMake(5, 10, 5, 0);
    _cBtnLeft.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [_cBtnLeft addTarget:self action:@selector(navLeftPressed) forControlEvents:UIControlEventTouchUpInside];
    [_cViewNav addSubview:_cBtnLeft];
    [_cBtnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cViewNav);
        make.width.mas_equalTo(33);
        make.centerY.mas_equalTo(_lblTitle);
        make.height.mas_equalTo(33);
    }];
    //右按钮
    _cBtnRight = [UIButton new];
    _cBtnRight.titleLabel.font = [UIFont  systemFontOfSize:17.0f];
    [_cBtnRight addTarget:self action:@selector(navRightPressed:) forControlEvents:UIControlEventTouchUpInside];
    _cBtnRight.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -40) ;
    [_cViewNav addSubview:_cBtnRight];
    [_cBtnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cViewNav);
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(_lblTitle);
        make.height.mas_equalTo(44);
    }];
}


/**
 *  重写Title
 *
 */
- (void)setCSuperTitle:(NSString *)cSuperTitle{
    _cSuperTitle = cSuperTitle ;
    if (cSuperTitle.length > 0){
        _lblTitle.text = cSuperTitle;
    }
}

-(void)setIsNeedLeftIcon:(BOOL)isNeedLeftIcon {
    _isNeedLeftIcon = isNeedLeftIcon ;
    
    //设置导航栏返回键图标
    _cBtnLeft.hidden = isNeedLeftIcon ? NO : YES;
}

/**
 *  导航左按钮事件（默认返回上一页）
 *
 */
- (void)navLeftPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  导航右按钮事件（默认无内容）
 *
 */
- (void)navRightPressed:(id)sender{
    NSLog(@"=> navRightPressed !");
}



- (void)openOnlineWithQQ:(NSString *)qqStr {
    if ( [UIDevice currentDevice].systemVersion.doubleValue>=10.0) {
        NSString *qq=[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqStr];
        NSURL *url = [NSURL URLWithString:qq];
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqStr]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//                    webView.delegate = self;
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }
}
/**
 push跳转方法
 
 @param vcName 控制器名称
 @param viewModel 数据
 */
- (void)pushViewControllerWithString:(NSString *)vcName withModel:(id _Nullable)viewModel
{
    URBasicViewController *vc = [[NSClassFromString(vcName) alloc]init];
    if (![vc isKindOfClass:[URBasicViewController class]]) return;
    vc.viewModel = viewModel;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 退回到指定控制器
 
 @param vcName 控制器名称
 */
- (void)hm_popToViewController:(NSString *)vcName
{
    for (UIViewController * vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[NSClassFromString(vcName) class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 弹起 用户vip权益
 */
- (void)alertUserVipRight
{
    MemberIntroductionAlertView * userAlert = [[MemberIntroductionAlertView alloc] init];
    
    [userAlert showAlertView:^(NSInteger buttonIndex) {
       
        if (buttonIndex==0)
        {
            //课程卡激活
            UserActivationViewController * activeViewController = [[UserActivationViewController alloc] init];
            activeViewController.hidesBottomBarWhenPushed = YES ;
            
            [self.navigationController pushViewController:activeViewController animated:YES];
        } else
        {
            //在线支付
            MemberPayAlertView * payAlertView = [[MemberPayAlertView  alloc] init];
            [payAlertView showAlertView:@{@"buyType":@"1"} finish:^{
                
            }];
        }
    }];
}

-(void)openWebViewWithUrl:(NSString *)urlStr currVC:(UIViewController*)vc {
    NSString *shopUrl = [NSString stringWithFormat:@"%@%@%@",HTTPURL,urlStr,[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@""];
    URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:shopUrl];
    wkWebViewController.hidesBottomBarWhenPushed = YES ;
    wkWebViewController.isShowNav = YES;
    [vc.navigationController pushViewController:wkWebViewController animated:YES];
}

@end
