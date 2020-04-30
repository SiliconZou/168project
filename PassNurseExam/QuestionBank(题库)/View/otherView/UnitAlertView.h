//
//  UnitAlertView.h
//  PassTheNurseExam
//
//  Created by 张旭 on 2017/10/25.
//  Copyright © 2017年 LeFu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectTypeBlock)(NSInteger tag);
@interface UnitAlertView : UIView

@property (nonatomic, copy)selectTypeBlock sSelectTypeBlock;

@end
