//
//  HomePageHeaderView.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomePageHeaderView.h"

@implementation HomePageHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self addSubview:self.nameLb];
    [self addSubview:self.moreBtn];
    [self addSubview:self.signView];
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5 * AUTO_WIDTH);
        make.width.mas_equalTo(4);
        make.height.mas_equalTo(18);
        make.centerY.mas_equalTo(self);
    }];
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
        _nameLb = [UILabel normalLabelWithTitle:@" " titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize19) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _nameLb;
}

- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton normalBtnWithTitle:@"更多>" titleColor:NORMAL_COLOR titleFont:RegularFont(FontSize16)];
    }
    return _moreBtn;
}

- (UIView *)signView
{
    if (!_signView) {
        _signView = [[UIView alloc] init];
        _signView.backgroundColor = NORMAL_COLOR;
    }
    return _signView;
}

@end
