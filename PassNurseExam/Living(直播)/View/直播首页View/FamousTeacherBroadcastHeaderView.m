//
//  FamousTeacherBroadcastHeaderView.m
//  PassNurseExam
//
//  Created by quchao on 2019/10/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "FamousTeacherBroadcastHeaderView.h"

@implementation FamousTeacherBroadcastHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UR_ColorFromValue(0xffffff) ;
        
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self addSubview:self.nameLb];
    [self addSubview:self.moreBtn];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self);
    }];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self);
    }];
}

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel normalLabelWithTitle:@"名师专场直播推荐" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize19) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _nameLb;
}

- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton normalBtnWithTitle:@"更多>" titleColor:UR_ColorFromValue(0x9B89FF) titleFont:RegularFont(FontSize16)];
    }
    return _moreBtn;
}


@end
