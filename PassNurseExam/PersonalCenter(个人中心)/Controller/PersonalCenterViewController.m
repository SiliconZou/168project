//
//  PersonalCenterViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalCenterCell.h"
#import "UserSettingViewController.h"
#import "UserInformationViewController.h"
#import "UserMessageViewController.h"
#import "UserIntegralViewController.h"
#import "UserCollectionViewController.h"
#import "MineCourseViewController.h"
#import "UserTestStatisticsViewController.h"
#import "UserDownloadViewController.h"
#import "MyLivingVC.h"
#import "RechargeVC.h"
#import "OnlineCustomerViewController.h"

static NSString * const PersonalCenterCellIdentifier = @"PersonalCenterCellIdentifier";


@interface PersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) URUserInforModel *userInforModel;


@end

@implementation PersonalCenterViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    [self  getUserInformationData] ;
    
}

-(void)getUserInformationData{
    if (userLoginStatus) {
        [[URCommonApiManager  sharedInstance] getUserInformationDataWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
            self.userInforModel = [URUserInforModel   yy_modelWithDictionary:responseDict[@"data"]] ;
            
            [self.tableView  reloadData];
            
        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.cBtnLeft.hidden = YES;
    
    [self.view  addSubview:self.tableView];
    
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LoginSuccessNoti" object:nil] subscribeNext:^(id x) {
        [self getUserInformationData];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"RefreshUserCenterNoti" object:nil] subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonalCenterCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.currentViewController = self ;
    cell.userInforModel = self.userInforModel ;
    @weakify(self);
    cell.selectedButtonBlock = ^(NSInteger tag) {
        NSLog(@"点击的按钮的tag:%ld",(long)tag) ;
        
        if (userLoginStatus)
        {
            @strongify(self);
            if (tag==0)
            {
                HomePageScanViewController * scanViewController = [[HomePageScanViewController  alloc] init];
                [HomePageViewModel  qrCodeScanWithViewController:self pushViewController:scanViewController];
            }
            else if (tag==1)
            {
                UserSettingViewController * settingViewController =[[UserSettingViewController  alloc] init];
                settingViewController.hidesBottomBarWhenPushed = YES ;
                [self.navigationController pushViewController:settingViewController animated:YES];
            }
            else if (tag ==2)//消息
            {
               
                
                UserMessageViewController * messageViewController =[[UserMessageViewController  alloc] init];
                messageViewController.hidesBottomBarWhenPushed = YES ;
                [self.navigationController pushViewController:messageViewController animated:YES];
            }
            else if (tag==3){
                
            }
            else if (tag==4 || tag==5 || tag==6)
            {
                if (is_online == 1) {
                    UserInformationViewController * informationViewController =[[UserInformationViewController  alloc] init];
                    informationViewController.hidesBottomBarWhenPushed = YES ;
                    [self.navigationController pushViewController:informationViewController animated:YES];
                }
            }
            else if (tag==7)//签到
            {
                [[URCommonApiManager  sharedInstance] sendUserSignInRequestWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                    
                    [self  getUserInformationData] ;
                    
                } requestFailureBlock:^(NSError *error, id response) {
                    
                }];
                
            }
            else if (tag==23)// 积分
            {
                UserIntegralViewController * integralViewController =[[UserIntegralViewController  alloc] init];
                integralViewController.hidesBottomBarWhenPushed = YES ;
                [self.navigationController pushViewController:integralViewController animated:YES];
            }
            else if (tag==24)// 考题收藏
            {
                UserCollectionViewController * collectionViewController =[[UserCollectionViewController  alloc] init];
                collectionViewController.hidesBottomBarWhenPushed = YES ;
                [self.navigationController pushViewController:collectionViewController animated:YES];
            }
            else if (tag==8)// 是否是vip
            {
                [self alertUserVipRight];                
            }
            else if (tag==9)// 分享
            {
                URSharedView * sharedView= [[URSharedView  alloc] init];
                URSharedModel * shareModel = [[URSharedModel alloc] init];
                shareModel.url = [NSString  stringWithFormat:@"http://edu.168wangxiao.cn/shareApp?invite_code=%@",self.userInforModel.invite_code] ;
                shareModel.descr = @"168网校";
                shareModel.title = @"推荐168网校给好友，邀请好友得奖励";
                shareModel.thumbImage = @"AppIcon";
                [sharedView  urShowShareViewWithDXShareModel:shareModel shareContentType:URShareContentTypeImage];
            }
            else if (tag==10)//我的课程
            {
                if (is_online == 0) {
                    [self openOnlineWithQQ];
                } else {
                    MineCourseViewController * courseViewController =[[MineCourseViewController  alloc] init];
                    courseViewController.hidesBottomBarWhenPushed = YES ;
                    [self.navigationController pushViewController:courseViewController animated:YES];
                }
            }
            else if (tag == 11)//我的直播
            {
                if (is_online == 0) {
                    [self openWebViewWithUrl:@"/resume/#/?device=ios&token=" currVC:self];
                } else {
                    MyLivingVC *vc = [[MyLivingVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES ;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
             else if (tag==12)//我的下载
            {
                UserDownloadViewController * downloadViewController = [[UserDownloadViewController  alloc] init];
                downloadViewController.hidesBottomBarWhenPushed = YES ;
                
                [self.navigationController  pushViewController:downloadViewController animated:YES];
            }
            else if (tag==13)//考试统计
            {
                UserTestStatisticsViewController *  testStatisticsViewController = [[UserTestStatisticsViewController  alloc] init];
                testStatisticsViewController.hidesBottomBarWhenPushed = YES ;
                [self.navigationController pushViewController:testStatisticsViewController animated:YES];
            }
            else if (tag==15)//课程激活
            {
                if (is_online==0) {
                    [URToastHelper  showErrorWithStatus:@"该功能暂未开放"] ;
                } else {
                    UserActivationViewController *  activationViewController = [[UserActivationViewController  alloc] init];
                    activationViewController.hidesBottomBarWhenPushed = YES ;
                    [self.navigationController pushViewController:activationViewController animated:YES];
                }
               
            }
            else if (tag==17)//在线客服
            {
                OnlineCustomerViewController *lineVC = [[OnlineCustomerViewController alloc] init];
                lineVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
                [self presentViewController:lineVC animated:NO completion:nil];
//                [self openOnlineWithQQ];
            }
            else if (tag ==22)//退出登录
            {
                [URAlert  alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"是否要退出当前账号" cancelButtonTitle:@"再想想" sureButtonTitles:@"退出登录" viewController:self handler:^(NSInteger buttonIndex) {
                    if (buttonIndex==1) {
                        
                        userLoginStatus = NO ;
                        [[URUserDefaults  standardUserDefaults] deleteAllPropertyAction];
                                                
                        [self.tableView  reloadData];
                        
                    }
                }] ;
            } else if (tag==16){
                 
                NSString *shopUrl = [NSString stringWithFormat:@"%@/distribution/#/index?device=ios&token=%@",HTTPURL,[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@""];
                URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:shopUrl];
                wkWebViewController.hidesBottomBarWhenPushed = YES ;
                wkWebViewController.isShowNav = YES;
                [self.navigationController pushViewController:wkWebViewController animated:YES];
            } else if (tag == 14) {
                [self openWebViewWithUrl:@"/resume/#/?device=ios&token=" currVC:self];
            } else if (tag == 25) {
                if (is_online == 0) {
                    UserInformationViewController * informationViewController =[[UserInformationViewController  alloc] init];
                    informationViewController.hidesBottomBarWhenPushed = YES ;
                    [self.navigationController pushViewController:informationViewController animated:YES];
                } else {
                    RechargeVC * chargeViewController = [[RechargeVC  alloc] init] ;
                    chargeViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:chargeViewController animated:YES];
                }
            } else if (tag == 100) {
                [self openWebViewWithUrl:@"/mall/#/index/shopping?device=ios&token=" currVC:self];
            } else if (tag == 101) {
                [self openWebViewWithUrl:@"/mall/#/coupon?device=ios&token=" currVC:self];
            } else if (tag == 102) {
                [self openWebViewWithUrl:@"/mall/#/order?device=ios&token=" currVC:self];
            } else if (tag == 103) {
                [self openWebViewWithUrl:@"/mall/#/address?device=ios&token=" currVC:self];
            }
        } else {
                        
            [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
        }
    } ;
    return cell;
}

- (void)openOnlineWithQQ {
    if ( [UIDevice currentDevice].systemVersion.doubleValue>=10.0) {
        NSString *qq=[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQ];
        NSURL *url = [NSURL URLWithString:qq];
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQ]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//                    webView.delegate = self;
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 44.0f;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
        [_tableView registerNib:[UINib nibWithNibName:@"PersonalCenterCell" bundle:nil] forCellReuseIdentifier:PersonalCenterCellIdentifier];
    }
    return _tableView;
}

@end
