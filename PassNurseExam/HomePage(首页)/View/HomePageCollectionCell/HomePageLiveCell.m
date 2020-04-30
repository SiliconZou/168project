//
//  HomePageLiveCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomePageLiveCell.h"

@implementation HomePageLiveCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.header];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.liveNameLb];
    [self.contentView addSubview:self.orderNumLb];
    [self.contentView addSubview:self.orderBtn];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(169 * AUTO_WIDTH, 140 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_offset(60 * AUTO_WIDTH);
    }];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80 * AUTO_WIDTH, 80 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.contentView);
        make.centerY.mas_equalTo(self.bgView.mas_top);
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.header.mas_bottom).offset(-6 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(80 * AUTO_WIDTH, 16 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.contentView);
    }];
    [self.liveNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.bgView).offset(6 * AUTO_WIDTH);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-6 * AUTO_WIDTH);
        make.top.mas_equalTo(self.bgView).offset(53 * AUTO_WIDTH);
    }];
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65 * AUTO_WIDTH, 25 * AUTO_WIDTH));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-6 * AUTO_WIDTH);
        make.top.mas_equalTo(self.bgView.mas_top).offset(97 * AUTO_WIDTH);
    }];
    [self.orderNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(6 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.orderBtn);
        make.right.mas_equalTo(self.orderBtn.mas_left).offset(- 6* AUTO_WIDTH);
    }];
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = UR_ColorFromValue(0xEAF4FF);
        _bgView.layer.cornerRadius = 6;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIImageView *)header
{
    if (!_header) {
        _header = [UIImageView new];
        _header.backgroundColor = UR_COLOR_DISABLE_CLICK;
        _header.layer.cornerRadius = 40 * AUTO_WIDTH;
        _header.layer.masksToBounds = YES;
    }
    return _header;
}

- (UIButton *)time
{
    if (!_time) {
        _time = [UIButton cornerBtnWithRadius:8*AUTO_WIDTH title:@"06.26 13:00" titleColor:UR_ColorFromValue(0xFFFFFF) titleFont:RegularFont(FontSize12) backColor:nil];
        [_time setBackgroundImage:[UIImage gradientBackImgWithFrame:CGRectMake(0, 0, 80* AUTO_WIDTH, 16 * AUTO_WIDTH) startColor:START_COLOR endColor:END_COLOR direction:0] forState:UIControlStateNormal];
        _time.userInteractionEnabled = NO;
    }
    return _time;
}

- (UILabel *)liveNameLb
{
    if (!_liveNameLb) {
        _liveNameLb = [UILabel normalLabelWithTitle:@"直播课程标题标题" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _liveNameLb;
}

- (UILabel *)orderNumLb
{
    if (!_orderNumLb) {
        _orderNumLb = [UILabel normalLabelWithTitle:@"2900预约" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _orderNumLb;
}

- (UIButton *)orderBtn
{
    if (!_orderBtn) {
        _orderBtn = [UIButton cornerBtnWithRadius:12*AUTO_WIDTH title:@"预约" titleColor:UR_ColorFromValue(0xFFFFFF) titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0x9B89FF)];
    }
    return _orderBtn;
}

@end
