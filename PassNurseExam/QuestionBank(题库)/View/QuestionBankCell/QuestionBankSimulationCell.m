//
//  QuestionBankSimulationCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "QuestionBankSimulationCell.h"

@implementation QuestionBankSimulationCell

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
    [self.contentView addSubview:self.titleBtn];
    [self.contentView addSubview:self.examNowBtn];
    
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_offset(12 * AUTO_WIDTH);
    }];
    [self.examNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(83 * AUTO_WIDTH, 28 * AUTO_WIDTH));
    }];
}

- (UIButton *)titleBtn
{
    if (!_titleBtn) {
        _titleBtn = [UIButton normalBtnWithTitle:@" 考前模拟" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize17)];
        [_titleBtn setImage:[UIImage imageNamed:@"moni"] forState:UIControlStateNormal];
    }
    return _titleBtn;
}

- (UIButton *)examNowBtn
{
    if (!_examNowBtn) {
        _examNowBtn = [UIButton borderBtnWithBorderColor:NORMAL_COLOR borderWidth:0.5 cornerRadius:11 * AUTO_WIDTH title:@"开始模考" titleColor:NORMAL_COLOR titleFont:RegularFont(FontSize14)];
    }
    return _examNowBtn;
}
@end
