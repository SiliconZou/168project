//
//  MyClassLifeCommentCell.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "MyClassLifeCommentCell.h"

@implementation MyClassLifeCommentCell

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
    [self.contentBgView addSubview:self.plImg];
    [self.contentBgView addSubview:self.commentLb];
    [self.contentBgView addSubview:self.checkMoreBtn];
    
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_offset(-8 * AUTO_WIDTH);
        make.width.mas_equalTo(351 * AUTO_WIDTH);
    }];
    [self.plImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15 * AUTO_WIDTH, 15 * AUTO_WIDTH));
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_offset(15 * AUTO_WIDTH);
    }];
    [self.commentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.plImg.mas_right).offset(10 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.plImg);
    }];
    [self.checkMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.plImg.mas_right).offset(10 * AUTO_WIDTH);
        make.height.mas_equalTo(20 * AUTO_WIDTH);
        make.top.mas_equalTo(self.commentLb.mas_bottom).offset(8 * AUTO_WIDTH);
    }];
    
    NSString *str = @"一花一言：赞\n一只皮皮匠：👍👍👍👍\n不可一世：棒棒哒";
    
    self.commentLb.attributedText = [NSMutableAttributedString ur_changeColorAndLineSpaceWithTotalString:str color:UR_ColorFromValue(0x630D0A) subStringArray:@[@"一花一言",@"一只皮皮匠",@"不可一世"] lineSpace:5];
}

- (UIView *)contentBgView
{
    if (_contentBgView == nil) {
        _contentBgView = [[UIView alloc]init];
        _contentBgView.backgroundColor = UR_ColorFromValue(0xF4F4F4);
    }
    return _contentBgView;
}

- (UIImageView *)plImg
{
    if (!_plImg) {
        _plImg = [UIImageView new];
        _plImg.image = [UIImage imageNamed:@"pl-xiaoxi"];
    }
    return _plImg;
}

- (UILabel *)commentLb
{
    if (!_commentLb) {
        _commentLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _commentLb;
}

- (UIButton *)checkMoreBtn
{
    if (!_checkMoreBtn) {
        _checkMoreBtn = [UIButton normalBtnWithTitle:@"查看更多评论>" titleColor:UR_ColorFromValue(0x630D0A) titleFont:RegularFont(FontSize14)];
        _checkMoreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _checkMoreBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
