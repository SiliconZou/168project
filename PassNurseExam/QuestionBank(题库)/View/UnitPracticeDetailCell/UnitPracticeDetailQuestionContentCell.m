//
//  UnitPracticeDetailQuestionContentCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/14.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeDetailQuestionContentCell.h"
 

@implementation UnitPracticeDetailQuestionContentCell


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
    [self.contentView addSubview:self.questionContentLb];
        
    [self.questionContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.top.mas_offset(0);
        make.bottom.mas_offset(-15 * AUTO_WIDTH);
    }];
   
}
 
- (UILabel *)questionContentLb
{
    if (!_questionContentLb) {
        _questionContentLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _questionContentLb;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
