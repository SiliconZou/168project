//
//  AdminiMoreToolAlertView.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/20.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdminiMoreToolAlertView : UIView

@property (nonatomic,strong) UIButton *bannedBtn;//禁言按钮
@property (nonatomic,strong) UIButton *cutoverLineBtn;//全屏按钮
@property (nonatomic,strong) UIButton *delayBtn; //延时按钮
@property (nonatomic,strong) UIButton *nowOverBtn; //立即下课
@property (nonatomic,strong) UIButton *upSignBtn; //上课签到
@property (nonatomic,strong) UIButton *upClockinBtn; //上课打卡
@property (nonatomic,strong) UIButton *downSignBtn; //下课签到
- (void)showWithBanned:(BOOL)banned cutoverLine:(BOOL)cutoverLine commit:(void(^)(NSString * tag))commit cancel:(void(^)(void))cancel;

@end

NS_ASSUME_NONNULL_END
