//
//  LiveSectionManagerView.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionManagerView : UIView

- (void)showWithData:(LivePenetrateMsgModel*)model commit:(void(^)(NSInteger index))commit cancel:(void(^)(void))cancel;


@end

NS_ASSUME_NONNULL_END
