//
//  UnitPracticeDetailQuestionTopicCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/20.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeDetailQuestionTopicCell.h"

@implementation UnitPracticeDetailQuestionTopicCell


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
    [self.contentView addSubview:self.topicLb];
    [self.contentView addSubview:self.answerRateLb];
    
    [self.topicLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.top.mas_offset(10 * AUTO_WIDTH);
    }];
    [self.answerRateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.topicLb.mas_bottom).offset(3 * AUTO_WIDTH);
        make.bottom.mas_offset(-15 * AUTO_WIDTH);
    }];
}

- (UILabel *)topicLb
{
    if (!_topicLb) {
        _topicLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0xFF9600) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _topicLb;
}

- (UILabel *)answerRateLb
{
    if (!_answerRateLb) {
        _answerRateLb = [UILabel normalLabelWithTitle:@" " titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _answerRateLb;
}
 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
