//
//  MyClassLifeBtnCell.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "MyClassLifeBtnCell.h"

@implementation MyClassLifeBtnCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createView];
    }
    return  self;
}

- (void)createView
{
    self.contentView.backgroundColor = UR_ColorFromValue(0xffffff);
    
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView addSubview:self.zanBtn];
    [self.contentBgView addSubview:self.commentBtn];
    
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8 * AUTO_WIDTH);
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(351 * AUTO_WIDTH, 50 * AUTO_WIDTH));
    }];
    
    [self.zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80 * AUTO_WIDTH);
        make.left.top.bottom.mas_offset(0);
    }];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80 * AUTO_WIDTH);
        make.top.bottom.mas_offset(0);
        make.left.mas_equalTo(self.zanBtn.mas_right);
    }];
    
    [self.zanBtn layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [self.commentBtn layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    
    [self.contentBgView addLineWithStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(351 * AUTO_WIDTH, 0) lineColor:UR_COLOR_LINE lineWidth:0.5];
    [self.contentBgView addLineWithStartPoint:CGPointMake(0, 49.5 * AUTO_WIDTH) endPoint:CGPointMake(351 * AUTO_WIDTH, 49.5 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
    [self.contentBgView addLineWithStartPoint:CGPointMake(80 * AUTO_WIDTH, 15 * AUTO_WIDTH) endPoint:CGPointMake(80 * AUTO_WIDTH, 35 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
    [self.contentBgView addLineWithStartPoint:CGPointMake(160 * AUTO_WIDTH, 15 * AUTO_WIDTH) endPoint:CGPointMake(160 * AUTO_WIDTH, 35 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
}

- (UIView *)contentBgView
{
    if (_contentBgView == nil) {
        _contentBgView = [[UIView alloc]init];
        _contentBgView.backgroundColor = UR_ColorFromValue(0xF4F4F4);
    }
    return _contentBgView;
}

- (UIButton *)zanBtn
{
    if (!_zanBtn) {
        _zanBtn = [UIButton normalBtnWithTitle:@"点赞" titleColor:UR_ColorFromValue(0x666666) titleFont:RegularFont(FontSize14)];
        [_zanBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }
    return _zanBtn;
}

- (UIButton *)commentBtn
{
    if (!_commentBtn) {
        _commentBtn = [UIButton normalBtnWithTitle:@"评论" titleColor:UR_ColorFromValue(0x666666) titleFont:RegularFont(FontSize14)];
        [_commentBtn setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    }
    return _commentBtn;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
