//
//  MemberIntroductionAlertView.m
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "MemberIntroductionAlertView.h"

@interface MemberIntroductionAlertView ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentView;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,copy) void (^finishBlock)(NSInteger btnIndex);

@end

@implementation MemberIntroductionAlertView

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.delegate = self;
        [tap addTarget:self action:@selector(tapPressInAlertViewGesture:)];
        [self addGestureRecognizer:tap];
        [self initContentView];
    }
    return self;
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.contentView]) {
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
        
        if (![self.contentView pointInside:[self.contentView convertPoint:location fromView:self] withEvent:nil])
        {
            [self dismiss];
        }
    }
}

- (void)initContentView
{
    self.backgroundColor = [UIColor clearColor];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.layer.cornerRadius = 5.0;
    self.contentView.layer.masksToBounds = YES;
    
    UIImage * backgroundImage = [UIImage  imageNamed:@"hyjssss"] ;
    self.contentView.contentMode = UIViewContentModeScaleAspectFill ;
    self.contentView.layer.contents = (__bridge id)backgroundImage.CGImage ;
    
    [self addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(590/2.0 * AUTO_WIDTH, 839/2.0 * AUTO_WIDTH));
    }];
    
    NSLog(@"vip:%@",[URUserDefaults  standardUserDefaults].userInforModel.is_vip);
    
    if (is_online==0) {//未上线
        
        if ([URUserDefaults  standardUserDefaults].userInforModel.is_vip.integerValue==0) { //不是vip
            self.leftBtn = [UIButton backcolorBtnWithTitle:@"您还不是会员，暂无权限" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0xAEEBFE)];
        }
        else { //是vip
            self.leftBtn = [UIButton backcolorBtnWithTitle:@"确定" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0xAEEBFE)];
        }
        [self.contentView addSubview:self.leftBtn];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40 * AUTO_WIDTH);
            make.left.bottom.mas_offset(0);
            make.width.mas_equalTo(590/2.0 * AUTO_WIDTH);
        }];
        
    } else {
        if ([URUserDefaults  standardUserDefaults].userInforModel.is_vip.integerValue==0) {
            self.leftBtn = [UIButton backcolorBtnWithTitle:@"会员卡激活" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0xAEEBFE)];
            [self.contentView addSubview:self.leftBtn];
            [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(40 * AUTO_WIDTH);
                make.left.bottom.mas_offset(0);
            }];
            
            self.rightBtn = [UIButton backcolorBtnWithTitle:@"在线支付" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0x4FC8ED)];
            [self.contentView addSubview:self.rightBtn];
            [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(40 * AUTO_WIDTH);
                make.right.bottom.mas_offset(0);
                make.width.mas_equalTo(self.leftBtn);
                make.left.mas_equalTo(self.leftBtn.mas_right);
            }];
        } else {
            self.leftBtn = [UIButton backcolorBtnWithTitle:@"确定" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0xAEEBFE)];
            [self.contentView addSubview:self.leftBtn];
            [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(40 * AUTO_WIDTH);
                make.left.bottom.mas_offset(0);
                make.width.mas_equalTo(590/2.0 * AUTO_WIDTH);
            }];
        }
    }
    
    _contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    @weakify(self);
    if (is_online==0) {
        [[self.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self dismiss];
        }];
    }else {
        if ([URUserDefaults  standardUserDefaults].userInforModel.is_vip.integerValue==0) {
            [[self.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                @strongify(self);
                self.finishBlock(0);
                [self dismiss];
            }];
            
            [[self.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                @strongify(self);
                self.finishBlock(1);
                [self dismiss];
            }];
        } else {
            [[self.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self);
                [self dismiss];
            }];
        }
    }
}

- (void)showAlertView:(void (^)(NSInteger))clickBlock
{
    self.finishBlock = clickBlock;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.transform = CGAffineTransformMakeScale(1, 1);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }];
}

- (void)dismiss
{
    [self removeFromSuperview];
    self.finishBlock = nil;
}

@end
