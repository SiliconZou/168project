//
//  QuestionBankCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "QuestionBankCell.h"

@implementation QuestionBankCell

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
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.subLb];
    [self.contentView addSubview:self.redView];
    [self.redView setHidden:YES];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45 * AUTO_WIDTH, 45 * AUTO_WIDTH));
        make.left.mas_offset(10 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImg.mas_right).offset(12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.iconImg);
        make.right.mas_offset(-10 * AUTO_WIDTH);
    }];
    [self.subLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.iconImg);
        make.left.mas_equalTo(self.nameLb);
        make.right.mas_offset(-10 * AUTO_WIDTH);
    }];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.right.mas_offset(-20 * AUTO_WIDTH);
        make.bottom.mas_equalTo(self.nameLb.mas_top);
    }];
}

- (void)setModel:(QuestionClassCategoryDataModel *)model
{
    _model = model;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.nameLb.text = model.name ?: @"";
    
//    self.subLb.text = [NSString stringWithFormat:@"共%@%@",model.total ?: @"0",model.unit ?: @""];
    
}

- (UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        _iconImg.layer.cornerRadius = 10 * AUTO_WIDTH;
        _iconImg.layer.masksToBounds = YES;
    }
    return _iconImg;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize17) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _nameLb;
}

- (UILabel *)subLb
{
    if (!_subLb) {
        _subLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0xFF7A21) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentLeft numberLines:1];
        _subLb.adjustsFontSizeToFitWidth = YES;
    }
    return _subLb;
}

-(UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
        _redView.layer.masksToBounds = YES;
        _redView.layer.cornerRadius = 5;
    }
    return _redView;
}

@end
