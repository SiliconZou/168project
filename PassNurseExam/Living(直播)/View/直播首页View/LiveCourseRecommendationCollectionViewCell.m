//
//  LiveCourseRecommendationCollectionViewCell.m
//  PassNurseExam
//
//  Created by quchao on 2019/10/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveCourseRecommendationCollectionViewCell.h"

@interface LiveCourseRecommendationCollectionViewCell ()

@property (nonatomic,strong) UIImageView * courseImage;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UILabel * timeLabel;

@property (nonatomic,strong) UILabel * moneyLabel;

@property (nonatomic,strong) UILabel * teacherNameLabel;

@property (nonatomic,strong) NSMutableArray <UIButton *> *btnTempArr;//暂时存放多个老师的按钮

@end

@implementation LiveCourseRecommendationCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = UR_ColorFromValue(0xffffff) ;
        
        [self  creatUI] ;
    }
    
    return self ;
}

- (void)setModel:(LiveHomeRecommedCourseModel *)model
{
    _model = model;
    
    [self.courseImage sd_setImageWithURL:[NSURL URLWithString:model.thumbnail ?:@""]];
    
    self.titleLabel.text = model.title ?: @"";
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@-%@",model.start_date,[model.start_time substringToIndex:5],[model.stop_time substringToIndex:5]];

    self.timeLabel.text = [NSString stringWithFormat:@"%@%@ %@-%@",model.start_date,model.week ? [NSString stringWithFormat:@"开始每%@",model.week] : @"", [model.start_time substringToIndex:5],[model.stop_time substringToIndex:5]];

    if (is_online==0) {
        self.moneyLabel.text = @"";

    } else {
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",model.univalence];

    }
    
    
    if (self.btnTempArr.count > 0) {
        [self.btnTempArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self.btnTempArr removeAllObjects];
    }
    
    if (model.teacher_info.count>0)
    {
        CGFloat teacherWidth = (25*model.teacher_info.count*AUTO_WIDTH + (model.teacher_info.count-1)*8+10)*AUTO_WIDTH;;
        
        [model.teacher_info  enumerateObjectsUsingBlock:^(BaseCourseTeacherModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIButton * teacherIconButton = [UIButton   buttonWithType:UIButtonTypeCustom] ;
            [teacherIconButton  sd_setImageWithURL:[NSURL  URLWithString:obj.thumbnail] forState:UIControlStateNormal placeholderImage:[UIImage  imageNamed:@"占位图"]];
            teacherIconButton.layer.cornerRadius = 12.5f*AUTO_WIDTH;
            teacherIconButton.layer.masksToBounds = YES ;
            [self.contentView addSubview:teacherIconButton];
            [teacherIconButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.moneyLabel);
                make.left.mas_equalTo((URScreenWidth()-teacherWidth)+33*idx*AUTO_WIDTH);
                make.size.mas_equalTo(CGSizeMake(25*AUTO_WIDTH, 25*AUTO_WIDTH));
            }];
            
            if (model.teacher_info.count==1)
            {
                self.teacherNameLabel.hidden = NO;
                self.teacherNameLabel.text = [NSString  stringWithFormat:@"%@",model.teacher_info[0].name?:@""] ;
                CGFloat teacherNameWidth = [model.teacher_info[0].name ur_widthWithFont:RegularFont(12.0f) constrainedToHeight:25] ;
                
                [teacherIconButton  mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(URScreenWidth()-10*AUTO_WIDTH-teacherNameWidth-30*AUTO_WIDTH) ;
                }];
            } else {
                self.teacherNameLabel.hidden = YES;
            }
            
            [self.btnTempArr addObject:teacherIconButton];
        }];
    }
}

-(void)creatUI{
    
    [self.contentView  addSubview:self.courseImage];
    [self.courseImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11*AUTO_WIDTH);
        make.top.mas_equalTo(13*AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake(111 * AUTO_WIDTH, 82 *AUTO_WIDTH));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.courseImage.mas_right).mas_offset(13*AUTO_WIDTH);
        make.top.mas_equalTo(15*AUTO_WIDTH);
        make.right.mas_equalTo(-10 *AUTO_WIDTH) ;
    }];
    
    UIImageView * timeIconImage = [[UIImageView   alloc] initWithImage:[UIImage  imageNamed:@"时间(3)"]];
    [self.contentView  addSubview:timeIconImage] ;
    [timeIconImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(11, 11)) ;
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(15*AUTO_WIDTH) ;
    }];
    
    [self.contentView  addSubview:self.timeLabel];
    [self.timeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeIconImage.mas_right).mas_offset(4*AUTO_WIDTH) ;
        make.centerY.mas_equalTo(timeIconImage) ;
        make.right.mas_equalTo(-11*AUTO_WIDTH) ;
    }];
    
    
    [self.contentView  addSubview:self.moneyLabel];
    [self.moneyLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(timeIconImage.mas_bottom).mas_offset(18*AUTO_WIDTH) ;
        make.height.mas_equalTo(20*AUTO_WIDTH);
    }];
    
    [self.contentView  addSubview:self.teacherNameLabel];
    [self.teacherNameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-11*AUTO_WIDTH) ;
        make.centerY.mas_equalTo(self.moneyLabel);
        make.height.mas_equalTo(15*AUTO_WIDTH) ;
    }];
}


-(UIImageView *)courseImage{
    if(!_courseImage){
        _courseImage = [[UIImageView  alloc] init];
        _courseImage.layer.cornerRadius = 4.0f ;
        _courseImage.layer.masksToBounds = YES ;
    }
    
    return _courseImage ;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel   normalLabelWithTitle:@"2019护士职业资格考试" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize15) textAlignment:NSTextAlignmentLeft numberLines:2] ;
    }
    return _titleLabel ;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel   normalLabelWithTitle:@"2019-10-20 19:30-21:30" titleColor:UR_ColorFromValue(0xFF8500) font:RegularFont(FontSize11) textAlignment:NSTextAlignmentLeft numberLines:1] ;
    }
    return _timeLabel ;
}

-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel   normalLabelWithTitle:@"￥128起" titleColor:UR_ColorFromValue(0xFF773A) font:RegularFont(FontSize17) textAlignment:NSTextAlignmentLeft numberLines:0] ;
    }
    return _moneyLabel ;
}

-(UILabel *)teacherNameLabel{
    if (!_teacherNameLabel) {
        _teacherNameLabel = [UILabel   normalLabelWithTitle:@"晓明老师" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:0] ;
    }
    
    return _teacherNameLabel ;
}

@end
