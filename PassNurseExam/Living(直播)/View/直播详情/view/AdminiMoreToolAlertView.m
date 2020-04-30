//
//  AdminiMoreToolAlertView.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/20.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "AdminiMoreToolAlertView.h"

@interface AdminiMoreToolAlertView ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,copy) void (^__nullable commitBlock) (NSString*tag);
@property (nonatomic,copy) void (^__nullable cancelBlock) (void);

@end

@implementation AdminiMoreToolAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.delegate = self;
        [tap addTarget:self action:@selector(tapPressInAlertViewGesture:)];
        [self addGestureRecognizer:tap];
        [self createUI];
    }
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.alertView]) {
        return NO;
    }
    return YES;
}

// 点击其他区域关闭弹窗
- (void)tapPressInAlertViewGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [sender locationInView:nil];
        
        if (![self.alertView pointInside:[self.alertView convertPoint:location fromView:self] withEvent:nil])
        {
            self.cancelBlock();
            [self dismiss];
        }
    }
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alertView.frame = CGRectMake(0, URScreenHeight()-50*AUTO_WIDTH, 75*AUTO_WIDTH, 0);

     } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.commitBlock = nil;
        self.cancelBlock = nil;
    }];
}

- (void)showWithBanned:(BOOL)banned cutoverLine:(BOOL)cutoverLine commit:(void(^)(NSString * tag))commit cancel:(void(^)(void))cancel
{
    self.commitBlock = commit;
    self.cancelBlock = cancel;
    
    self.bannedBtn.selected = banned;
    self.cutoverLineBtn.selected = cutoverLine;
 
    [UIView animateWithDuration:0.3 animations:^{
        self.alertView.frame = CGRectMake(0, URScreenHeight()-300*AUTO_WIDTH-50*AUTO_WIDTH, 75*AUTO_WIDTH, 300*AUTO_WIDTH);
    }];
  
}

- (void)createUI
{
    self.alertView.frame = CGRectMake(0, URScreenHeight()-50*AUTO_WIDTH, 75*AUTO_WIDTH, 0);
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.bannedBtn];
    [self.alertView addSubview:self.cutoverLineBtn];
    [self.alertView addSubview:self.delayBtn];
    [self.alertView addSubview:self.nowOverBtn];
    [self.alertView addSubview:self.upSignBtn];
    [self.alertView addSubview:self.upClockinBtn];
    [self.alertView addSubview:self.downSignBtn];
    
    [self.delayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_offset(15*AUTO_WIDTH);
    }];
    [self.nowOverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.delayBtn.mas_bottom).mas_offset(10);
    }];
    [self.upSignBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.nowOverBtn.mas_bottom).mas_offset(10);
    }];
    [self.upClockinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.upSignBtn.mas_bottom).mas_offset(10);
    }];
    [self.downSignBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.upClockinBtn.mas_bottom).mas_offset(10);
    }];
    
    [self.bannedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35*AUTO_WIDTH, 35*AUTO_WIDTH));
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.downSignBtn.mas_bottom).mas_offset(10*AUTO_WIDTH);
    }];
    
    [self.cutoverLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35*AUTO_WIDTH, 35*AUTO_WIDTH));
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.bannedBtn.mas_bottom).mas_offset(10*AUTO_WIDTH);
    }];
    
    @weakify(self);
    [[self.bannedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        if (self.bannedBtn.isSelected == NO) {
            [URAlert   alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"确定开启全体禁言吗？" cancelButtonTitle:@"取消" sureButtonTitles:@"确认" viewController:[NSObject  getCurrentVC] handler:^(NSInteger buttonIndex) {
                if (buttonIndex==1) {
                    self.bannedBtn.selected = !self.bannedBtn.isSelected;
                    self.commitBlock(self.bannedBtn.selected?@"1" : @"2") ;
                }
            }] ;
        } else {
            self.bannedBtn.selected = !self.bannedBtn.isSelected;
            self.commitBlock(self.bannedBtn.selected?@"1" : @"2") ;
        }        
    }];
    
    [[self.cutoverLineBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.cutoverLineBtn.selected = !self.cutoverLineBtn.isSelected;
        
        self.commitBlock(self.cutoverLineBtn.selected?@"3" : @"4") ;

    }];
    
    [[self.delayBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [URAlert   alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"确定延时？" cancelButtonTitle:@"取消" sureButtonTitles:@"确认" viewController:[NSObject  getCurrentVC] handler:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入延时时间" preferredStyle:UIAlertControllerStyleAlert];
                //增加确定按钮；
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  //获取第1个输入框；
                  UITextField *userNameTextField = alertController.textFields.firstObject;
                    self.commitBlock([NSString stringWithFormat:@"201%@",userNameTextField.text]);
                }]];
                
                //增加取消按钮；
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
                
                //定义第一个输入框；
                [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                  textField.placeholder = @"请输入延时时间";
                }];
                
                [[self getCurrentVC] presentViewController:alertController animated:true completion:nil];
            }
        }] ;
    }];
    
    [[self.nowOverBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [URAlert   alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"确定立即下课？" cancelButtonTitle:@"取消" sureButtonTitles:@"确认" viewController:[NSObject  getCurrentVC] handler:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                self.commitBlock(@"202") ;
            }
        }] ;
    }];
    
    [[self.upSignBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [URAlert   alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"确定发起上课签到？" cancelButtonTitle:@"取消" sureButtonTitles:@"确认" viewController:[NSObject  getCurrentVC] handler:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                self.commitBlock(@"101") ;
            }
        }] ;
    }];
    
    [[self.upClockinBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [URAlert   alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"确定发起上课打卡？" cancelButtonTitle:@"取消" sureButtonTitles:@"确认" viewController:[NSObject  getCurrentVC] handler:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                self.commitBlock(@"103") ;
            }
        }] ;
    }];
    
    [[self.downSignBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [URAlert   alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"确定发起下课签到？" cancelButtonTitle:@"取消" sureButtonTitles:@"确认" viewController:[NSObject  getCurrentVC] handler:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                self.commitBlock(@"102") ;
            }
        }] ;
    }];
}

- (UIView *)alertView
{
    if (!_alertView) {
        _alertView = [UIView new];
        _alertView.backgroundColor = UR_ColorFromValue(0xEEEEEE);
        _alertView.layer.cornerRadius = 3*AUTO_WIDTH;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

- (UIButton *)bannedBtn
{
    if (!_bannedBtn) {
        _bannedBtn = [UIButton ImgBtnWithImageName:@"禁言-关闭状态"];
        [_bannedBtn setImage:[UIImage imageNamed:@"禁言-开启状态"] forState:UIControlStateSelected];
    }
    return _bannedBtn;
}

- (UIButton *)cutoverLineBtn
{
    if (!_cutoverLineBtn) {
        _cutoverLineBtn = [UIButton ImgBtnWithImageName:@"切换线路-关闭状态"];
        [_cutoverLineBtn setImage:[UIImage imageNamed:@"切换线路-开启状态"] forState:UIControlStateSelected];
    }
    return _cutoverLineBtn;
}

-(UIButton *)delayBtn {
    if (!_delayBtn) {
        _delayBtn = [UIButton cornerBtnWithRadius:15 title:@"延时" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize11) backColor:UR_ColorFromRGBA(120, 190, 50, 1)];
    }
    return _delayBtn;
}

-(UIButton *)nowOverBtn {
    if (!_nowOverBtn) {
        _nowOverBtn = [UIButton cornerBtnWithRadius:15 title:@"下课" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize11) backColor:UR_ColorFromRGBA(100, 140, 255, 1)];
    }
    return _nowOverBtn;
}

-(UIButton *)upSignBtn {
    if (!_upSignBtn) {
        _upSignBtn = [UIButton ImgBtnWithImageName:@"签到1"];
    }
    return _upSignBtn;
}

-(UIButton *)upClockinBtn {
    if (!_upClockinBtn) {
        _upClockinBtn = [UIButton ImgBtnWithImageName:@"打卡1"];
    }
    return _upClockinBtn;
}

-(UIButton *)downSignBtn {
    if (!_downSignBtn) {
        _downSignBtn = [UIButton ImgBtnWithImageName:@"下课1"];
    }
    return _downSignBtn;
}

@end
