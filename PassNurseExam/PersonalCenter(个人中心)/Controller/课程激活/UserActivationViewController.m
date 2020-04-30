//
//  UserActivationViewController.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/8.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserActivationViewController.h"
#import "UserCardActiveViewController.h"

@interface UserActivationViewController ()

@property (nonatomic,strong) UITextField * codeTextField;

@end

@implementation UserActivationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cViewNav.hidden = YES ;
    
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"扫码激活更便捷"].CGImage;

    UIButton * backButton = [UIButton  buttonWithType:UIButtonTypeCustom] ;
    [backButton setImage:[UIImage  imageNamed:@"返回"] forState:UIControlStateNormal];
    @weakify(self) ;
    [[backButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self) ;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view  addSubview:backButton];
    [backButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20) ;
        make.top.mas_equalTo(40 *AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake(61, 28));
    }];
    
    UIButton * scanButton = [[UIButton  alloc] init]  ;
    [scanButton setImage:[UIImage  imageNamed:@"点击扫码"] forState:UIControlStateNormal];
    [[scanButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        HomePageScanViewController * scanViewController = [[HomePageScanViewController  alloc] init];
        [HomePageViewModel  qrCodeScanWithViewController:self pushViewController:scanViewController];
    }];
    [self.view  addSubview:scanButton];
    [scanButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(300 *AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake(76, 76));
        make.centerX.mas_equalTo(self.view) ;
    }];
    
    UIButton * tipButton = [[UIButton  alloc] init] ;
    [tipButton setImage:[UIImage  imageNamed:@"矩形12拷贝3"] forState:UIControlStateNormal];
    [[tipButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        HomePageScanViewController * scanViewController = [[HomePageScanViewController  alloc] init];
        [HomePageViewModel  qrCodeScanWithViewController:self pushViewController:scanViewController];
    }];
    [self.view  addSubview:tipButton];
    [tipButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scanButton.mas_bottom).mas_offset(-10*AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake(44, 61));
        make.centerX.mas_equalTo(self.view) ;
    }];
    
    UIImageView * codeImageView = [[UIImageView  alloc] initWithImage:[UIImage  imageNamed:@"圆角矩形1-1"]];
    [self.view  addSubview:codeImageView];
    [codeImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40 *AUTO_WIDTH) ;
        make.top.mas_equalTo(tipButton.mas_bottom).mas_offset(40 *AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake(170 *AUTO_WIDTH, 37 *AUTO_WIDTH)) ;
    }];
    
    self.codeTextField = [[UITextField  alloc] init];
    self.codeTextField.placeholder = @"请输入激活码" ;
    [self.view  addSubview:self.codeTextField];
    [self.codeTextField  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50 *AUTO_WIDTH) ;
        make.top.mas_equalTo(codeImageView) ;
        make.size.mas_equalTo(CGSizeMake(150 *AUTO_WIDTH, 37 *AUTO_WIDTH));
    }];
    
    UIButton * activationButton = [[UIButton  alloc] init];
    [activationButton setImage:[UIImage  imageNamed:@"立即激活"] forState:UIControlStateNormal];
    [[activationButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        if ([NSString  isBlank:self.codeTextField.text]) {
            [URToastHelper  showErrorWithStatus:@"请输入激活码"] ;
        } else {
            
            [[URCommonApiManager  sharedInstance] sendGetCardInformationRequestWithToken:[URUserDefaults standardUserDefaults].userInforModel.api_token?:@"" code:[NSString  stringWithFormat:@"%@",self.codeTextField.text] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                UserCardActiveViewController * cardViewController = [[UserCardActiveViewController  alloc] init];
                cardViewController.model = response ;
                cardViewController.dataDict=  responseDict ;
                
                [self.navigationController pushViewController:cardViewController animated:YES];
                
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        }
    }];
    [self.view  addSubview:activationButton];
    [activationButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeImageView);
        make.size.mas_equalTo(CGSizeMake(105, 37));
        make.left.mas_equalTo(codeImageView.mas_right).mas_offset(30 *AUTO_WIDTH) ;
    }];
}



@end
