//
//  UILabel+DateCountdown.h
//  TianYiMerchant
//
//  Created by qc on 2018/8/24.
//  Copyright © 2018年 HLM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CountDownType) {
    countDown_type_dHms = 0,  //倒计时 天-时-分-秒
    countDown_type_ms,        //倒计时 分-秒
    countDown_type_s,         //倒计时 秒
};

@interface UILabel (DateCountdown)

- (void)startTime:(NSString *)dateStr countDownType:(CountDownType)countdownType;
    
@end
