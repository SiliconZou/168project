//
//  FmousTeacherBroadcastCell.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "FmousTeacherBroadcastCell.h"

@interface FmousTeacherBroadcastCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLb;
@property (weak, nonatomic) IBOutlet UILabel *personNumLb;
@property (weak, nonatomic) IBOutlet UIView *point;

@end

@implementation FmousTeacherBroadcastCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    self.logo.layer.cornerRadius = 37;
    self.logo.layer.masksToBounds = YES;
    self.point.layer.cornerRadius = 5;
    self.point.layer.masksToBounds = YES;
    
    [self.reservationButton  setBackgroundColor:UR_ColorFromValue(0x63A3FF)];
    self.reservationButton.layer.cornerRadius = 12.5f;
    self.reservationButton.layer.masksToBounds = YES ;
    [self.reservationButton setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
    self.reservationButton.titleLabel.font = RegularFont(12.0f) ;
}

- (void)setModel:(FmousTeacherBroadcastDataModel *)model
{
    _model = model;
    
    [self.logo sd_setImageWithURL:[NSURL URLWithString:model.teacher_info[0].thumbnail ?:@""]];
    self.teacherNameLb.text = model.teacher_info[0].name ?: @"";
    
    self.titleLb.text = model.title ?: @"";
    
    self.timeLb.text = [NSString stringWithFormat:@"%@%@ %@-%@",model.start_date,model.week ? [NSString stringWithFormat:@"开始每%@",model.week] : @"", [model.start_time substringToIndex:5],[model.stop_time substringToIndex:5]];

    if (is_online==0) {
        self.priceLb.text =  @"";
    } else {
        self.priceLb.text = [model.univalence floatValue] > 0 ? [NSString stringWithFormat:@"￥%@",model.univalence] : @"免费直播";
    }
    
    self.personNumLb.text = [NSString stringWithFormat:@"%@预约",model.subscribe ?: @"0"];
    
    [self.reservationButton  setTitle:@"预约" forState:UIControlStateNormal];

    
//    if (model.own.integerValue==0) {
//       } else {
//           [self.reservationButton  setTitle:@"进入直播教室" forState:UIControlStateNormal];
//       }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
