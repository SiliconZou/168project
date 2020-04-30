//
//  FamousTeacherBroadcastCollectionViewCell.m
//  PassNurseExam
//
//  Created by quchao on 2019/10/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "FamousTeacherBroadcastCollectionViewCell.h"

@interface FamousTeacherBroadcastCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLb;
@property (weak, nonatomic) IBOutlet UILabel *personNumLb;

@end

@implementation FamousTeacherBroadcastCollectionViewCell

- (void)setModel:(id)model
{
    _model = model;
    
    if ([model  isKindOfClass:[LiveHomeFamousTeacherModel  class]]) {
        
        LiveHomeFamousTeacherModel * teacherModel = model ;
        
        [self.logo sd_setImageWithURL:[NSURL URLWithString:teacherModel.teacher_info.thumbnail ?:@""]];
           self.teacherNameLb.text = teacherModel.teacher_info.name ?: @"";
           
       self.titleLb.text = teacherModel.title ?: @"";
       
       self.timeLb.text = [NSString stringWithFormat:@"%@%@ %@-%@",teacherModel.start_date,teacherModel.week ? [NSString stringWithFormat:@"开始每%@",teacherModel.week] : @"", [teacherModel.start_time substringToIndex:5],[teacherModel.stop_time substringToIndex:5]];

        if (is_online==0) {
             self.priceLb.text =  @"";
        } else {
             self.priceLb.text = [teacherModel.univalence floatValue] > 0 ? [NSString stringWithFormat:@"￥%@",teacherModel.univalence] : @"免费直播";
        }
       
       self.personNumLb.text = [NSString stringWithFormat:@"%@人预约",teacherModel.subscribe ?: @"0"];
        
        if (teacherModel.own.integerValue==0) {
            
            if (is_online==0) {
//                self.reservationButton.userInteractionEnabled = NO;
//                [self.reservationButton  setTitle:@"暂无权限" forState:UIControlStateNormal];
                self.reservationButton.userInteractionEnabled = NO;
                [self.reservationButton setBackgroundColor:UR_ColorFromValue(0x91f261)];
                [self.reservationButton  setTitle:@"进入课堂" forState:UIControlStateNormal];
            }else {
                self.reservationButton.userInteractionEnabled = YES;
                [self.reservationButton  setTitle:@"预约" forState:UIControlStateNormal];
            }
            [self.reservationButton setBackgroundColor:UR_ColorFromValue(0x4f81ff)];
        } else {
            self.reservationButton.userInteractionEnabled = NO;
            [self.reservationButton setBackgroundColor:UR_ColorFromValue(0x91f261)];
            [self.reservationButton  setTitle:@"进入课堂" forState:UIControlStateNormal];
        }
        
    } else if ([model  isKindOfClass:[LiveHomeBroadcastNoticeListModel  class]]){
        
        LiveHomeBroadcastNoticeListModel * noticeModel = model ;
        
         [self.logo sd_setImageWithURL:[NSURL URLWithString:noticeModel.thumbnail ?:@""]];
        
         self.teacherNameLb.text = noticeModel.teacher_info[0].name ?: @"";
        
        self.titleLb.text = noticeModel.title ?: @"";
        
        self.timeLb.text = [NSString stringWithFormat:@"%@%@ %@-%@",noticeModel.start_date,noticeModel.week ? [NSString stringWithFormat:@"开始每%@",noticeModel.week] : @"", [noticeModel.start_time substringToIndex:5],[noticeModel.stop_time substringToIndex:5]];

        if (is_online==0) {
            self.priceLb.text =  @"";
        } else {
            self.priceLb.text = [noticeModel.univalence floatValue] > 0 ? [NSString stringWithFormat:@"￥%@",noticeModel.univalence] : @"免费直播";
        }
        
        self.personNumLb.text = [NSString stringWithFormat:@"%@人预约",noticeModel.subscribe ?: @"0"];

        if (noticeModel.own.integerValue==0) {
            if (is_online==0) {
//                self.reservationButton.userInteractionEnabled = NO;
//                [self.reservationButton  setTitle:@"暂无权限" forState:UIControlStateNormal];
                self.reservationButton.userInteractionEnabled = NO;
                [self.reservationButton setBackgroundColor:UR_ColorFromValue(0x91f261)];
                [self.reservationButton  setTitle:@"立即学习" forState:UIControlStateNormal];
            }else {
                self.reservationButton.userInteractionEnabled = YES;
                [self.reservationButton  setTitle:@"预约" forState:UIControlStateNormal];
            }
            [self.reservationButton setBackgroundColor:UR_ColorFromValue(0x4f81ff)];

        } else {
            self.reservationButton.userInteractionEnabled = NO;
            [self.reservationButton setBackgroundColor:UR_ColorFromValue(0x91f261)];
            [self.reservationButton  setTitle:@"立即学习" forState:UIControlStateNormal];
        }
    }
   
}

- (void)awakeFromNib {

    [super awakeFromNib];
    self.logo.layer.cornerRadius = 40;
    self.logo.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    
    [self.reservationButton  setBackgroundColor:UR_ColorFromValue(0x63A3FF)];
    self.reservationButton.layer.cornerRadius = 12.5f;
    self.reservationButton.layer.masksToBounds = YES ;
    [self.reservationButton setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
    self.reservationButton.titleLabel.font = RegularFont(12.0f) ;
    
}

@end
