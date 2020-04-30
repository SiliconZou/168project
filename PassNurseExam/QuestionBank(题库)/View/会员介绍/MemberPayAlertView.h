//
//  MemberPayAlertView.h
//  PassNurseExam
//
//  Created by qc on 2019/9/25.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberPayAlertView : UIView

- (void)showAlertView:(NSDictionary *)dataDic finish:(void (^)(void))clickBlock;

@end

NS_ASSUME_NONNULL_END
