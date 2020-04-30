//
//  NSDate+urExtensions.h
//  PassNurseExam
//
//  Created by qc on 2018/9/13.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (EasyToUse)

/**
 *  计算日期是哪一天
 *
 *  @return 天数
 */
- (NSInteger)ur_day;

/**
 *  计算日期是星期几
 *
 *  @return 周几
 */
- (NSString *)ur_weekDayString;

/**
 *  计算日期是哪一月
 *
 *  @return 月份
 */
- (NSInteger)ur_month;

/**
 *  计算日期是哪一年
 *
 *  @return 年份
 */
- (NSInteger)ur_year;

/**
 *  计算日期是哪一小时
 *
 *  @return 小时
 */
- (NSInteger)ur_hour;

/**
 *  计算日期是哪一分钟
 *
 *  @return 分钟
 */
- (NSInteger)ur_minute;

/**
 *  计算日期是哪一秒
 *
 *  @return 秒
 */
- (NSInteger)ur_second;

/**
 *  获取增加自定义天数后的日期
 *
 *  @param days 自定义天数
 *
 *  @return (日期)NSDate对象
 */
- (NSDate *)ur_dateByAddingDay:(NSInteger)days;

/**
 *  获取增加自定义月数后的日期
 *
 *  @param months 自定义月数
 *
 *  @return (日期)NSDate对象
 */
- (NSDate *)ur_dateByAddingMonth:(NSInteger)months;

/**
 *  返回1970年以来的时间戳
 *
 *  @return 1970年以来的时间戳
 */
+ (NSTimeInterval)ur_timeStamp;

+ (NSString *)ur_timeStampString;
/**
 *  使用日期字符串初始化NSDate对象(默认格式: @"yyyy-MM-dd HH:mm:ss")
 *
 *  @param dateString 日期字符串
 *
 *  @return (日期)NSDate对象
 */
+ (NSDate *)ur_dateFromNormalDateString:(NSString *)dateString;

/**
 *  将日期字符串初始化NSDate对象(使用自定义日期格式)
 *
 *  @param dateString 日期字符串
 *
 *  @param dateFormat 日期格式(与字符串一致) 如：字符串：@"2016-04-25 17:31", 则格式：@"yyyy-MM-dd HH:mm"
 *
 *  @return (日期)NSDate对象
 */
+ (NSDate *)ur_dateFromDateString:(NSString *)dateString withFormat:(NSString *)dateFormat;

/**
 *  将NSDate对象转化为日期字符串(默认格式: @"yyyy-MM-dd HH:mm:ss")
 *
 *  @return 日期字符串
 */
- (NSString *)ur_stringFromNormalDate;

/**
 *  将NSDate对象转化为日期字符串(使用自定义日期格式)
 *
 *  @param dateFormat 日期格式 如：@"yyyy-MM-dd HH:mm"
 *
 *  @return 日期字符串
 */
- (NSString *)ur_stringFromDateWithFormat:(NSString *)dateFormat;

/**
 *  当前日期是否早于指定日期
 *
 *  @param date 指定日期
 *
 *  @return 是否早于
 */
- (BOOL)ur_isEarlierThan:(NSDate *)date;

/**
 *  当前日期是否早于或者等于指定日期
 *
 *  @param date 指定日期s
 *
 *  @return 是否早于或者等于
 */
- (BOOL)ur_isEarlierThanOrEqualTo:(NSDate *)date;

/**
 *  当前日期是否晚于指定日期
 *
 *  @param date 指定日期
 *
 *  @return 是否晚于
 */
- (BOOL)ur_isLaterThan:(NSDate *)date;

/**
 *  当前日期是否晚于或者等于指定日期
 *
 *  @param date 指定日期
 *
 *  @return 是否晚于或者等于
 */
- (BOOL)ur_isLaterThanOrEqualTo:(NSDate *)date;

/**
 是否为同一天
 */
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2 ;

//获取当前的时间

+(NSString*)getCurrentTimes ;
@end
