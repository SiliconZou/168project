//
//  NSDate+URExtensions.m
//  PassNurseExam
//
//  Created by qc on 2018/9/13.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "NSDate+URExtensions.h"

static NSDictionary *weakDayStringDic = nil;

@implementation NSDate (EasyToUse)

- (NSDate *)ur_dateByAddingMonth:(NSInteger)months
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = months;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)ur_dateByAddingDay:(NSInteger)days
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSString *)ur_weekDayString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakDayStringDic = @{@1:@"周日",
                             @2:@"周一",
                             @3:@"周二",
                             @4:@"周三",
                             @5:@"周四",
                             @6:@"周五",
                             @7:@"周六"};
    });
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitWeekday
                                                                       fromDate:self];
    return weakDayStringDic[@(dateComponents.weekday)];
}

- (NSInteger)ur_year
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear
                                                                       fromDate:self];
    return dateComponents.year;
    
}

- (NSInteger)ur_month
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth
                                                                       fromDate:self];
    return dateComponents.month;
    
}

- (NSInteger)ur_day
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay
                                                                       fromDate:self];
    return dateComponents.day;
}

- (NSInteger)ur_hour
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour
                                                                       fromDate:self];
    return dateComponents.hour;
}

- (NSInteger)ur_minute
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute
                                                                       fromDate:self];
    return dateComponents.minute;
}

- (NSInteger)ur_second
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond
                                                                       fromDate:self];
    return dateComponents.second;
}

+ (NSTimeInterval)ur_timeStamp
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000;
    return time;
};

+ (NSString *)ur_timeStampString
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    NSString *timeString = [NSString stringWithFormat:@"%llu",dTime];
    return timeString;
}

+ (NSDate *)ur_dateFromNormalDateString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    dateFormatter = nil;
    
    return destDate;
}

+ (NSDate *)ur_dateFromDateString:(NSString *)dateString withFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: dateFormat];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    dateFormatter = nil;
    
    return destDate;
}

- (NSString *)ur_stringFromNormalDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *stringFromDate = [formatter stringFromDate:self];
    
    return stringFromDate;
}

- (NSString *)ur_stringFromDateWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *stringFromDate = [formatter stringFromDate:self];
    
    return stringFromDate;
}

- (BOOL)ur_isEarlierThan:(NSDate *)date
{
    if (self.timeIntervalSince1970 < date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

- (BOOL)ur_isEarlierThanOrEqualTo:(NSDate *)date
{
    if (self.timeIntervalSince1970 <= date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

- (BOOL)ur_isLaterThan:(NSDate *)date
{
    if (self.timeIntervalSince1970 > date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

- (BOOL)ur_isLaterThanOrEqualTo:(NSDate *)date
{
    if (self.timeIntervalSince1970 >= date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

//获取当前的时间
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

@end

