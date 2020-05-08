//
//  LiveTodayRecommendCell.m
//  PassNurseExam
//
//  Created by SiliconZou on 2020/4/10.
//  Copyright © 2020 ucmed. All rights reserved.
//

#import "LiveTodayRecommendCell.h"
@interface LiveTodayRecommendCell ()

@property (nonatomic,strong) UIImageView * courseImage;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UILabel * timeLabel;

@property (nonatomic,strong) UILabel * weekLabel;

@property (nonatomic,strong) UILabel * moneyLabel;

@property (nonatomic,strong) UILabel * teacherNameLabel;

@property (nonatomic,strong) NSMutableArray <UIButton *> *btnTempArr;//暂时存放多个老师的按钮

@end
@implementation LiveTodayRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return  self;
}

- (void)setModel:(LiveHomeRecommedCourseModel *)model
{
    _model = model;
    
    [self.courseImage sd_setImageWithURL:[NSURL URLWithString:model.thumbnail ?:@""]];
    
    self.titleLabel.text = model.title ?: @"";
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@-%@",model.start_date,[model.start_time substringToIndex:5],[model.stop_time substringToIndex:5]];

    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@-%@",model.start_date,[model.start_time substringToIndex:5],[model.stop_time substringToIndex:5]];
    self.weekLabel.text = model.week ? : @"";
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
        CGFloat teacherWidth = (20*model.teacher_info.count*AUTO_WIDTH + (model.teacher_info.count-1)*10+25)*AUTO_WIDTH;;
        [model.teacher_info  enumerateObjectsUsingBlock:^(BaseCourseTeacherModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < 5) {
                UIButton * teacherIconButton = [UIButton   buttonWithType:UIButtonTypeCustom] ;
                UILabel *nameLb = [UILabel   normalLabelWithTitle:obj.name titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize8) textAlignment:NSTextAlignmentCenter numberLines:1];
                [self.contentView addSubview:nameLb];
                [teacherIconButton  sd_setImageWithURL:[NSURL  URLWithString:obj.thumbnail] forState:UIControlStateNormal placeholderImage:[UIImage  imageNamed:@"占位图"]];
                teacherIconButton.layer.cornerRadius = 10.f*AUTO_WIDTH;
                teacherIconButton.layer.masksToBounds = YES ;
                [self.contentView addSubview:teacherIconButton];
                [teacherIconButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(5);
                    make.left.mas_equalTo((URScreenWidth()-teacherWidth)+34*idx*AUTO_WIDTH);
                    make.size.mas_equalTo(CGSizeMake(20*AUTO_WIDTH, 20*AUTO_WIDTH));
                }];
                [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(teacherIconButton.mas_bottom).mas_offset(5);
                    make.centerX.mas_equalTo(teacherIconButton);
                }];
                if (model.teacher_info.count==1)
                {
    //                self.teacherNameLabel.hidden = NO;
                    self.teacherNameLabel.text = [NSString  stringWithFormat:@"%@",model.teacher_info[0].name?:@""] ;
                    CGFloat teacherNameWidth = [model.teacher_info[0].name ur_widthWithFont:RegularFont(12.0f) constrainedToHeight:25] ;

                    [teacherIconButton  mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(URScreenWidth()-10*AUTO_WIDTH-teacherNameWidth-30*AUTO_WIDTH) ;
                    }];
                } else {
    //                self.teacherNameLabel.hidden = YES;
                }

                [self.btnTempArr addObject:teacherIconButton];
            } else {
                return ;
            }
        }];
    }
}

- (void)changeButtonType:(UIButton *)button {
    CGFloat interval = 1.0;
    CGSize imageSize = button.imageView.bounds.size;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval, -(imageSize.width), 0, 0)];
    CGSize titleSize = button.titleLabel.bounds.size;
    [button setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height + interval, -(titleSize.width))];
}
-(void)creatUI{
    
    [self.contentView  addSubview:self.courseImage];
    [self.courseImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11*AUTO_WIDTH);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
        make.width.mas_equalTo(130);
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
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10*AUTO_WIDTH) ;
    }];
    
    [self.contentView  addSubview:self.timeLabel];
    [self.timeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeIconImage.mas_right).mas_offset(4*AUTO_WIDTH) ;
        make.centerY.mas_equalTo(timeIconImage) ;
        make.right.mas_equalTo(-11*AUTO_WIDTH) ;
    }];
    
    [self.contentView addSubview:self.weekLabel];
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(2*AUTO_WIDTH);
        make.left.mas_equalTo(self.timeLabel.mas_left);
        make.right.mas_equalTo(self.timeLabel.mas_right);
    }];
    
    [self.contentView  addSubview:self.moneyLabel];
    [self.moneyLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10 * AUTO_WIDTH);
        make.height.mas_equalTo(20*AUTO_WIDTH);
    }];
    
    [self.contentView  addSubview:self.teacherNameLabel];
    [self.teacherNameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moneyLabel);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
}


-(UIImageView *)courseImage{
    if(!_courseImage){
        _courseImage = [[UIImageView  alloc] init];
        _courseImage.layer.cornerRadius = 10.0f ;
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

-(UILabel *)weekLabel {
    if (!_weekLabel) {
        _weekLabel = [UILabel normalLabelWithTitle:@"周一" titleColor:UR_ColorFromValue(0xFF8500) font:RegularFont(FontSize11) textAlignment:NSTextAlignmentLeft numberLines:1];
        _weekLabel.hidden = YES;
    }
    return _weekLabel;
}

-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel   normalLabelWithTitle:@"￥128起" titleColor:UR_ColorFromValue(0xFF773A) font:RegularFont(FontSize17) textAlignment:NSTextAlignmentLeft numberLines:0] ;
    }
    return _moneyLabel ;
}

-(UILabel *)teacherNameLabel{
    if (!_teacherNameLabel) {
        _teacherNameLabel = [UILabel   normalLabelWithTitle:@"进入课堂" titleColor:UR_ColorFromValue(0xffffff) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:1] ;
        _teacherNameLabel.backgroundColor = NORMAL_COLOR;//[UIColor greenColor];
        _teacherNameLabel.layer.masksToBounds = YES;
        _teacherNameLabel.layer.cornerRadius = 13;
    }
    
    return _teacherNameLabel ;
}


@end
