//
//  PersonalCenterCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/20.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "PersonalCenterCell.h"

@interface PersonalCenterCell ()

@end

@implementation PersonalCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.integralButton.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(12, 12)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.integralButton.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.integralButton.layer.mask = maskLayer;
    
    self.personalImage.layer.cornerRadius = 34.0f ;
    self.personalImage.layer.masksToBounds = YES ;
    self.personalImage.layer.borderColor = UR_ColorFromValue(0xffffff).CGColor ;
    self.personalImage.layer.borderWidth = 2.0f ;
    
    self.memberView.layer.cornerRadius = 15.0f ;
    self.memberView.layer.masksToBounds = YES ;
    self.memberView.backgroundColor = [UIColor  colorWithPatternImage:[UIImage  gradientBackImgWithFrame:CGRectMake(0, 0, URScreenWidth()-24, 35) startColor:UR_ColorFromValue(0xF7E5D7) endColor:UR_ColorFromValue(0xFFE3C1) direction:0]] ;
    
    self.levelBtn.layer.cornerRadius = 5.0f;
    self.levelBtn.layer.masksToBounds = YES;
    self.levelBtn.hidden = YES ;
    self.levelBtn.layer.borderWidth = 1.0f;
    self.levelBtn.layer.borderColor = UR_ColorFromRGBA(247, 144, 103, 1).CGColor;
    
    self.payButton.layer.cornerRadius = 10.0f ;
    self.payButton.layer.masksToBounds = YES ;
    self.payButton.layer.borderColor = UR_ColorFromValue(0x9A7E4E).CGColor ;
    self.payButton.layer.borderWidth = 0.8f ;
    
    self.loginOutBtn.layer.cornerRadius = 20.0f ;
    self.loginOutBtn.layer.masksToBounds = YES ;
    self.loginOutBtn.layer.borderColor = NORMAL_COLOR.CGColor ;
    self.loginOutBtn.layer.borderWidth = 1.0f ;
//    [self.scanBtn setHidden:is_online == 0 ? YES : NO];
    [self.rightBtn setHidden:is_online == 0 ? YES : NO];
    [self.memberView setHidden:is_online == 0 ? YES : NO];
    [self.rewardLabel setHidden:is_online == 0 ? YES : NO];
    
    [self.inviteImg setHidden:is_online == 0 ? YES : NO];
    [self.myResumeBtn setHidden:is_online == 0 ? YES : NO];
    [self.myResumeImg setHidden:is_online == 0 ? YES : NO];
    [self.courseActiveButton setHidden:is_online == 0 ? YES : NO];
    [self.courseActiveImg setHidden:is_online == 0 ? YES : NO];
    [self.sellCenterBtn setHidden:is_online == 0 ? YES : NO];
    [self.sellCenterImg setHidden:is_online == 0 ? YES : NO];
    [self.onlineBtn setHidden:is_online == 0 ? YES : NO];
    [self.onlineImg setHidden:is_online == 0 ? YES : NO];
    [self.myCourseBtn setTitle:is_online == 0 ? @"在线客服" : @"我的课程" forState:UIControlStateNormal];
    [self.myCourseImg setImage:is_online == 0 ? [UIImage imageNamed:@"我的客服"] : [UIImage imageNamed:@"mycourse"]];
    [self.myLiveBtn setTitle:is_online == 0 ? @"我的简历" : @"我的直播" forState:UIControlStateNormal];
    [self.myLiveImg setImage:is_online == 0 ? [UIImage imageNamed:@"我的简历"] : [UIImage imageNamed:@"我的直播"]];
    
}
- (IBAction)selectedButtonClick:(UIButton *)sender {
    
    if (self.selectedButtonBlock) {
        self.selectedButtonBlock(sender.tag) ;
    }
}

-(void)setUserInforModel:(URUserInforModel *)userInforModel{
    
    _userInforModel = userInforModel ;
    
    if (is_online==0) {
        self.balanceLabel.text = @"个人信息" ;
    } else {
         self.balanceLabel.text = @"余额" ;
    }
    
    if (userLoginStatus) {
        [self.personalImage  sd_setImageWithURL:[NSURL  URLWithString:userInforModel.thumbnail] placeholderImage:[UIImage  imageNamed:@"headimg"]];
        
        self.phone.hidden = NO ;
        
        self.loginOutBtn.hidden = NO ;
        
        self.name.text = [NSString  stringWithFormat:@"%@",userInforModel.username?:@""] ;
        
        self.phone.text = [NSString  stringWithFormat:@"%@",userInforModel.phone?:@""] ;
        
        if (is_online==0) {
            self.blanaceLabel.text = userInforModel.phone?:@"" ;
            [self.courseActiveButton  setTitle:@"我的班级" forState:UIControlStateNormal];
        } else {
            self.blanaceLabel.text = [NSString  stringWithFormat:@"%@",userInforModel.balance?:@""] ;
            [self.courseActiveButton  setTitle:@"课程激活" forState:UIControlStateNormal];
        }
        
        self.collectionLabel.text = [NSString  stringWithFormat:@"%@",userInforModel.collection_topic?:@""] ;
        
        self.integralLabel.text = [NSString  stringWithFormat:@"%@",userInforModel.integral?:@""] ;
        
        if (userInforModel.is_vip.integerValue==1) {
            self.vipContemt.text = @"您已是VIP会员，可享受更多会员特权" ;
            [self.payButton  setTitle:@"查看权益" forState:UIControlStateNormal];
        } else {
            self.vipContemt.text = @"您是普通用户，可升级为VIP会员" ;
            [self.payButton  setTitle:@"立即充值" forState:UIControlStateNormal];
        }
        
        if (userInforModel.is_sing.integerValue==0) {
            [self.integralButton  setTitle:@"签到" forState:UIControlStateNormal];
        } else {
            [self.integralButton  setTitle:@"今日已签到" forState:UIControlStateNormal];
        }
    } else {
        self.name.text = @"您还未登录,请先登录" ;
        self.blanaceLabel.text = @"0.00" ;
        self.collectionLabel.text = @"0" ;
        self.integralLabel.text = @"0" ;
        self.vipContemt.text = @"您是普通用户，可升级为VIP会员" ;
        [self.payButton  setTitle:@"立即充值" forState:UIControlStateNormal];
        [self.integralButton  setTitle:@"签到" forState:UIControlStateNormal];
        self.phone.hidden = YES ;
        self.loginOutBtn.hidden = YES ;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
