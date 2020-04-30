//
//  HomePageCourseCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomePageCourseCell.h"

@interface HomePageCourseCell()

@property (nonatomic,strong) UIImageView *logo;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UILabel *subTipLb;
@property (nonatomic,strong) UILabel *priceLb;
@property (nonatomic,strong) UIButton *studyBtn;
@property (nonatomic,strong) UILabel * teacherNameLb;

@property (nonatomic,strong) NSMutableArray <UIButton *> *btnTempArr;//暂时存放多个老师的按钮

@end

@implementation HomePageCourseCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.btnTempArr = [NSMutableArray array];
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.subTipLb];
    [self.contentView addSubview:self.priceLb];
    [self.contentView  addSubview:self.teacherNameLb];
    [self.contentView addSubview:self.studyBtn];
    
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
    }];
    [self.priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logo);
        make.top.mas_equalTo(self.logo.mas_bottom).offset(10 * AUTO_WIDTH);
        make.right.mas_equalTo(self.studyBtn.mas_left).offset(-1*AUTO_WIDTH);
    }];
    [self.teacherNameLb  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10* AUTO_WIDTH) ;
        make.bottom.mas_equalTo(self.logo);
        make.height.mas_equalTo(25* AUTO_WIDTH) ;
    }];

    [self.studyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLb);
        make.right.mas_offset(-10 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(80* AUTO_WIDTH, 28* AUTO_WIDTH));
        make.bottom.mas_offset(-13 * AUTO_WIDTH);
    }];
    
    [self.contentView addLineWithStartPoint:CGPointMake(0, 150 * AUTO_WIDTH) endPoint:CGPointMake(URScreenWidth(), 150 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
}

- (UIImageView *)logo
{
    if (!_logo) {
        _logo = [UIImageView new];
        _logo.backgroundColor = UR_COLOR_DISABLE_CLICK;
        _logo.layer.cornerRadius = 4 * AUTO_WIDTH;
        _logo.layer.masksToBounds = YES;
    }
    return _logo;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"初级护师—2019年全国卫生专业技术资格考试" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:2];
    }
    return _nameLb;
}

-(UILabel *)teacherNameLb{
    if (!_teacherNameLb) {
        _teacherNameLb = [[UILabel  alloc] init];
        _teacherNameLb.textColor = UR_ColorFromValue(0x666666) ;
        _teacherNameLb.font = RegularFont(12.0f*AUTO_WIDTH);
    }
    
    return _teacherNameLb ;
}

- (UILabel *)subTipLb
{
    if (!_subTipLb) {
        _subTipLb = [UILabel borderLabelWithRadius:4 borderColor:UR_ColorFromValue(0xF9A461) borderWidth:0.5 title:@"系列课程/共3门课 拷贝" titleColor:UR_ColorFromValue(0xF9A768) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentCenter numberLines:1];
        _subTipLb.backgroundColor = UR_ColorFromValue(0xFFF7F3);
    }
    return _subTipLb;
}

-(UILabel *)priceLb
{
    if (!_priceLb) {
        _priceLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0xFF773A) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _priceLb;
}

- (UIButton *)studyBtn
{
    if (!_studyBtn) {
        _studyBtn = [UIButton cornerBtnWithRadius:14.0f* AUTO_WIDTH title:@"立即学习" titleColor:UR_ColorFromValue(0xffffff) titleFont:RegularFont(14.0f) backColor:UR_ColorFromValue(0x91f261)];
        _studyBtn.userInteractionEnabled = NO;
    }
    return _studyBtn;
}

-(void)setCourseModel:(HomePageCourseModel *)courseModel{
    
    _courseModel = courseModel ;
    
    [self.logo sd_setImageWithURL:[NSURL  URLWithString:[NSString  stringWithFormat:@"%@",courseModel.thumbnail?:@""]] placeholderImage:[UIImage  imageNamed:@"占位图"]];
    self.nameLb.text = [NSString  stringWithFormat:@"%@",courseModel.name?:@""] ;
    self.subTipLb.text = [NSString  stringWithFormat:@" %@ ",courseModel.class_hour?:@""];
    self.priceLb.text = courseModel.describe ?: @"" ;
    
     
    if (self.btnTempArr.count > 0) {
        [self.btnTempArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self.btnTempArr removeAllObjects];
    }
    if (courseModel.teachers.count>0) {
        
        CGFloat teacherWidth = (25*courseModel.teachers.count*AUTO_WIDTH + (courseModel.teachers.count-1) * 8+10) * AUTO_WIDTH ;
        
        [courseModel.teachers  enumerateObjectsUsingBlock:^(HomePageCourseTeacherModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            UIButton * teacherButton = [UIButton   buttonWithType:UIButtonTypeCustom] ;
            [teacherButton  sd_setImageWithURL:[NSURL  URLWithString:obj.thumbnail] forState:UIControlStateNormal placeholderImage:[UIImage  imageNamed:@"占位图"]];
            teacherButton.layer.cornerRadius = 12.5f *AUTO_WIDTH;
            teacherButton.layer.masksToBounds = YES ;
            [self.contentView addSubview:teacherButton];
            [teacherButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.logo);
                make.left.mas_equalTo((URScreenWidth()-teacherWidth)+33*idx*AUTO_WIDTH);
                make.size.mas_equalTo(CGSizeMake(25*AUTO_WIDTH, 25*AUTO_WIDTH));
            }];
            
            if (courseModel.teachers.count==1)
            {
                self.teacherNameLb.hidden = NO;
                self.teacherNameLb.text = [NSString  stringWithFormat:@"%@",courseModel.teachers[0].name?:@""] ;
                CGFloat teacherNameWidth = [courseModel.teachers[0].name ur_widthWithFont:RegularFont(12.0f) constrainedToHeight:25] ;
                
                [teacherButton  mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(URScreenWidth()-10*AUTO_WIDTH-teacherNameWidth-30*AUTO_WIDTH) ;
                }];
            } else {
                self.teacherNameLb.hidden = YES;
            }
            
            [self.btnTempArr addObject:teacherButton];
        }];
    }
}

@end
