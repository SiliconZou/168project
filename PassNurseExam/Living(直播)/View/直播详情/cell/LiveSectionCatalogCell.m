//
//  LiveSectionCatalogCell.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionCatalogCell.h"

@implementation LiveSectionCatalogCell

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
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.stateBtn];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12 * AUTO_WIDTH);
        make.height.mas_equalTo(15 * AUTO_WIDTH);
        make.top.mas_offset(12*AUTO_WIDTH);
    }];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLb);
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(12*AUTO_WIDTH);
        make.height.mas_equalTo(14 * AUTO_WIDTH);
        make.bottom.mas_offset(-12*AUTO_WIDTH);
    }];
    [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60 *AUTO_WIDTH, 21 * AUTO_WIDTH));
        make.centerY.mas_equalTo(self.timeLb);
        make.right.mas_offset(-12 * AUTO_WIDTH);
    }];
}

- (void)setModel:(LiveSectionDetailData1SectionModel *)model
{
    _model = model;
    
    self.nameLb.text = model.title ?: @"";
    self.timeLb.text = model.time_describe ?: @"";
    
    if ([model.state integerValue] == 1) {
        
        [self.stateBtn  setBackgroundColor:UR_ColorFromValue(0xffb04a)];
        [self.stateBtn  setTitle:@"直播中..." forState:UIControlStateNormal];
        [self.stateBtn  setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
        
    }else if ([model.state integerValue] == 2) {

        if ([NSString  isBlank:model.lb]) {
            [self.stateBtn  setBackgroundColor:UR_ColorFromValue(0xff4141)];
            [self.stateBtn  setTitle:@"已结束" forState:UIControlStateNormal];
            [self.stateBtn  setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
        } else {
           [self.stateBtn  setBackgroundColor:UR_ColorFromValue(0x91f261)];
           [self.stateBtn  setTitle:@"课程回放" forState:UIControlStateNormal];
           [self.stateBtn  setTitleColor:UR_ColorFromValue(0xFFFFFF) forState:UIControlStateNormal];
        }
        
    } else if ([model.state integerValue] == 0){
        
        [self.stateBtn  setBackgroundColor:UR_ColorFromValue(0x4f81ff)];
        [self.stateBtn  setTitle:@"未开始" forState:UIControlStateNormal];
        [self.stateBtn  setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
    }
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
        _nameLb.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _nameLb;
}

- (UILabel *)timeLb
{
    if (!_timeLb) {
        _timeLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize12) textAlignment:NSTextAlignmentLeft numberLines:1];
        _timeLb.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _timeLb;
}

- (UIButton *)stateBtn
{
    if (!_stateBtn) {
        _stateBtn = [UIButton new];
        _stateBtn.titleLabel.font = RegularFont(FontSize12) ;
        _stateBtn.layer.cornerRadius = 2.0f ;
        _stateBtn.layer.masksToBounds = YES ;
    }
    return _stateBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
