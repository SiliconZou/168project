//
//  MemberIntroductionAlertView.h
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberIntroductionAlertView : UIView

- (void)showAlertView:(void(^)(NSInteger buttonIndex))clickBlock;

- (void)dismiss ;

@end


NS_ASSUME_NONNULL_END
