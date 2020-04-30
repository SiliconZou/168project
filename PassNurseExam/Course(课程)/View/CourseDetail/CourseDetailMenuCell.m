//
//  CourseDetailMenuCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/19.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "CourseDetailMenuCell.h"

@implementation CourseDetailMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        self.selectItemSubject = [RACSubject subject];
        self.selectIndex = 0;
    }
    return  self;
}

- (void)createUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.catalogueBtn];
    [self.contentView addSubview:self.assortInfoBtn];
    [self.contentView addSubview:self.problemSolvingBtn];
    
    [self.catalogueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()/3.0, 43 * AUTO_WIDTH));
        make.left.top.bottom.mas_offset(0);
    }];
    [self.assortInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.catalogueBtn);
        make.centerX.mas_offset(0);
        make.centerY.mas_equalTo(self);
    }];
    [self.problemSolvingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.catalogueBtn);
        make.right.mas_offset(0);
        make.centerY.mas_equalTo(self);
    }];
    
    @weakify(self);
    
    [[self.catalogueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.selectIndex = 0;
    }];
    
    [[self.assortInfoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.selectIndex = 1;
    }];
    
    [[self.problemSolvingBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.selectIndex = 2;
    }];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    
    [self.catalogueBtn setTitleColor:selectIndex == 0 ? UR_ColorFromValue(0x9B89FF):UR_ColorFromValue(0x333333) forState:UIControlStateNormal];
    [self.assortInfoBtn setTitleColor:selectIndex == 1 ? UR_ColorFromValue(0x9B89FF):UR_ColorFromValue(0x333333) forState:UIControlStateNormal];
    [self.problemSolvingBtn setTitleColor:selectIndex == 2 ? UR_ColorFromValue(0x9B89FF):UR_ColorFromValue(0x333333) forState:UIControlStateNormal];
    
    [self.selectItemSubject sendNext:@(selectIndex)];
}

- (UIButton *)catalogueBtn
{
    if (!_catalogueBtn) {
        _catalogueBtn = [UIButton normalBtnWithTitle:@"课程目录" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize16)];
    }
    return _catalogueBtn;
}

- (UIButton *)assortInfoBtn
{
    if (!_assortInfoBtn) {
        _assortInfoBtn = [UIButton normalBtnWithTitle:@"配套资料" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize16)];
    }
    return _assortInfoBtn;
}

- (UIButton *)problemSolvingBtn
{
    if (!_problemSolvingBtn) {
        _problemSolvingBtn = [UIButton normalBtnWithTitle:@"问题解答" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize16)];
    }
    return _problemSolvingBtn;
}

@end
