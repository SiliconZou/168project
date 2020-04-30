//
//  CourseDetailCatalogueHeader.m
//  PassNurseExam
//
//  Created by qc on 2019/9/19.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "CourseDetailCatalogueHeader.h"

@implementation CourseDetailCatalogueHeader

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
    [self addSubview:self.noLb];
    [self addSubview:self.nameLb];
    [self addSubview:self.icon];
    [self addSubview:self.selectBtn];
    
    [self.noLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.height.mas_equalTo(42 * AUTO_WIDTH);
        make.top.bottom.mas_offset(0);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.noLb.mas_right).offset(2).priorityHigh();
        make.right.mas_offset(-60 * AUTO_WIDTH).priorityLow();
        make.centerY.mas_equalTo(self.noLb);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18 * AUTO_WIDTH, 8 * AUTO_WIDTH));
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.nameLb);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self addLineWithStartPoint:CGPointMake(0, 42 * AUTO_WIDTH) endPoint:CGPointMake(URScreenWidth(), 42 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
}

-(void)setDataModel:(CourseCommonDetailDataModel *)dataModel{
    
    _dataModel = dataModel ;
    
    self.nameLb.text = [NSString  stringWithFormat:@"%@",dataModel.name?:@""] ;
    self.icon.image = [UIImage imageNamed:dataModel.selected ? @"jiantou-up" : @"jiantou-down"];
}

- (UILabel *)noLb
{
    if (!_noLb) {
        _noLb = [UILabel normalLabelWithTitle:@"01" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];;
    }
    return _noLb;
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
