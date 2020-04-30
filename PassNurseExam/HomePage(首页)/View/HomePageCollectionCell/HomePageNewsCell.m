//
//  HomePageNewsCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomePageNewsCell.h"
#import "NSString+URDate.h"
@interface HomePageNewsCell ()

@property (nonatomic,strong) UIImageView *logo;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UILabel *subTipLb; 

@end

@implementation HomePageNewsCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.subTipLb];
    
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(111 * AUTO_WIDTH, 82 * AUTO_WIDTH));
        make.left.mas_offset(11 * AUTO_WIDTH);
        make.top.mas_offset(13 * AUTO_WIDTH);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logo.mas_right).offset(20 * AUTO_WIDTH);
        make.right.mas_offset(-10 * AUTO_WIDTH);
        make.top.mas_offset(13 * AUTO_WIDTH);
    }];
    [self.subTipLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLb);
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(8 * AUTO_WIDTH);
        make.right.mas_offset(-10 * AUTO_WIDTH);
    }];
    
    [self.contentView addLineWithStartPoint:CGPointMake(0, 111 * AUTO_WIDTH) endPoint:CGPointMake(URScreenWidth(), 111 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];

}

- (UIImageView *)logo
{
    if (!_logo) {
        _logo = [UIImageView new];
        _logo.layer.masksToBounds = YES;
        _logo.layer.cornerRadius = 4.0;
        _logo.backgroundColor = UR_COLOR_DISABLE_CLICK;
    }
    return _logo;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"官方！2019年护士职业资格考试和卫生专业资格考试..." titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:2];
    }
    return _nameLb;
}

- (UILabel *)subTipLb
{
    if (!_subTipLb) {
        _subTipLb = [UILabel normalLabelWithTitle:@"2019.06.24 浏览量：58286" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _subTipLb;
}

-(void)setInformationModel:(HomePageInformationModel *)informationModel{
    _informationModel = informationModel ;
    
    [_logo sd_setImageWithURL:[NSURL  URLWithString:[NSString  stringWithFormat:@"%@",informationModel.thumb]] placeholderImage:[UIImage  imageNamed:@"占位图"]];
    
    _nameLb.text = [NSString  stringWithFormat:@"%@",informationModel.title?:@""] ;
    NSDate *newsDate = informationModel.updated_at.ur_date_Day;
    NSString *newsStr = newsDate.timeTextOfDate;
    _subTipLb.text = [NSString  stringWithFormat:@"%@ 浏览量:%@",newsStr?:@"",informationModel.click?:@""] ;
    
}

@end
