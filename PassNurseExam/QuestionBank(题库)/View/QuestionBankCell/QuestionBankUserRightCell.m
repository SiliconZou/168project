//
//  QuestionBankUserRightCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "QuestionBankUserRightCell.h"

@implementation QuestionBankUserRightCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleBtn];
    [self.contentView addSubview:self.userRightBtn];
    
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_offset(12 * AUTO_WIDTH);
    }];
    [self.userRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(83 * AUTO_WIDTH, 28 * AUTO_WIDTH));
    }];
}

- (UIButton *)titleBtn
{
    if (!_titleBtn) {
        _titleBtn = [UIButton normalBtnWithTitle:@" 会员专享特权" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize17)];
        [_titleBtn setImage:[UIImage imageNamed:@"会员特权"] forState:UIControlStateNormal];
    }
    return _titleBtn;
}

- (UIButton *)userRightBtn
{
    if (!_userRightBtn) {
        _userRightBtn = [UIButton cornerBtnWithRadius:11 * AUTO_WIDTH title:@"会员介绍" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize14) backColor:nil];
        [_userRightBtn setBackgroundImage:[UIImage gradientBackImgWithFrame:CGRectMake(0, 0, 83 * AUTO_WIDTH, 22 * AUTO_WIDTH) startColor:UR_ColorFromValue(0xF0D7A2) endColor:UR_ColorFromValue(0xEFCB86) direction:0] forState:UIControlStateNormal];
    }
    return _userRightBtn;
}

@end
