//
//  AnswerSheetTitleCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/29.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "AnswerSheetTitleCell.h"

@implementation AnswerSheetTitleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.trueTag];
    [self.contentView addSubview:self.trueTagLb];
    [self.contentView addSubview:self.errorTag];
    [self.contentView addSubview:self.errorTagLb];
    [self.contentView addSubview:self.unAnswerdTag];
    [self.contentView addSubview:self.unAnswerdTagLb];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_offset(12 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(25 * AUTO_WIDTH, 25 * AUTO_WIDTH));
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImg.mas_right).offset(5 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.iconImg);
    }];
    
    [self.unAnswerdTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImg);
        make.right.mas_offset(-12 * AUTO_WIDTH);
    }];
    [self.unAnswerdTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25 * AUTO_WIDTH, 25 * AUTO_WIDTH));
        make.centerY.mas_equalTo(self.iconImg);
        make.right.mas_equalTo(self.unAnswerdTagLb.mas_left).offset(-10 * AUTO_WIDTH);
    }];
    [self.errorTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImg);
        make.right.mas_equalTo(self.unAnswerdTag.mas_left).offset(-12 * AUTO_WIDTH);
    }];
    [self.errorTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.unAnswerdTag);
        make.centerY.mas_equalTo(self.iconImg);
        make.right.mas_equalTo(self.errorTagLb.mas_left).offset(-10 * AUTO_WIDTH);
    }];
    [self.trueTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImg);
        make.right.mas_equalTo(self.errorTag.mas_left).offset(-12 * AUTO_WIDTH);
    }];
    [self.trueTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.unAnswerdTag);
        make.centerY.mas_equalTo(self.iconImg);
        make.right.mas_equalTo(self.trueTagLb.mas_left).offset(-10 * AUTO_WIDTH);
    }];
    
}

- (UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"答题卡"]];
    }
    return _iconImg;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"答题卡列表" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _titleLb;
}

- (UIView *)trueTag
{
    if (!_trueTag) {
        _trueTag = [UIView new];
        _trueTag.backgroundColor = UR_ColorFromValue(0x59A2FF);
        _trueTag.layer.cornerRadius = 25/2.0 * AUTO_WIDTH;
        _trueTag.layer.masksToBounds = YES;
        _trueTag.layer.borderColor = UR_ColorFromValue(0x999999).CGColor;
        _trueTag.layer.borderWidth = 0.5;
    }
    return _trueTag;
}

- (UILabel *)trueTagLb
{
    if (!_trueTagLb) {
        _trueTagLb = [UILabel normalLabelWithTitle:@"正确" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _trueTagLb;
}

- (UIView *)errorTag
{
    if (!_errorTag) {
        _errorTag = [UIView new];
        _errorTag.backgroundColor = UR_ColorFromValue(0xFF6161);
        _errorTag.layer.cornerRadius = 25/2.0 * AUTO_WIDTH;
        _errorTag.layer.masksToBounds = YES;
        _errorTag.layer.borderColor = UR_ColorFromValue(0x999999).CGColor;
        _errorTag.layer.borderWidth = 0.5;
    }
    return _errorTag;
}

- (UILabel *)errorTagLb
{
    if (!_errorTagLb) {
        _errorTagLb = [UILabel normalLabelWithTitle:@"错误" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _errorTagLb;
}

- (UIView *)unAnswerdTag
{
    if (!_unAnswerdTag) {
        _unAnswerdTag = [UIView new];
        _unAnswerdTag.backgroundColor = UR_ColorFromValue(0xFFFFFF);
        _unAnswerdTag.layer.cornerRadius = 25/2.0 * AUTO_WIDTH;
        _unAnswerdTag.layer.masksToBounds = YES;
        _unAnswerdTag.layer.borderColor = UR_ColorFromValue(0x999999).CGColor;
        _unAnswerdTag.layer.borderWidth = 0.5;
    }
    return _unAnswerdTag;
}

- (UILabel *)unAnswerdTagLb
{
    if (!_unAnswerdTagLb) {
        _unAnswerdTagLb = [UILabel normalLabelWithTitle:@"未答" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _unAnswerdTagLb;
}

@end
