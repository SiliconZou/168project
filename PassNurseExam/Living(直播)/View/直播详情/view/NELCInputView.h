//
//  NELCInputView.h
//  PassTheNurseExam
//
//  Created by ZFBest on 2019/2/17.
//  Copyright © 2019 LeFu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NELCInputView : UIView

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, copy) void(^shareBlock)(void);
@property (nonatomic, copy) void(^sendBlock)(NSString *text);
@property (weak, nonatomic) IBOutlet UIButton *givingButton;


///0用户个人未禁言 1用户个人被禁言
@property (nonatomic, assign, readonly) BOOL perBanned;
///0未全体禁言 1全体用户禁言
@property (nonatomic, assign, readonly) BOOL allBanned;

/**
 处理进入页面时的禁言状态

 @param perBanned 个人禁言
 @param allBanned 全体禁言
 */
- (void)handlePerBanned:(BOOL)perBanned allBanned:(BOOL)allBanned;

///清空输入框
- (void)clearText;


@end

NS_ASSUME_NONNULL_END
