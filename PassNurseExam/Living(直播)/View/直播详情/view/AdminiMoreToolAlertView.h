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

- (void)showWithBanned:(BOOL)banned cutoverLine:(BOOL)cutoverLine commit:(void(^)(NSString * tag))commit cancel:(void(^)(void))cancel;

@end

NS_ASSUME_NONNULL_END
