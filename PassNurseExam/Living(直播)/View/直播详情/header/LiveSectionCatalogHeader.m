//
//  LiveSectionCatalogHeader.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionCatalogHeader.h"

@implementation LiveSectionCatalogHeader


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return  self;
}

- (void)createUI
{
    self.backgroundColor = UR_ColorFromRGB(229, 241, 254);

    [self addSubview:self.nameLb];
    [self addSubview:self.icon];
    [self addSubview:self.selectBtn];
    
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.right.mas_equalTo(self.icon.mas_left).mas_offset(-10 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18 * AUTO_WIDTH, 8 * AUTO_WIDTH));
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.nameLb);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo(43*AUTO_WIDTH);
    }];
    
    [self addLineWithStartPoint:CGPointMake(0, 42 * AUTO_WIDTH) endPoint:CGPointMake(URScreenWidth(), 42 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
}

- (void)setModel:(LiveSectionDetailData1Model *)model
{
    _model = model;
    self.nameLb.text = model.title ?: @"";
    self.icon.image = [UIImage imageNamed:model.open ? @"jiantou-up" : @"jiantou-down"];
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"01真题全解析基础护理知识" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];;
    }
    return _nameLb;
}

- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"jiantou-zhankai"];
    }
    return _icon;
}

- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton new];
    }
    return _selectBtn;
}

@end
