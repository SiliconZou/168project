//
//  LiveSectionTeacherInforTableViewCell.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionTeacherInforTableViewCell.h"

@interface LiveSectionTeacherInforTableViewCell ()

@property (nonatomic,strong) UIImageView * teacherImage;




@end

@implementation LiveSectionTeacherInforTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        [self.contentView  addSubview:self.teacherImage];
        [self.contentView  addSubview:self.teacherNameLabel];
        [self.contentView  addSubview:self.teacherIntroLabel];
        [self.contentView  addSubview:self.expandContractionButton];


        [self.teacherImage  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(13 *AUTO_WIDTH) ;
            make.size.mas_equalTo(CGSizeMake(50 *AUTO_WIDTH, 50 *AUTO_WIDTH)) ;
        }];
        
        [self.teacherNameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.teacherImage.mas_right).mas_offset(17 *AUTO_WIDTH) ;
            make.top.mas_equalTo(21* AUTO_WIDTH) ;
            make.height.mas_equalTo(20 * AUTO_WIDTH) ;
        }];
        
        [self.teacherIntroLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.teacherNameLabel) ;
            make.top.mas_equalTo(self.teacherNameLabel.mas_bottom).mas_offset(11 *AUTO_WIDTH);
            make.height.mas_equalTo(15 *AUTO_WIDTH) ;
            make.right.mas_equalTo(-11 *AUTO_WIDTH);
            make.bottom.mas_equalTo(-48 *AUTO_WIDTH);

        }];
        
        [self.expandContractionButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.teacherIntroLabel.mas_bottom).mas_offset(20 * AUTO_WIDTH);
            make.size.mas_equalTo(CGSizeMake(200 *AUTO_WIDTH, 15 *AUTO_WIDTH));
            make.left.mas_equalTo((URScreenWidth()-200 *AUTO_WIDTH)/2) ;
        }];
        
        [self.expandContractionButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:10 *AUTO_WIDTH] ;
        
    }
    return self ;
}

-(void)setDetailModel:(LiveSectionDetailDataModel *)detailModel{
    
    _detailModel = detailModel ;
    
    [self.teacherImage  sd_setImageWithURL:[NSURL  URLWithString:detailModel.teacher_info.thumbnail] placeholderImage:[UIImage  imageNamed:@""]];
    
    self.teacherNameLabel.text = [NSString   stringWithFormat:@"%@",detailModel.teacher_info.name?:@""] ;
    
    self.teacherIntroLabel.text = [NSString   stringWithFormat:@"%@",detailModel.teacher_info.describe?:@""] ;
    
    self.expandContractionButton.selected = detailModel.open;
    
    if (detailModel.open == YES) {
        CGFloat  describeHeight = [detailModel.teacher_info.describe   ur_heightWithFont:RegularFont(FontSize13) constrainedToWidth:(URScreenWidth()-90 *AUTO_WIDTH)] ;
        
//        [UIView animateWithDuration:0.3 animations:^{
             [self.teacherIntroLabel   mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.height.mas_equalTo(describeHeight) ;
             }];
//        }];
    } else {
//        [UIView animateWithDuration:0.3 animations:^{
             [self.teacherIntroLabel   mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.height.mas_equalTo(15 *AUTO_WIDTH) ;
             }];
//        }];
    }
}

-(UIImageView *)teacherImage{
    if (!_teacherImage) {
        _teacherImage = [[UIImageView  alloc] init];
        _teacherImage.layer.cornerRadius = 25.0f;
        _teacherImage.layer.masksToBounds = YES ;
    }
    return _teacherImage ;
}

-(UILabel *)teacherNameLabel{
    if (!_teacherNameLabel) {
        _teacherNameLabel = [UILabel   normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:0] ;
    }
    return _teacherNameLabel ;
}

-(UILabel *)teacherIntroLabel{
    if (!_teacherIntroLabel) {
        _teacherIntroLabel = [UILabel   normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentLeft numberLines:0] ;
    }
    return _teacherIntroLabel ;
}

-(UIButton *)expandContractionButton{
    if (!_expandContractionButton) {
        _expandContractionButton = [[UIButton  alloc] init];
        [_expandContractionButton  setImage:[UIImage  imageNamed:@"箭头_右"] forState:UIControlStateNormal];
        [_expandContractionButton  setImage:[UIImage  imageNamed:@"返回顶部"] forState:UIControlStateSelected];
        [_expandContractionButton  setTitle:@"展开更多简介" forState:UIControlStateNormal] ;
        [_expandContractionButton  setTitleColor:UR_ColorFromValue(0x999999) forState:UIControlStateNormal];
        _expandContractionButton.titleLabel.font = RegularFont(FontSize13) ;
    }
    return _expandContractionButton ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
