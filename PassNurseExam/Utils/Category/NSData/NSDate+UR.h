//
//  NSDate+UR.h
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (UR)

/**
 从现在开始距离未来多少天 (yyyy-MM-dd)

 @param dateString 指定日期
 @return 从现在开始到指定date的天数
 */
+ (int)ur_dayFutureFromNowWithString:(NSString *)dateString;


/**
 从现在开始距离未来多少天 (yyyy-MM-dd HH:mm:ss)

 @param dateString 指定日期
 @return 从现在开始到指定date的天数
 */
+ (int)ur_dayFutureFromNowForAllWithString:(NSString *)dateString;


/**
 从现在开始距离未来多少天 (NSDate)

 @return 从现在开始到指定date的天数
 */
- (int)ur_dayFutureFromNow;


/**
 时间戳字符串-1970 (ms)
 
 @return 时间戳字符串-1970 (ms)
 */
+ (NSString *)ur_timestamp;

+ (NSDateFormatter *)ur_day_dateFormatter;
+ (NSDateFormatter *)ur_monthday_dateFormatter;
+ (NSDateFormatter *)standand_dateFormatter;

// 一个月后的日期
- (NSDate *)ur_nextMonthDate;

@end
