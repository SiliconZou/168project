//
//  HomePageClassifyCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomePageClassifyCell.h"

@implementation HomePageClassifyCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.toolImgV];
    [self.contentView addSubview:self.nameLb];
    
    [self.toolImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(47 * AUTO_WIDTH, 47 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_offset(15 * AUTO_WIDTH);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.toolImgV.mas_bottom).offset(10*AUTO_WIDTH);
    }];
    
}

- (void)setRow:(NSInteger)row
{
    _row = row;
    self.toolImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"classify_icon%ld",is_online == 0 ? row+3 : row+1]];
    //,@"求职招聘",@"学历教育",@"在线商城",@"我的班级"
    NSArray *arr = is_online == 0 ? @[@"VIP题库",@"在线商城",@"学历教育",@"新闻资讯",@"校园招聘",@"我的班级"] : @[@"核心课程",@"直播课堂",@"VIP题库",@"在线商城",@"学历教育",@"新闻资讯",@"校园招聘",@"我的班级"];
    self.nameLb.text = arr[row];
}

- (UIImageView *)toolImgV {
    if (_toolImgV == nil) {
        _toolImgV = [[UIImageView alloc]init];
    }
    return _toolImgV;
}


- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize15) textAlignment:NSTextAlignmentCenter numberLines:1];
        _nameLb.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLb;
}

@end
