//
//  CourseTeacherInfoCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "CourseTeacherInfoCell.h"

@implementation CourseTeacherInfoCell


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
    [self.contentView addSubview:self.bgImg];
    [self.contentView addSubview:self.header];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.flowersBtn];
    [self.contentView addSubview:self.praiseBtn];
    [self.contentView addSubview:self.introTitleLb];
    [self.contentView addSubview:self.introLb];
    [self.contentView addSubview:self.courseTitleLb];

    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_equalTo(208 * AUTO_WIDTH);
    }];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(95 * AUTO_WIDTH, 95 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_offset(24);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.header.mas_bottom).offset(16 * AUTO_WIDTH);
    }];
    [self.flowersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(12 * AUTO_WIDTH);
        make.right.mas_equalTo(self.contentView.mas_centerX).offset(-15*AUTO_WIDTH);
//        make.width.height.mas_equalTo(20);
    }];
    [self.praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.flowersBtn);
        make.left.mas_equalTo(self.contentView.mas_centerX).offset(15*AUTO_WIDTH);
//        make.width.height.mas_equalTo(20);
    }];
    [self.introTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.bgImg.mas_bottom).offset(12 * AUTO_WIDTH);
    }];
    [self.introLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.introTitleLb);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.bgImg.mas_bottom).offset(60 * AUTO_WIDTH);
    }];
    [self.courseTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.introTitleLb);
        make.top.mas_equalTo(self.introLb.mas_bottom).offset(26 * AUTO_WIDTH);
        make.bottom.mas_offset(-12 * AUTO_WIDTH);
    }];
    
    [self.contentView addLineWithStartPoint:CGPointMake(0, 248 * AUTO_WIDTH) endPoint:CGPointMake(URScreenWidth(), 248 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
    
    [self.flowersBtn  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    
    [self.praiseBtn  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:10];

}

-(void)setDataModel:(CourseTeacherInforDataModel *)dataModel{
    _dataModel = dataModel ;
    
    [_header  sd_setImageWithURL:[NSURL  URLWithString:[NSString  stringWithFormat:@"%@",dataModel.teacher.thumbnail]] placeholderImage:[UIImage  imageNamed:@"占位图"]];
    
    [_flowersBtn setTitle:[NSString  stringWithFormat:@"%@",dataModel.teachersFlowerCount?:@""] forState:UIControlStateNormal];
    
    [_praiseBtn setTitle:[NSString  stringWithFormat:@"%@",dataModel.teachersPraiseCount?:@""] forState:UIControlStateNormal];
 
    _introLb.text = [NSString  stringWithFormat:@"%@",dataModel.teacher.describe?:@""] ;
    
    _nameLb.text = [NSString stringWithFormat:@"%@",dataModel.teacher.name];
}

- (UIImageView *)bgImg
{
    if (!_bgImg) {
        _bgImg = [UIImageView new];
//        _bgImg.image = [UIImage gradientBackImgWithFrame:CGRectMake(0, 0, URScreenWidth(), 208 * AUTO_WIDTH) startColor:NORMAL_COLOR endColor:NORMAL_COLOR direction:0];
        _bgImg.image = [UIImage imageNamed:@"teacher_bg"];
    }
    return _bgImg;
}

- (UIImageView *)header
{
    if (!_header) {
        _header = [UIImageView new];
        _header.layer.cornerRadius = 95 / 2.0 * AUTO_WIDTH;
        _header.layer.masksToBounds = YES;
    }
    return _header;
}

-(UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel  alloc] init];
        _nameLb.textColor = UR_ColorFromValue(0xffffff);
        _nameLb.font = RegularFont(18.0f);
        _nameLb.textAlignment = NSTextAlignmentCenter ;
    }
    return _nameLb ;
}

-(UIButton *)flowersBtn{
    if (!_flowersBtn) {
        _flowersBtn = [[UIButton  alloc] init];
        [_flowersBtn  setImage:[UIImage  imageNamed:@"鲜花"] forState:UIControlStateNormal];
        [_flowersBtn setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
        _flowersBtn.titleLabel.font = RegularFont(18.0f) ;
        _flowersBtn.tag = 2 ;
        [[_flowersBtn  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            if (self.selectedButtonBlock) {
                self.selectedButtonBlock(x.tag) ;
            }
        }];
    }
    return _flowersBtn ;
}

-(UIButton *)praiseBtn{
    if (!_praiseBtn) {
        _praiseBtn = [[UIButton  alloc] init];
        [_praiseBtn  setImage:[UIImage  imageNamed:@"点赞"] forState:UIControlStateNormal];
        [_praiseBtn setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
        _praiseBtn.titleLabel.font = RegularFont(18.0f) ;
        _praiseBtn.tag = 1 ;
        [[_praiseBtn  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            if (self.selectedButtonBlock) {
                self.selectedButtonBlock(x.tag) ;
            }
        }];
    }
    return _praiseBtn ;
}

-(UILabel *)introTitleLb{
    if (!_introTitleLb) {
        _introTitleLb = [[UILabel  alloc] init];
        _introTitleLb.text = @"讲师简介" ;
        _introTitleLb.textColor = UR_ColorFromValue(0x333333) ;
        _introTitleLb.font = RegularFont(16.0f) ;
    }
    return _introTitleLb ;
}

-(UILabel *)introLb{
    if (!_introLb) {
        _introLb = [[UILabel  alloc] init];
        _introLb.textColor = UR_ColorFromValue(0x666666) ;
        _introLb.numberOfLines = 0 ;
        _introLb.font = RegularFont(14.0f) ;
    }
    return _introLb ;
}

-(UILabel *)courseTitleLb{
    if (!_courseTitleLb) {
        _courseTitleLb = [[UILabel  alloc] init];
        _courseTitleLb.text = @"讲师课程" ;
        _courseTitleLb.textColor = UR_ColorFromValue(0x333333) ;
        _courseTitleLb.font = RegularFont(16.0f) ;
    }
    return _courseTitleLb ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
