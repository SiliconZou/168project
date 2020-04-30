//
//  SecretVolumeCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/29.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "SecretVolumeCell.h"

@implementation SecretVolumeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self.contentView addSubview:self.bgimg];
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.typeLb];
    [self.contentView addSubview:self.countLb];
    [self.contentView addSubview:self.timeLb];
    
    [self.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5 * AUTO_WIDTH);
        make.right.mas_offset(-5 * AUTO_WIDTH);
        make.centerX.mas_equalTo(self.contentMode);
        make.top.mas_offset(70 * AUTO_WIDTH);
    }];
    [self.typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5 * AUTO_WIDTH);
        make.right.mas_offset(-5 * AUTO_WIDTH);
        make.centerX.mas_equalTo(self.contentMode);
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(2 * AUTO_WIDTH);
    }];
    [self.countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5 * AUTO_WIDTH);
        make.right.mas_offset(-5 * AUTO_WIDTH);
        make.centerX.mas_equalTo(self.contentMode);
        make.top.mas_equalTo(self.typeLb.mas_bottom).offset(2 * AUTO_WIDTH);
    }];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5 * AUTO_WIDTH);
        make.right.mas_offset(-5 * AUTO_WIDTH);
        make.centerX.mas_equalTo(self.contentMode);
        make.top.mas_equalTo(self.countLb.mas_bottom).offset(2 * AUTO_WIDTH);
    }];
}


- (UIImageView *)bgimg
{
    if (!_bgimg) {
        _bgimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"文件袋"]];
        _bgimg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgimg;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"" titleColor:[UIColor whiteColor] font:BoldFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:1];
        _titleLb.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLb;
}

- (UILabel *)typeLb
{
    if (!_typeLb) {
        _typeLb = [UILabel normalLabelWithTitle:@"" titleColor:[UIColor whiteColor] font:RegularFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:1];
        _typeLb.adjustsFontSizeToFitWidth = YES;
    }
    return _typeLb;
}

- (UILabel *)countLb
{
    if (!_countLb) {
        _countLb = [UILabel normalLabelWithTitle:@"" titleColor:[UIColor whiteColor] font:RegularFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:1];
        _countLb.adjustsFontSizeToFitWidth = YES;
    }
    return _countLb;
}

- (UILabel *)timeLb
{
    if (!_timeLb) {
        _timeLb = [UILabel normalLabelWithTitle:@"" titleColor:[UIColor whiteColor] font:RegularFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:1];
        _timeLb.adjustsFontSizeToFitWidth = YES;
    }
    return _timeLb;
}
@end
