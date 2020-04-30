//
//  UnitPracticeDetailBottomView.h
//  PassNurseExam
//
//  Created by qc on 2019/9/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnitPracticeDetailBottomView : UIView

@property (nonatomic,copy) void(^selectedButtonBlock)(NSInteger  tag);

@property (nonatomic,strong) UIButton * sheetButton;
@property (nonatomic,strong) UIButton * collectButton;

@end

NS_ASSUME_NONNULL_END
