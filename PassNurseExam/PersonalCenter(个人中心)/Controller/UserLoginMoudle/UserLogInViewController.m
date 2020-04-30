//
//  UserLogInViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "UserLogInViewController.h"

@interface UserLogInViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *forrgetButton;
@property (weak, nonatomic) IBOutlet UIButton *wxButton;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UILabel *leftLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdContentLabel;

@end

@implementation UserLogInViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    self.leftLineLabel.hidden = !is_online ;
    self.rightLineLabel.hidden = !is_online ;
    self.thirdContentLabel.hidden = !is_online ;
    self.wxButton.hidden =!is_online ;
    [self.cViewNav setImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.lblTitle.text = @"用户登录" ;
    self.lblTitle.font = RegularFont(FontSize21);;
    
    self.bgView.layer.cornerRadius = 12.0f ;
    self.bgView.layer.masksToBounds = YES ;
    
    self.logInButton.layer.cornerRadius = 22.0f ;
    self.logInButton.layer.masksToBounds = YES ;
    
    self.registerButton.layer.cornerRadius = 22.0f ;
    self.registerButton.layer.masksToBounds = YES ;
    self.registerButton.layer.borderColor = UR_ColorFromValue(0xFF9785).CGColor;
    self.registerButton.layer.borderWidth = 1.0f ;
    
    self.phoneView.layer.cornerRadius = 15.0f;
    self.phoneView.layer.masksToBounds = YES ;
    self.phoneView.layer.borderWidth = 1.0f ;
    self.phoneView.layer.borderColor = UR_ColorFromValue(0xEAEAEA).CGColor ;

    self.passwordView.layer.cornerRadius = 15.0f;
    self.passwordView.layer.masksToBounds = YES ;
    self.passwordView.layer.borderWidth = 1.0f ;
    self.passwordView.layer.borderColor = UR_ColorFromValue(0xEAEAEA).CGColor ;
    
    self.passwordTextFiled.secureTextEntry = YES ;
    
    WEAKSELF(self) ;

    
    //微信授权成功通知，微信登录
    [[[NSNotificationCenter   defaultCenter] rac_addObserverForName:@"WXLogInNotification" object:nil]  subscribeNext:^(NSNotification * x) {
        NSLog(@"----------------------------------%@",x) ;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [[URCommonApiManager  sharedInstance] sendWXLoginRequestWithCode:x.userInfo[@"code"]?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                if ([[responseDict[@"data"]  allKeys] containsObject:@"is_band"]) {
                    if([responseDict[@"data"][@"is_band"] integerValue]==0){
                        
                        UserWXLogInViewController * logInViewController = [[UserWXLogInViewController  alloc] init];
                        logInViewController.openid = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"openid"]?:@""] ;
                        [weakSelf.navigationController pushViewController:logInViewController animated:YES];
                        
                    } else {
                        
                        URUserInforModel * inforModel = [[URUserInforModel alloc] init] ;
                        inforModel.api_token = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"api_token"]?:@""] ;
                        inforModel.phone = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"phone"]?:@""] ;
                        inforModel.address = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"address"]?:@""] ;
                        inforModel.balance = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"balance"]?:@""] ;
                        inforModel.birthday = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"birthday"]?:@""] ;
                        inforModel.collection_topic = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"collection_topic"]?:@""] ;
                        inforModel.email = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"email"]?:@""] ;
                        inforModel.idStr = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"id"]?:@""] ;
                        inforModel.integral = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"integral"]?:@""] ;
                        inforModel.is_sing = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"is_sing"]?:@""] ;
                        inforModel.is_vip = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"is_vip"]?:@""] ;
                        inforModel.sex = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"sex"]?:@""] ;
                        inforModel.thumbnail = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"thumbnail"]?:@""] ;
                        inforModel.username = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"username"]?:@""] ;
                        
                        inforModel.loginStatus = @"YES" ;
                        
                        [URUserDefaults  standardUserDefaults].userInforModel = inforModel ;
                        
                        [[URUserDefaults  standardUserDefaults] saveAllPropertyAction];
                        
                        userLoginStatus = YES ;
                        
                        [URToastHelper   showErrorWithStatus:[NSString  stringWithFormat:@"%@",responseDict[@"msg"]]] ;
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccessNoti" object:nil];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [weakSelf  dismissViewControllerAnimated:YES completion:^{
                                
                            }];
                        });
                    }
                }
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        });
    }];
    
    //注册
    [[weakSelf.registerButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [weakSelf.navigationController pushViewController:[NSClassFromString(@"UserRegisterViewController") new] animated:YES];
        
        [URURLRouter  sharedURURLRouter].currentViewController.valueBlock = ^(NSDictionary *   value) {
            
            weakSelf.phoneTextFiled.text = [NSString  stringWithFormat:@"%@",value[@"phone"]?:@""] ;
            
            weakSelf.passwordTextFiled.text = [NSString  stringWithFormat:@"%@",value[@"password"]?:@""] ;
            
        } ;
    }];

    //忘记密码
    [[weakSelf.forrgetButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [weakSelf.navigationController pushViewController:[NSClassFromString(@"ForgotPasswordViewController") new] animated:YES];
        
        [URURLRouter  sharedURURLRouter].currentViewController.valueBlock = ^(NSDictionary *   value) {
           
            weakSelf.phoneTextFiled.text = [NSString  stringWithFormat:@"%@",value[@"phone"]?:@""] ;
            
            weakSelf.passwordTextFiled.text = [NSString  stringWithFormat:@"%@",value[@"password"]?:@""] ;
            
        } ;
        
    }];
    
    //普通账号登录
    [[self.logInButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (weakSelf.phoneTextFiled.text.length==0) {
            [URToastHelper    showErrorWithStatus:@"请输入电话号码"] ;
        } else if (weakSelf.phoneTextFiled.text.length!=11){
            [URToastHelper    showErrorWithStatus:@"请输入合法的电话号码"] ;
        } else if (weakSelf.passwordTextFiled.text.length==0){
            [URToastHelper    showErrorWithStatus:@"请输入密码"] ;
        } else if (weakSelf.passwordTextFiled.text.length<6){
            [URToastHelper    showErrorWithStatus:@"请输入大于6位的密码"] ;
        } else {
            
            [[URCommonApiManager  sharedInstance] sendUserLogInRequestWithPhone:weakSelf.phoneTextFiled.text password:weakSelf.passwordTextFiled.text requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                [URToastHelper   showErrorWithStatus:[NSString  stringWithFormat:@"%@",responseDict[@"msg"]]] ;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccessNoti" object:nil];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [weakSelf  dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                });
                
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        }
    }];
    
    //微信第三方登录
    [[self.wxButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [WXManager   sendWXAuthReq] ;
        
    }];
}
- (IBAction)agreeMentBtnAction:(UIButton *)sender {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"zhucexieyi.html" withExtension:nil];
    URWKWebViewController *webVC = [[URWKWebViewController alloc] initWithURI:fileUrl linkUrl:nil];
    webVC.itemTitle = @"用户注册协议";
    [self.navigationController pushViewController:webVC animated:YES];
    
}
- (IBAction)privacyBtnAction:(UIButton *)sender {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"yinsizhengce.html" withExtension:nil];
    URWKWebViewController *webVC = [[URWKWebViewController alloc] initWithURI:fileUrl linkUrl:nil];
    webVC.itemTitle = @"隐私政策";
    [self.navigationController pushViewController:webVC animated:YES];
}


- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    
    NSString*tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if(![string isEqualToString:tem]) {
        return NO;
    }
    return YES;
}

-(void)navLeftPressed{
    
    [self  dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

@end
