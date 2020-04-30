//
//  UIControl+MultipleJumps.h
//  PassNurseExam
//
//  Created by qc on 2019/4/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (MultipleJumps)

@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;// 可以用这个给重复点击加间隔


@end

NS_ASSUME_NONNULL_END
