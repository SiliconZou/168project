//
//  AskQuestionsView.m
//  PassNurseExam
//
//  Created by qc on 2019/9/15.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "AskQuestionsView.h"


@implementation AskQuestionsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tapPressInAlertViewGesture:)];
        [self addGestureRecognizer:tap];
        [self createUI];
    }
    return self;
}


// 点击其他区域关闭弹窗
- (void)tapPressInAlertViewGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [sender locationInView:nil];
        
        if (![self.alertView pointInside:[self.alertView convertPoint:location fromView:self] withEvent:nil])
        {
            [self dismiss];
        }
    }
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{

        self.alertView.frame = CGRectMake(0, self.mj_h, URScreenWidth(), 50 * AUTO_WIDTH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)createUI
{
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.alertView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
    
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.askTf];
    [self.alertView addSubview:self.commitBnt];
    
    [self.askTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20 *AUTO_WIDTH);
        make.height.mas_equalTo(30 *AUTO_WIDTH);
        make.centerY.mas_equalTo(self.alertView);
        make.right.mas_equalTo(self.commitBnt.mas_left).offset(-15 * AUTO_WIDTH);
    }];
    [self.commitBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60 * AUTO_WIDTH, 30 * AUTO_WIDTH));
        make.centerY.mas_equalTo(self.alertView);
        make.right.mas_offset(-20 *AUTO_WIDTH);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alertView.frame = CGRectMake(0, self.mj_h - 50 * AUTO_WIDTH, URScreenWidth(), 50 * AUTO_WIDTH);
    }];
}

- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, URScreenHeight(), self.mj_h, 50 * AUTO_WIDTH)];
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

- (UITextField *)askTf
{
    if (!_askTf) {
        _askTf = [UITextField new];
        _askTf.textColor = UR_ColorFromValue(0x3333333);
        _askTf.font = RegularFont(FontSize14);
        _askTf.textAlignment = NSTextAlignmentLeft;
        _askTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _askTf;
}

- (UIButton *)commitBnt
{
    if (!_commitBnt) {
        _commitBnt = [UIButton cornerBtnWithRadius:5 title:@"提问" titleColor:[UIColor whiteColor] titleFont:RegularFont(16) backColor:UR_ColorFromValue(0x59A2FF)];
    }
    return _commitBnt;
}

@end
