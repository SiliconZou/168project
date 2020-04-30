//
//  UnitPracticeDetailOptionsCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/14.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeDetailOptionsCell.h"

 
@implementation UnitPracticeDetailOptionsCell


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
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.noLb];
    [self.contentView addSubview:self.optionsLb];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(15*AUTO_WIDTH, 15*AUTO_WIDTH));
        make.centerY.mas_equalTo(self);
    }];
    [self.noLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn.mas_right).mas_offset(8 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(23 * AUTO_WIDTH, 23 * AUTO_WIDTH));
        make.centerY.mas_equalTo(self);
    }];
    [self.optionsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(60);//mas_equalTo(self.noLb.mas_right).offset(11 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.top.mas_offset(8);
        make.bottom.mas_offset(-8);
    }];
}

- (UILabel *)noLb
{
    if (!_noLb) {
        _noLb = [UILabel borderLabelWithRadius:23/2.0*AUTO_WIDTH borderColor:UR_ColorFromValue(0xCCCCCC) borderWidth:1 title:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _noLb;
}

- (UILabel *)optionsLb
{
    if (!_optionsLb) {
        _optionsLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _optionsLb;
}

-(UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton ImgBtnWithImageName:@"unselect"];
    }
    return _selectBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
