//
//  MyClassLifeTopCell.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "MyClassLifeTopCell.h"

@implementation MyClassLifeTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createView];
    }
    return  self;
}

- (void)createView
{
    self.contentView.backgroundColor = UR_ColorFromValue(0xffffff);
    
    [self.contentView addSubview:self.header];
    [self.contentView addSubview:self.userVip];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.vipLevel];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.contentLb];
   
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(37 * AUTO_WIDTH, 37 * AUTO_WIDTH));
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_offset(23 * AUTO_WIDTH);
    }];
    [self.userVip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(12 * AUTO_WIDTH, 12 * AUTO_WIDTH));
        make.right.bottom.mas_equalTo(self.header);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.header).offset(-2*AUTO_WIDTH);
        make.left.mas_equalTo(self.header.mas_right).mas_offset(12 * AUTO_WIDTH);
    }];
    [self.vipLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLb.mas_right).offset(8 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.nameLb);
        make.right.mas_lessThanOrEqualTo(-12 * AUTO_WIDTH);
    }];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLb);
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(3 * AUTO_WIDTH);
    }];
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.header);
        make.top.mas_equalTo(self.header.mas_bottom).offset(18 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.bottom.mas_offset(-8 * AUTO_WIDTH);
    }];
    
    NSString *str = @"今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识";
    self.contentLb.attributedText = [NSMutableAttributedString ur_changeLineSpaceWithTotalString:str lineSpace:5];
}

- (UIImageView *)header
{
    if (!_header) {
        _header = [UIImageView new];
        _header.backgroundColor = [UIColor lightGrayColor];
        _header.layer.cornerRadius = 37/2.0 * AUTO_WIDTH;
        _header.layer.masksToBounds = YES;
    }
    return _header;
}

- (UIImageView *)userVip
{
    if (!_userVip) {
        _userVip = [UIImageView new];
        _userVip.image = [UIImage imageNamed:@"vip"]; 
    }
    return _userVip;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"小客阿宁" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _nameLb;
}

- (UIImageView *)vipLevel
{
    if (!_vipLevel) {
        _vipLevel = [UIImageView new];
        _vipLevel.image = [UIImage imageNamed:@"level"];
    }
    return _vipLevel;
}

- (UILabel *)timeLb
{
    if (!_timeLb) {
        _timeLb = [UILabel normalLabelWithTitle:@"30分钟前" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _timeLb;
}

- (UILabel *)contentLb
{
    if (!_contentLb) {
        _contentLb = [UILabel normalLabelWithTitle:@"今天学习了初级护理知识" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _contentLb;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
