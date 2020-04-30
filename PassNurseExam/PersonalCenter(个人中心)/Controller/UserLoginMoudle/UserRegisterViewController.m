//
//  UserRegisterViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "UserRegisterViewController.h"

@interface UserRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;

@end

@implementation UserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cViewNav setImage:[UIImage new]];
    self.bgView.layer.cornerRadius = 12.0f ;
    self.bgView.layer.masksToBounds = YES ;
    
    self.registerButton.layer.cornerRadius = 22.0f ;
    self.registerButton.layer.masksToBounds = YES ;
    
    self.codeButton.layer.cornerRadius = 12.0f ;
    self.codeButton.layer.masksToBounds = YES ;
//    [self.codeButton setBackgroundImage:[UIImage  gradientBackImgWithFrame:CGRectMake(0, 0, 83, 26) startColor:START_COLOR endColor:END_COLOR direction:0] forState:UIControlStateNormal];
    
    self.logInButton.layer.cornerRadius = 22.0f ;
    self.logInButton.layer.masksToBounds = YES ;
    self.logInButton.layer.borderColor = UR_ColorFromValue(0xFF8D77).CGColor;
    self.logInButton.layer.borderWidth = 1.0f ;
    
    self.phoneView.layer.cornerRadius = 15.0f;
    self.phoneView.layer.masksToBounds = YES ;
    self.phoneView.layer.borderWidth = 1.0f ;
    self.phoneView.layer.borderColor = UR_ColorFromValue(0xF4F4F4).CGColor ;
    
    self.codeView.layer.cornerRadius = 15.0f;
    self.codeView.layer.masksToBounds = YES ;
    self.codeView.layer.borderWidth = 1.0f ;
    self.codeView.layer.borderColor = UR_ColorFromValue(0xF4F4F4).CGColor ;
    
    self.passwordView.layer.cornerRadius = 15.0f;
    self.passwordView.layer.masksToBounds = YES ;
    self.passwordView.layer.borderWidth = 1.0f ;
    self.passwordView.layer.borderColor = UR_ColorFromValue(0xF4F4F4).CGColor ;
    
    self.passTextField.secureTextEntry = YES ;

    
    WEAKSELF(self) ;
    
    [[self.logInButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [weakSelf.navigationController  popViewControllerAnimated:YES];
        
    }];
    
    [[self.codeButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
        if (weakSelf.phoneTextFiled.text.length==0) {
            [URToastHelper    showErrorWithStatus:@"请输入电话号码"] ;
        } else if (weakSelf.phoneTextFiled.text.length!=11){
            [URToastHelper    showErrorWithStatus:@"请输入合法的电话号码"] ;
        }else {
            
            [[URCommonApiManager  sharedInstance] sendGetVerificationCodeRequestWithPhone:weakSelf.phoneTextFiled.text type:1 requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                [x countDown:59 button:x] ;

            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        }
    }];
    
    [[self.registerButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (weakSelf.codeTextField.text.length==0) {
            [URToastHelper    showErrorWithStatus:@"请输入验证码"] ;
        } else if (weakSelf.passTextField.text.length==0){
            [URToastHelper    showErrorWithStatus:@"请输入密码"] ;
        } else if (weakSelf.passTextField.text.length<6){
            [URToastHelper    showErrorWithStatus:@"请输入大于6位的密码"] ;
        }else {
            
            [[URCommonApiManager  sharedInstance] sendUserRegisterRequestWithPhone:weakSelf.phoneTextFiled.text verificationCode:weakSelf.codeTextField.text password:weakSelf.passTextField.text type:1 requestSuccessBlock:^(id response, NSDictionary *responseDict) {
    
                NSDictionary * returnDict = @{
                                              @"phone":weakSelf.phoneTextFiled.text,
                                              @"password":weakSelf.passTextField.text
                                              } ;
                
                [URToastHelper   showErrorWithStatus:[NSString  stringWithFormat:@"%@",responseDict[@"msg"]]] ;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if (weakSelf.valueBlock) {
                        weakSelf.valueBlock(returnDict) ;
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                });

            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
            
        }
    }];
    
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    
    NSString*tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if(![string isEqualToString:tem]) {
        return NO;
    }
    return YES;
}



@end
