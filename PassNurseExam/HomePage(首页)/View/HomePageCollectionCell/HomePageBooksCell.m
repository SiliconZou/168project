//
//  HomePageBooksCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomePageBooksCell.h"

@implementation HomePageBooksCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.bookImgV];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.priceLb];

    [self.bookImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(145 * AUTO_WIDTH, 145 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_offset(15 * AUTO_WIDTH);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.bookImgV);
        make.top.mas_equalTo(self.bookImgV.mas_bottom).offset(12*AUTO_WIDTH);
    }];
    [self.priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.bookImgV);
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(8*AUTO_WIDTH);
    }];
}

- (UIImageView *)bookImgV {
    if (_bookImgV == nil) {
        _bookImgV = [[UIImageView alloc]init];
        _bookImgV.image = [UIImage imageNamed:@"chanpin"];
    }
    return _bookImgV;
}


- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel normalLabelWithTitle:@"2019执业辅导讲义" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
        _nameLb.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLb;
}


-(UILabel *)priceLb
{
    if (!_priceLb) {
        _priceLb = [UILabel normalLabelWithTitle:@"￥99" titleColor:UR_ColorFromValue(0xF9A461) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _priceLb;
}
@end
