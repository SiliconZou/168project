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
        self.alertView.frame = CGRectMake(0, URScreenHeight()-130*AUTO_WIDTH-50*AUTO_WIDTH, 75*AUTO_WIDTH, 130*AUTO_WIDTH);
    }];
  
}

- (void)createUI
{
    self.alertView.frame = CGRectMake(0, URScreenHeight()-50*AUTO_WIDTH, 75*AUTO_WIDTH, 0);
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.bannedBtn];
    [self.alertView addSubview:self.cutoverLineBtn];

    [self.bannedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35*AUTO_WIDTH, 35*AUTO_WIDTH));
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_offset(15*AUTO_WIDTH);
    }];
    
    [self.cutoverLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35*AUTO_WIDTH, 35*AUTO_WIDTH));
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_offset(80*AUTO_WIDTH);
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

@end
