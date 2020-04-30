//
//  SimulationProgressCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/29.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "SimulationProgressCell.h"

@implementation SimulationProgressCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return  self;
}

- (void)createUI
{
    [self.contentView addSubview:self.progressBgView];
    [self.progressBgView addSubview:self.questionBankTitleLb];
    [self.progressBgView addSubview:self.progressView];
    [self.progressBgView addSubview:self.progressLb];
    [self.progressBgView addSubview:self.countdownLb];

    [self.progressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_equalTo(56 * AUTO_WIDTH);
        make.bottom.mas_offset(-4);
    }];
    [self.questionBankTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_offset(8 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(285 * AUTO_WIDTH, 12 * AUTO_WIDTH));
        make.top.mas_offset(33 * AUTO_WIDTH);
    }];
    [self.progressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.progressView);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.left.mas_equalTo(self.progressView.mas_right).offset(3 * AUTO_WIDTH);
    }];
    [self.countdownLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.questionBankTitleLb);
        make.right.mas_offset(-12 * AUTO_WIDTH).priorityHigh();
        make.left.mas_equalTo(self.questionBankTitleLb.mas_right).offset(3 * AUTO_WIDTH).priorityLow();
    }];
}


- (UIView *)progressBgView
{
    if (!_progressBgView) {
        _progressBgView = [UIView new];
        _progressBgView.backgroundColor = UR_ColorFromValue(0xEEEEEE);
        _progressBgView.layer.shadowColor = UR_ColorFromRGBA(0, 0, 0, 0.29).CGColor;
        _progressBgView.layer.shadowOffset = CGSizeMake(0, 1);
        _progressBgView.layer.shadowOpacity = 1;
    }
    return _progressBgView;
}

- (UILabel *)questionBankTitleLb
{
    if (!_questionBankTitleLb) {
        _questionBankTitleLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _questionBankTitleLb;
}

- (QuestionProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[QuestionProgressView alloc] init];
        _progressView.layer.cornerRadius = 4;
        _progressView.layer.masksToBounds = YES;
    }
    return _progressView;
}

- (UILabel *)progressLb
{
    if (!_progressLb) {
        _progressLb = [UILabel normalLabelWithTitle:@" " titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentRight numberLines:1];
        _progressLb.adjustsFontSizeToFitWidth = YES;
    }
    return _progressLb;
}

- (UILabel *)countdownLb
{
    if (!_countdownLb) {
        _countdownLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentRight numberLines:1];
        _countdownLb.adjustsFontSizeToFitWidth = YES;
    }
    return _countdownLb;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
