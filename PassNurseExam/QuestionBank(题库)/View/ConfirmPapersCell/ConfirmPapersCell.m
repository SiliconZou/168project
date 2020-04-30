//
//  ConfirmPapersCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/29.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "ConfirmPapersCell.h"

@implementation ConfirmPapersCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self.contentView addSubview:self.cycleImageView];
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.correctValueLb];
    [self.contentView addSubview:self.correctTitleLb];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.answeredNumLb];
    [self.contentView addSubview:self.correctNumLb];
    [self.contentView addSubview:self.timeUsedBtn];
    [self.contentView addSubview:self.answeredNumBtn];
    [self.contentView addSubview:self.correctNumBtn];
    [self.contentView addSubview:self.timeAllBtn];
    [self.contentView addSubview:self.allNumBtn1];
    [self.contentView addSubview:self.allNumBtn2];
    [self.contentView addSubview:self.checkAnswerBtn];

    [self.cycleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(30 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(197 * AUTO_WIDTH, 197 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.contentView);
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.cycleImageView.mas_top).offset(35 * AUTO_WIDTH);
    }];
    [self.correctValueLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.cycleImageView);
    }];
    [self.correctTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.correctValueLb.mas_bottom).offset(0);
    }];
    
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(50 * AUTO_WIDTH);
        make.top.mas_offset(280 * AUTO_WIDTH);
    }];
    [self.answeredNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLb);
        make.top.mas_equalTo(self.timeLb.mas_bottom).offset(25 * AUTO_WIDTH);
    }];
    [self.correctNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLb);
        make.top.mas_equalTo(self.answeredNumLb.mas_bottom).offset(25 * AUTO_WIDTH);
    }];
    
    [self.timeUsedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLb.mas_right).offset(0);
        make.centerY.mas_equalTo(self.timeLb);
        make.width.mas_greaterThanOrEqualTo(80 * AUTO_WIDTH);
    }];
    [self.answeredNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeUsedBtn);
        make.centerY.mas_equalTo(self.answeredNumLb);
    }];
    [self.correctNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeUsedBtn);
        make.centerY.mas_equalTo(self.correctNumLb);
    }];
    
    [self.timeAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeUsedBtn.mas_right).offset(20 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.timeLb);
    }];
    [self.allNumBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeAllBtn);
        make.centerY.mas_equalTo(self.answeredNumLb);
    }];
    [self.allNumBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeAllBtn);
        make.centerY.mas_equalTo(self.correctNumLb);
    }];
    
    [self.checkAnswerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(306 * AUTO_WIDTH, 53 * AUTO_WIDTH));
        make.top.mas_offset(463 * AUTO_WIDTH);
        make.centerX.mas_equalTo(self.contentView);
    }];
}

- (UIImageView *)cycleImageView
{
    if (!_cycleImageView) {
        _cycleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle"]];
    }
    return _cycleImageView;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"模拟考试" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize17) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _titleLb;
}

- (UILabel *)correctValueLb
{
    if (!_correctValueLb) {
        _correctValueLb = [UILabel normalLabelWithTitle:@"0%" titleColor:UR_ColorFromValue(0xFE992A) font:BoldFont(FontSize42) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _correctValueLb;
}

- (UILabel *)correctTitleLb
{
    if (!_correctTitleLb) {
        _correctTitleLb = [UILabel normalLabelWithTitle:@"正确率" titleColor:UR_ColorFromValue(0xFE992A) font:RegularFont(FontSize15) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _correctTitleLb;
}

- (UILabel *)timeLb
{
    if (!_timeLb) {
        _timeLb = [UILabel normalLabelWithTitle:@"答题用时：" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize15) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _timeLb;
}

- (UILabel *)answeredNumLb
{
    if (!_answeredNumLb) {
        _answeredNumLb = [UILabel normalLabelWithTitle:@"已答题数：" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize15) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _answeredNumLb;
}

- (UILabel *)correctNumLb
{
    if (!_correctNumLb) {
        _correctNumLb = [UILabel normalLabelWithTitle:@"正确题数：" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize15) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _correctNumLb;
}

- (UIButton *)timeUsedBtn
{
    if (!_timeUsedBtn) {
        _timeUsedBtn = [UIButton normalBtnWithTitle:@"00分00秒" titleColor:UR_ColorFromValue(0xFE992A) titleFont:RegularFont(FontSize15)];
        [_timeUsedBtn setImage:[UIImage imageNamed:@"正确"] forState:UIControlStateNormal];
        _timeUsedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _timeUsedBtn;
}

- (UIButton *)answeredNumBtn
{
    if (!_answeredNumBtn) {
        _answeredNumBtn = [UIButton normalBtnWithTitle:@"0" titleColor:UR_ColorFromValue(0xFE992A) titleFont:RegularFont(FontSize15)];
        [_answeredNumBtn setImage:[UIImage imageNamed:@"正确"] forState:UIControlStateNormal];
        _answeredNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _answeredNumBtn;
}

- (UIButton *)correctNumBtn
{
    if (!_correctNumBtn) {
        _correctNumBtn = [UIButton normalBtnWithTitle:@"0" titleColor:UR_ColorFromValue(0xFE992A) titleFont:RegularFont(FontSize15)];
        [_correctNumBtn setImage:[UIImage imageNamed:@"正确"] forState:UIControlStateNormal];
        _correctNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _correctNumBtn;
}

- (UIButton *)timeAllBtn
{
    if (!_timeAllBtn) {
        _timeAllBtn = [UIButton normalBtnWithTitle:@"100分钟" titleColor:UR_ColorFromValue(0xFE2A2A) titleFont:RegularFont(FontSize15)];
        [_timeAllBtn setImage:[UIImage imageNamed:@"总共"] forState:UIControlStateNormal];
        _timeAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _timeAllBtn;
}

- (UIButton *)allNumBtn1
{
    if (!_allNumBtn1) {
        _allNumBtn1 = [UIButton normalBtnWithTitle:@"120" titleColor:UR_ColorFromValue(0xFE2A2A) titleFont:RegularFont(FontSize15)];
        [_allNumBtn1 setImage:[UIImage imageNamed:@"总共"] forState:UIControlStateNormal];
        _allNumBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _allNumBtn1;
}

- (UIButton *)allNumBtn2
{
    if (!_allNumBtn2) {
        _allNumBtn2 = [UIButton normalBtnWithTitle:@"120" titleColor:UR_ColorFromValue(0xFE2A2A) titleFont: RegularFont(FontSize15)];
        [_allNumBtn2 setImage:[UIImage imageNamed:@"总共"] forState:UIControlStateNormal];
        _allNumBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _allNumBtn2;
}

- (UIButton *)checkAnswerBtn
{
    if (!_checkAnswerBtn) {
        _checkAnswerBtn = [UIButton cornerBtnWithRadius:53/2.0 title:@"查看答题卡" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize21) backColor:UR_ColorFromValue(0xFECA91)];
    }
    return _checkAnswerBtn;
}

@end
