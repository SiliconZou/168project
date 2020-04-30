//
//  GrabAnswerView.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/18.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GrabAnswerView : UIView

- (void)showWithData:(id)model commit:(void(^)(id))commit cancel:(void(^)(void))cancel;

@end

NS_ASSUME_NONNULL_END
