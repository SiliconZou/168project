//
//  CircleViewController.m
//  PassNurseExam
//
//  Created by SiliconZou on 2020/2/10.
//  Copyright © 2020 ucmed. All rights reserved.
//

#import "CircleViewController.h"
#import "URWKWebViewController.h"

@interface CircleViewController ()

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.cBtnLeft.hidden = YES;
//    self.lblTitle.text = @"圈子";
    self.cViewNav.hidden = YES;
    // Do any additional setup after loading the view.
    if (![URUserDefaults  standardUserDefaults].userInforModel.api_token) {
        [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
    } else {
        NSString *circleUrl = [NSString stringWithFormat:@"%@/moments/#/pages/banjishenghuo/banjishenghuo?device=ios&apitoken=%@",HTTPURL,[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@""];
        URWKWebViewController * circleViewController = [[URWKWebViewController alloc] initWithLinkUrl:circleUrl];
        circleViewController.isShowNav = YES;
        circleViewController.isCiecleVC = YES;
        [self addChildViewController:circleViewController];
        [self.view addSubview:circleViewController.view];
        circleViewController.view.frame = self.view.frame;
    }
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LoginSuccessNoti" object:nil] subscribeNext:^(id x) {
        NSString *circleUrl = [NSString stringWithFormat:@"%@/moments/#/pages/banjishenghuo/banjishenghuo?device=ios&apitoken=%@",HTTPURL,[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@""];
        URWKWebViewController * circleViewController = [[URWKWebViewController alloc] initWithLinkUrl:circleUrl];
        circleViewController.isShowNav = YES;
        circleViewController.isCiecleVC = YES;
        [self addChildViewController:circleViewController];
        [self.view addSubview:circleViewController.view];
        circleViewController.view.frame = self.view.frame;
    }];
}
-(void)viewWillAppear:(BOOL)animated {
    if (![URUserDefaults  standardUserDefaults].userInforModel.api_token) {
        [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
    } else {
//        NSString *circleUrl = [NSString stringWithFormat:@"%@/moments/#/pages/banjishenghuo/banjishenghuo?device=ios&apitoken=%@",HTTPURL,[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@""];
//        URWKWebViewController * circleViewController = [[URWKWebViewController alloc] initWithLinkUrl:circleUrl];
//        circleViewController.isShowNav = YES;
//        circleViewController.isCiecleVC = YES;
//        [self addChildViewController:circleViewController];
//        [self.view addSubview:circleViewController.view];
//        circleViewController.view.frame = self.view.frame;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
