//
//  UILabel+DateCountdown.m
//  TianYiMerchant
//
//  Created by qc on 2018/8/24.
//  Copyright © 2018年 HLM. All rights reserved.
//

#import "UILabel+DateCountdown.h"

@implementation UILabel (DateCountdown)

- (void)startTime:(NSString *)dateStr countDownType:(CountDownType)countdownType{
    
    __block int timeOut = 0;
    
    if (countdownType == countDown_type_s) {
        timeOut = [dateStr intValue];
    }else {
        //系统传过来的是13位的，包括毫秒，这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
        timeOut = [dateStr doubleValue]/1000.0 - [[NSDate date] timeIntervalSince1970];
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                switch (countdownType) {
                    case countDown_type_dHms:
                    {
                        self.text = [NSString stringWithFormat:@"时间：00天00时00分00秒"];
                        break;
                    }
                    case countDown_type_ms:
                    {
                        self.text = [NSString stringWithFormat:@"时间：00分00秒"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"CountDownEndNoti" object:nil];
                        break;
                    }
                    case countDown_type_s:
                    {
                        self.text = [NSString stringWithFormat:@"0秒"];
                        break;
                    }
                    default:
                        break;
                }
            });
            
        }else{
            
            switch (countdownType) {
                case countDown_type_dHms:
                {
                    int day = timeOut / (60 * 60 * 24);
                    int hour = timeOut % (60 * 60 * 24) / (60 * 60);
                    int minutes =  timeOut % (60 * 60 * 24) % (60 * 60) / 60;
                    int seconds =  timeOut % 60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.text = [NSString stringWithFormat:@"时间：%02d天%02d时%02d分%02d秒",day,hour,minutes,seconds];
                    });
                    break;
                }
                case countDown_type_ms:
                {
                    int minutes =  timeOut / 60;
                    int seconds =  timeOut % 60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.text = [NSString stringWithFormat:@"时间：%02d分%02d秒",minutes,seconds];
                    });
                    break;
                }
                case countDown_type_s:
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.text = [NSString stringWithFormat:@"%d秒",timeOut];
                    });
                    break;
                }
                default:
                    break;
            }
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}

@end
