//
//  PersonalCenterCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/20.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalCenterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *inviteImg;
@property (weak, nonatomic) IBOutlet UIImageView *sellCenterImg;
@property (weak, nonatomic) IBOutlet UIImageView *myCourseImg;
@property (weak, nonatomic) IBOutlet UIImageView *courseActiveImg;
@property (weak, nonatomic) IBOutlet UIImageView *myResumeImg;
@property (weak, nonatomic) IBOutlet UIImageView *onlineImg;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UIButton *myCourseBtn;
@property (weak, nonatomic) IBOutlet UIButton *myResumeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sellCenterBtn;
@property (weak, nonatomic) IBOutlet UIButton *onlineBtn;
@property (weak, nonatomic) IBOutlet UIButton *myLiveBtn;
@property (weak, nonatomic) IBOutlet UIImageView *myLiveImg;

@property (weak, nonatomic) IBOutlet UIView *inviteBackView;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *personalImage;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIButton *integralButton;
@property (weak, nonatomic) IBOutlet UILabel *blanaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;
@property (weak, nonatomic) IBOutlet UIView *memberView;
@property (weak, nonatomic) IBOutlet UILabel *vipContemt;
@property (weak, nonatomic) IBOutlet  UILabel *balanceLabel;

@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UIButton *loginOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *courseActiveButton;

@property (nonatomic,strong) UIViewController * currentViewController;

@property (nonatomic,strong) URUserInforModel *userInforModel;


@property (nonatomic,copy) void (^selectedButtonBlock)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
