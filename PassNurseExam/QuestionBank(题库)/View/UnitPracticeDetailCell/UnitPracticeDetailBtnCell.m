//
//  UnitPracticeDetailBtnCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/14.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeDetailBtnCell.h"

@implementation UnitPracticeDetailBtnCell


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
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.rightBtn];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(22 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(153 * AUTO_WIDTH, 38 * AUTO_WIDTH));
        make.top.mas_offset(20 * AUTO_WIDTH);
        make.bottom.mas_offset(-10 * AUTO_WIDTH);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-22 * AUTO_WIDTH);
        make.size.mas_equalTo(self.leftBtn);
        make.centerY.mas_equalTo(self.leftBtn);
    }];
}

-(UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton cornerBtnWithRadius:38/2.0*AUTO_WIDTH title:@"答案解析" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0x59A2FF)];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton cornerBtnWithRadius:38/2.0*AUTO_WIDTH title:@"求助讨论" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0xFECA91)];
    }
    return _rightBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
