//
//  DailyQuestionsDetailTopTableViewCell.m
//  PassNurseExam
//
//  Created by 王星琛 on 15/9/2019.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "DailyQuestionsDetailTopTableViewCell.h"


@implementation DailyQuestionsDetailTopTableViewCell


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
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.timeLabel];
    
    [self.topicLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.top.mas_offset(12 * AUTO_WIDTH);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.topicLb.mas_bottom).offset(3 * AUTO_WIDTH);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.topicLb.mas_bottom).offset(3 * AUTO_WIDTH);
        make.bottom.mas_offset(-10 * AUTO_WIDTH);
    }];
}

- (UILabel *)topicLb
{
    if (!_topicLb) {
        _topicLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0xFF9600) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _topicLb;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@" " titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentRight numberLines:1];
    }
    return _nameLb;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel normalLabelWithTitle:@" " titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _timeLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
