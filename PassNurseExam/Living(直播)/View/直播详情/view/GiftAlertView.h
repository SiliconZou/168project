//
//  GiftAlertView.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftAlertView : UIView

@property (nonatomic,assign) BOOL isShow;

@property (nonatomic,strong) UIViewController * currentViewController;

@property (nonatomic,copy) NSString * tagName;

@property (nonatomic,copy) NSString * teacherID;

- (void)showWithGiftList:(NSArray *)list commit:(void(^)(LiveGivingDataModel *model))commit cancel:(void(^)(void))cancel;

@end

NS_ASSUME_NONNULL_END
