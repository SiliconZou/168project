//
//  NSDate+UR.m
//  BillManagerer
//
//  Created by XIN DONG on 2017/12/27.
//  Copyright © 2017年 BlackFish. All rights reserved.
//

#import "NSDate+UR.h"

@implementation NSDate (UR)

+ (NSDateFormatter *)ur_day_dateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    }
    return dateFormatter;
}

+ (NSDateFormatter *)ur_monthday_dateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"MM月dd日"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    }
    return dateFormatter;
}

+ (NSDateFormatter *)standand_dateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
//        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return dateFormatter;
}


+ (int)ur_dayFutureFromNowWithString:(NSString *)dateString {

    NSDateFormatter *day_dateFormatter = [NSDate ur_day_dateFormatter];

    NSDate *date = [day_dateFormatter dateFromString:dateString];
    NSDate *now = [day_dateFormatter dateFromString:[day_dateFormatter stringFromDate:[[NSDate date] switchToLocalDate]]];
    NSTimeInterval time = [date timeIntervalSinceDate:now];
    NSTimeInterval day = time/(3600*24);
    if ((day - (int)day) > 0.9) {
        return (int)day + 1;
    }
    return day;
}



+ (int)ur_dayFutureFromNowForAllWithString:(NSString *)dateString {

    NSDateFormatter *day_dateFormatter = [NSDate ur_day_dateFormatter];
    NSDateFormatter *standand_dateFormatter = [NSDate standand_dateFormatter];

    NSDate *date= [standand_dateFormatter dateFromString:dateString];
    NSDate *now = [day_dateFormatter dateFromString:[day_dateFormatter stringFromDate:[[NSDate date] switchToLocalDate]]];
    NSTimeInterval time = [date timeIntervalSinceDate:now];
    NSTimeInterval day = time/(3600*24);
    if ((day - (int)day) > 0.9) {
        return (int)day + 1;
    }
    return day;
}


/**
 从现在开始距离未来多少天 (NSDate)
 
 @return 从现在开始到指定date的天数
 */
- (int)ur_dayFutureFromNow {
    
    NSDateFormatter *day_dateFormatter = [NSDate ur_day_dateFormatter];
    
    NSDate *date = self;
    NSDate *now = [day_dateFormatter dateFromString:[day_dateFormatter stringFromDate:[[NSDate date] switchToLocalDate]]];
    NSTimeInterval time = [date timeIntervalSinceDate:now];
    NSTimeInterval day = time/(3600*24);
    if ((day - (int)day) > 0.9) {
        return (int)day + 1;
    }
    return day;
}


+ (NSString *)ur_timestamp; {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    return [NSString stringWithFormat:@"%llu",dTime];
}


// 标准时间转本地时间
- (NSDate *)switchToLocalDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    return destinationDateNow;
}

// 一个月后的日期
- (NSDate *)ur_nextMonthDate {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:1];
    [adcomps setDay:0];
    NSDate *newDate = [calendar dateByAddingComponents:adcomps toDate:self  options:0];
    return newDate;
}

@end

