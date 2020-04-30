//
//  CourseDetailTeacherCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "CourseDetailTeacherCell.h"

@implementation CourseDetailTeacherCell

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
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.teacherNameLb];
    [self.contentView addSubview:self.teacherLogo];
    [self.contentView addSubview:self.teacherContentLb];
    
    [self.contentView addLineWithStartPoint:CGPointMake(0, 38 * AUTO_WIDTH) endPoint:CGPointMake(URScreenWidth(), 38 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_offset(10 * AUTO_WIDTH);
    }];
    [self.teacherLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb);
        make.top.mas_offset(53 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(50 * AUTO_WIDTH, 50 * AUTO_WIDTH));
        make.bottom.mas_offset(-15 * AUTO_WIDTH);
    }];
    [self.teacherNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.teacherLogo.mas_right).offset(15 * AUTO_WIDTH);
        make.top.mas_equalTo(self.teacherLogo);
        make.right.mas_offset(-12 * AUTO_WIDTH);
    }];
    [self.teacherContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.teacherNameLb);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.bottom.mas_equalTo(self.teacherLogo);
    }];
    
}

-(void)setDataModel:(CourseCommonDetailDataModel *)dataModel{
    _dataModel = dataModel ;
    
    [_teacherLogo  sd_setImageWithURL:[NSURL  URLWithString:[NSString   stringWithFormat:@"%@",dataModel.teacher_thumbnail]] placeholderImage:[UIImage  imageNamed:@"占位图"]];
    
    _teacherNameLb.text = [NSString  stringWithFormat:@"%@",dataModel.teacher_name?:@""] ;
    
    _teacherContentLb.text  = [NSString  stringWithFormat:@"%@",dataModel.teacher_describe?:@""] ;
    
}

- (void)setDataModel1:(BaseCourseModel *)dataModel1
{
    _dataModel1 = dataModel1;
    
    if (dataModel1.teachers.count > 0)
    {
        BaseCourseTeacherModel *teacher = dataModel1.teachers[0];
        
        [self.teacherLogo  sd_setImageWithURL:[NSURL  URLWithString:[NSString   stringWithFormat:@"%@",teacher.thumbnail]] placeholderImage:[UIImage  imageNamed:@"占位图"]];
        
        self.teacherNameLb.text = [NSString  stringWithFormat:@"%@",teacher.name ?: @""] ;
        
        self.teacherContentLb.text  = [NSString  stringWithFormat:@"%@",teacher.describe ?: @""] ;
    }
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"讲师简介" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _titleLb;
}

- (UIImageView *)teacherLogo
{
    if (!_teacherLogo) {
        _teacherLogo = [UIImageView new];
        _teacherLogo.layer.cornerRadius = 25 * AUTO_WIDTH;
        _teacherLogo.layer.masksToBounds = YES;
        _teacherLogo.backgroundColor = [UIColor grayColor];
    }
    return _teacherLogo;
}

- (UILabel *)teacherNameLb
{
    if (!_teacherNameLb) {
        _teacherNameLb = [UILabel normalLabelWithTitle:@"梁老师" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _teacherNameLb;
}

- (UILabel *)teacherContentLb
{
    if (!_teacherContentLb) {
        _teacherContentLb = [UILabel normalLabelWithTitle:@"点石教育独家讲师，从事教育工作多年点石. . . " titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _teacherContentLb;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
