//
//  UnitPracticeDetailAnswerKeysCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/14.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeDetailAnswerKeysCell.h"

@implementation UnitPracticeDetailAnswerKeysCell


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
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLb];
    [self.bgView addSubview:self.contentLb];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10 * AUTO_WIDTH, 12 * AUTO_WIDTH, 10 * AUTO_WIDTH, 12 * AUTO_WIDTH));
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10 * AUTO_WIDTH);
        make.top.mas_offset(10 * AUTO_WIDTH);
    }];
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20 * AUTO_WIDTH);
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(12 * AUTO_WIDTH);
        make.right.mas_offset(-20 * AUTO_WIDTH);
        make.bottom.mas_offset(-10 * AUTO_WIDTH);
    }];
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.layer.borderColor = UR_COLOR_LINE.CGColor;
        _bgView.layer.borderWidth = 0.5;
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"参考答案：" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _titleLb;
}

- (UILabel *)contentLb
{
    if (!_contentLb) {
        _contentLb = [UILabel normalLabelWithTitle:@"【解析】" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _contentLb;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
