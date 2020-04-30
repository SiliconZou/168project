//
//  StatisticsAlert2.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsAlert2 : UIView

- (void)showWithQuestionID:(NSString *)questionID cancel:(void(^)(void))cancel;

@end

NS_ASSUME_NONNULL_END
