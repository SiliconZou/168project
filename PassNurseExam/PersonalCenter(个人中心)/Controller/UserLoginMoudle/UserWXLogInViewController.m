//
//  UserWXLogInViewController.m
//  PassNurseExam
//
//  Created by quchao on 2019/10/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "UserWXLogInViewController.h"

@interface UserWXLogInViewController ()

@property (nonatomic ,strong) UITextField * phoneTextField ;

@property (nonatomic ,strong) UITextField * codeTextField ;


@end

@implementation UserWXLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"绑定手机号码" ;
    
    self.view.backgroundColor = UR_ColorFromValue(0xffffff) ;
    
    UIImageView * iconImageView = [[UIImageView  alloc] initWithImage:[UIImage  imageNamed:@"headimg"]];
    [self.view  addSubview:iconImageView];
    [iconImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30+URSafeAreaNavHeight());
        make.left.mas_equalTo((URScreenWidth()-80)/2) ;
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    UILabel * titleLabel = [[UILabel  alloc] init];
    titleLabel.text = @"绑定手机号码" ;
    titleLabel.font = RegularFont(FontSize19) ;
    titleLabel.textColor = UR_ColorFromValue(0x333333) ;
    titleLabel.textAlignment = NSTextAlignmentCenter ;
    [self.view  addSubview:titleLabel];
    [titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(iconImageView.mas_bottom).mas_offset(30) ;
        make.width.mas_equalTo(URScreenWidth());
    }];
    
    UIView * bgView = [[UIView  alloc] init];
    bgView.layer.cornerRadius = 5.0f ;
    bgView.layer.masksToBounds = YES ;
    bgView.layer.borderWidth = 1.0f ;
    bgView.layer.borderColor = UR_ColorFromValue(0xeeeeee).CGColor ;
    [self.view  addSubview:bgView];
    [bgView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20) ;
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(40) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-40, 40));
    }];
    
    UILabel * numberLabel = [UILabel  normalLabelWithTitle:@"+86" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize15) textAlignment:NSTextAlignmentLeft numberLines:1] ;
    [bgView  addSubview:numberLabel];
    [numberLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10) ;
        make.top.mas_equalTo(5) ;
        make.height.mas_equalTo(30) ;
    }];
    
    self.phoneTextField = [[UITextField  alloc] init];
    self.phoneTextField.placeholder = @"请输入手机号码" ;
    self.phoneTextField.font = RegularFont(FontSize15) ;
    self.phoneTextField.textColor = UR_ColorFromValue(0x333333) ;
    [bgView  addSubview:self.phoneTextField];
    [self.phoneTextField  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberLabel.mas_right).mas_offset(10) ;
        make.top.mas_equalTo(5) ;
        make.size.mas_equalTo(CGSizeMake(200, 30)) ;
    }];
    
    UIView * bottomBgView = [[UIView  alloc] init];
    bottomBgView.layer.cornerRadius = 5.0f ;
    bottomBgView.layer.masksToBounds = YES ;
    bottomBgView.layer.borderWidth = 1.0f ;
    bottomBgView.layer.borderColor = UR_ColorFromValue(0xeeeeee).CGColor ;
    [self.view  addSubview:bottomBgView];
    [bottomBgView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20) ;
        make.top.mas_equalTo(bgView.mas_bottom).mas_offset(20) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-40, 40));
    }];
    
    
    self.codeTextField = [[UITextField  alloc] init];
    self.codeTextField.placeholder = @"请输入验证码" ;
    self.codeTextField.font = RegularFont(FontSize15) ;
    self.codeTextField.textColor = UR_ColorFromValue(0x333333) ;
    [bottomBgView  addSubview:self.codeTextField];
    [self.codeTextField  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5) ;
        make.size.mas_equalTo(CGSizeMake(200, 30)) ;
    }];
    
    UIButton * codeButton = [UIButton  buttonWithType:UIButtonTypeCustom] ;
    [codeButton  setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeButton setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
    [codeButton  setBackgroundColor:NORMAL_COLOR];
    codeButton.titleLabel.font = RegularFont(FontSize14) ;
    codeButton.layer.cornerRadius = 15.0f;
    codeButton.layer.masksToBounds = YES ;
    [[codeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
        if ([NSString  isBlank:self.phoneTextField.text]) {
            [URToastHelper  showErrorWithStatus:@"请输入电话号码"] ;
        } else {
            
            [[URCommonApiManager  sharedInstance] sendBindWxFindCodeRequestWithPhone:self.phoneTextField.text requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                [x countDown:59 button:x] ;
                
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        }
    }];
    [bottomBgView  addSubview:codeButton];
    [codeButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15) ;
        make.top.mas_equalTo(5) ;
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }] ;
    
    UILabel * contentLabel = [UILabel  normalLabelWithTitle:@"确定手机号码,可选择手机号码登录此账号" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:0] ;
    [self.view  addSubview:contentLabel];
    [contentLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50) ;
        make.top.mas_equalTo(bottomBgView.mas_bottom).mas_offset(10) ;
        make.width.mas_equalTo(URScreenWidth()-100) ;
    }];
    
    UIButton * nextButton = [UIButton  buttonWithType:UIButtonTypeCustom] ;
    [nextButton  setTitle:@"绑定账号" forState:UIControlStateNormal];
    [nextButton setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
    [nextButton  setBackgroundColor:NORMAL_COLOR];
    nextButton.titleLabel.font = RegularFont(FontSize15) ;
    nextButton.layer.cornerRadius = 20.0f;
    nextButton.layer.masksToBounds = YES ;
    [[nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([NSString  isBlank:self.codeTextField.text]) {
            [URToastHelper  showErrorWithStatus:@"请输入验证码"] ;
        } else {
            
            [[URCommonApiManager  sharedInstance] sendBindWXRequestWithPhone:self.phoneTextField.text?:@"" code:self.codeTextField.text?:@"" openid:self.openid?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                [URToastHelper   showErrorWithStatus:[NSString  stringWithFormat:@"%@",responseDict[@"msg"]]] ;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccessNoti" object:nil];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self  dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                });
                
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        }
    }];
    [self.view  addSubview:nextButton];
    [nextButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20) ;
        make.top.mas_equalTo(contentLabel.mas_bottom).mas_offset(30) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-40, 40));
    }] ;
    
}


@end
