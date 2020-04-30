//
//  MyClassLifeZanCell.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "MyClassLifeZanCell.h"

@implementation MyClassLifeZanCell

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
    
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView addSubview:self.zanImg];
    [self.contentBgView addSubview:self.nameLb];
    
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_offset(0);        make.size.mas_equalTo(CGSizeMake(351 * AUTO_WIDTH, 43 * AUTO_WIDTH));
    }];
    [self.zanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15 * AUTO_WIDTH, 15 * AUTO_WIDTH));
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.contentBgView);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentBgView);
        make.left.mas_equalTo(self.zanImg.mas_right).offset(10 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
    }];
    
    [self.contentBgView addLineWithStartPoint:CGPointMake(0, 42.5 * AUTO_WIDTH) endPoint:CGPointMake(351 * AUTO_WIDTH, 42.5 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
}

- (UIView *)contentBgView
{
    if (_contentBgView == nil) {
        _contentBgView = [[UIView alloc]init];
        _contentBgView.backgroundColor = UR_ColorFromValue(0xF4F4F4);
    }
    return _contentBgView;
}

- (UIImageView *)zanImg
{
    if (!_zanImg) {
        _zanImg = [UIImageView new];
        _zanImg.image = [UIImage imageNamed:@"zan"];
    }
    return _zanImg;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"王春霞，一花一言，萌心天空，小小龙虾，王春霞，一花一言，萌心天空，小小龙虾" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _nameLb;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
