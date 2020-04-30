//
//  WrongTopicCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "WrongTopicCell.h"

@implementation WrongTopicCell


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
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.wrongrateBtn];
    [self.contentView addSubview:self.finishedNumberBtn];
    [self.contentView addSubview:self.collectBtn];

    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(22 * AUTO_WIDTH, 22 * AUTO_WIDTH));
        make.top.mas_offset(18 * AUTO_WIDTH);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(9 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.icon);
        make.right.mas_offset(-55 * AUTO_WIDTH);
    }];
    [self.wrongrateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15 * AUTO_WIDTH);
        make.top.mas_equalTo(self.icon.mas_bottom).offset(15 * AUTO_WIDTH);
    }];
    [self.finishedNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.wrongrateBtn.mas_right).offset(28 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.wrongrateBtn);
    }];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(35 * AUTO_WIDTH, 55 * AUTO_WIDTH));
    }];
 
    [self.collectBtn layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleTop imageTitleSpace:8];
}

 
- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"错误统计"]];
    }
    return _icon;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"类风湿性关节炎患者的特点" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _nameLb;
}

- (UIButton *)wrongrateBtn
{
    if (!_wrongrateBtn) {
        _wrongrateBtn = [UIButton normalBtnWithTitle:@"错题率" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize14)];
        [_wrongrateBtn setImage:[UIImage imageNamed:@"错题率"] forState:UIControlStateNormal];
    }
    return _wrongrateBtn;
}

- (UIButton *)finishedNumberBtn
{
    if (!_finishedNumberBtn) {
        _finishedNumberBtn = [UIButton normalBtnWithTitle:@"0人已做" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize14)];
        [_finishedNumberBtn setImage:[UIImage imageNamed:@"renqun"] forState:UIControlStateNormal];
    }
    return _finishedNumberBtn;
}

- (UIButton *)collectBtn
{
    if (!_collectBtn) {
        _collectBtn = [UIButton normalBtnWithTitle:@"收藏" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize14)];
        [_collectBtn setImage:[UIImage imageNamed:@"un_collect"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateSelected];
    }
    return _collectBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
