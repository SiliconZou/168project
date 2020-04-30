//
//  AnswerSheetView.h
//  PassNurseExam
//
//  Created by qc on 2019/9/14.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnswerSheetView : UIView

- (void)alertWithDataArr:(NSArray *)data linkQuestion:(void(^)(NSInteger nowIndex))linkBlock commit:(void(^)(void))commitBlock;

@end

NS_ASSUME_NONNULL_END
