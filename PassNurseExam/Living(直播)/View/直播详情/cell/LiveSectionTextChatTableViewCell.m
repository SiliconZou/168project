//
//  LiveSectionTextChatTableViewCell.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/17.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionTextChatTableViewCell.h"

@implementation LiveSectionTextChatTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        [self.contentView  addSubview:self.personImageView];
        [self.contentView  addSubview:self.personInfor];
        [self.contentView  addSubview:self.textChatBgImageView];
        [self.textChatBgImageView  addSubview:self.textChatLabel];

        [self.personImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12 * AUTO_WIDTH);
            make.size.mas_equalTo(CGSizeMake(17 * AUTO_WIDTH, 17 * AUTO_WIDTH));
            make.top.mas_equalTo(10 * AUTO_WIDTH);
        }];
        
        [self.personInfor  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.personImageView.mas_right).mas_offset(8 * AUTO_WIDTH);
            make.height.mas_equalTo(15 * AUTO_WIDTH);
            make.centerY.mas_equalTo(self.personImageView);
        }];
        
        [self.textChatBgImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(21 *AUTO_WIDTH);
            make.top.mas_equalTo(self.personImageView.mas_bottom).mas_offset(8 * AUTO_WIDTH) ;
            make.width.mas_lessThanOrEqualTo(285 *AUTO_WIDTH) ;
            make.height.mas_greaterThanOrEqualTo(30 * AUTO_WIDTH) ;
            make.bottom.mas_equalTo(-13 *AUTO_WIDTH) ;
        }];
        
        [self.textChatLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(8, 13, 8, 13)) ;
        }];
        
    }
    
    return self ;
}

-(void)setMsgModel:(LivePenetrateMsgModel *)msgModel{
    
    _msgModel = msgModel ;
    
    [self.personImageView sd_setImageWithURL:[NSURL  URLWithString:msgModel.thumbnail] placeholderImage:[UIImage  imageNamed:@"headimg"]] ;
    
    self.personInfor.text = [NSString  stringWithFormat:@"%@    %@",msgModel.username?:@"",msgModel.time?:@""] ;
    
    self.textChatLabel.text =  [NSString  stringWithFormat:@"%@",msgModel.content?:@""] ;
    
}

-(UIImageView *)personImageView{
    if (!_personImageView) {
        _personImageView = [[UIImageView   alloc] init];
    }
    return _personImageView ;
}

-(UILabel *)personInfor{
    if (!_personInfor) {
        _personInfor = [UILabel  normalLabelWithTitle:@"[讲师]l梁老师    19：55" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize12) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _personInfor ;
}

-(UILabel *)textChatLabel{
    if (!_textChatLabel) {
        _textChatLabel = [UILabel   normalLabelWithTitle:@"即将开始直播，大家搬好小板凳哦！" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _textChatLabel ;
}

-(UIImageView *)textChatBgImageView{
    if (!_textChatBgImageView) {
        
        UIImage * bgImage = [UIImage  imageNamed:@"多边形1"] ;
        UIImage * newBgImage = [bgImage  stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5] ;
        _textChatBgImageView = [[UIImageView   alloc] initWithImage:newBgImage];
    }
    
    return _textChatBgImageView ;
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
