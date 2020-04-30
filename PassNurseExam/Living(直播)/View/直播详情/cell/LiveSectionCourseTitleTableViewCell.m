//
//  LiveSectionCourseTitleTableViewCell.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionCourseTitleTableViewCell.h"

@interface  LiveSectionCourseTitleTableViewCell ()

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UILabel * timeLabel;

@end

@implementation LiveSectionCourseTitleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        [self.contentView  addSubview:self.titleLabel];
        [self.contentView  addSubview:self.timeLabel];
        [self.contentView addSubview:self.signBtn];
        
        [self.titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(11 *AUTO_WIDTH) ;
            make.top.mas_equalTo(20 * AUTO_WIDTH) ;
            make.right.mas_equalTo(self.signBtn.mas_left).offset(-10) ;
        }];
        
        [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-10);
            make.centerY.mas_equalTo(self.titleLabel);
            make.size.mas_equalTo(CGSizeMake(35, 35));
        }];
        
        [self.timeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(11 *AUTO_WIDTH) ;
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10 * AUTO_WIDTH) ;
            make.right.mas_equalTo(-11 * AUTO_WIDTH) ;
            make.bottom.mas_equalTo(-20* AUTO_WIDTH) ;
        }];
        
    }
    return self ;
}

-(void)setDetailModel:(LiveSectionDetailDataModel *)detailModel{
    
    _detailModel = detailModel ;
    
    self.titleLabel.text = [NSString  stringWithFormat:@"%@",detailModel.title?:@""] ;
    
    self.timeLabel.text = [NSString  stringWithFormat:@"直播时间：%@  %@-%@",detailModel.start_date?:@"",detailModel.start_time?:@"",detailModel.stop_time?:@""] ;
    
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel   normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:0] ;
    }
    return _titleLabel ;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel   normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0xFF773A) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentLeft numberLines:0] ;
    }
    return _timeLabel ;
}

-(UIButton *)signBtn {
    if (!_signBtn) {
        _signBtn = [UIButton ImgBtnWithImageName:@"打卡1"];
        _signBtn.hidden = YES;
    }
    return _signBtn;
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
