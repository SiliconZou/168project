
//
//  NSString+URDate.m
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "NSString+URDate.h"
#import "NSDate+UR.h"


@implementation NSString (URDate)

// yyyy-MM-dd 转 01月01日
- (NSString *)ur_dateFormatter_MonthDay {
    
    NSDateFormatter *dayFormatter = [NSDate ur_day_dateFormatter];
    NSDateFormatter *monthdayFormatter = [NSDate ur_monthday_dateFormatter];

    NSDate *date= [dayFormatter dateFromString:self];
    if (date == nil) return self;
    
    return [monthdayFormatter stringFromDate:date];
}

// yyyy-MM-dd 转 yyyy年MM月
- (NSString *)ur_dateFormatter_YearMonth {
    if (self.length == 10) {
        return [NSString stringWithFormat:@"%@年%@月", [self substringWithRange:NSMakeRange(0, 4)], [self substringWithRange:NSMakeRange(5, 2)]];
    }
    return self;
}

// 标准格式 转 yyyy-MM-dd
- (NSString *)ur_dateFormatter_FromStandard {
    
    NSDateFormatter *day_dateFormatter = [NSDate ur_day_dateFormatter];
    NSDateFormatter *standand_dateFormatter = [NSDate standand_dateFormatter];
    return [day_dateFormatter stringFromDate:[standand_dateFormatter dateFromString:self]];
}
// yyyy-MM-dd 转 12月
-(NSString *)ur_dateFormatter_Month
{
    return [NSString stringWithFormat:@"%@月",[self substringWithRange:NSMakeRange(5, 2)]];
}
// yyyy-MM-dd 转 2017年
-(NSString *)ur_dateFormatter_Year
{
    return [NSString stringWithFormat:@"%@年",[self substringWithRange:NSMakeRange(0, 4)]];
}

- (NSDate *)ur_date_Day {
    
    NSDateFormatter *day_dateFormatter = [NSDate standand_dateFormatter];
    return [day_dateFormatter dateFromString:self];
}

// 2017-12-14 00:00:06 转 01-30 16:35
- (NSString *)ur_dateFormatter_repay {
    if (self.length == 19) {
        return [NSString stringWithFormat:@"%@ %@", [self substringWithRange:NSMakeRange(5, 5)], [self substringWithRange:NSMakeRange(11, 5)]];
    }
    return self;
}

+(NSString *)getTimeFromTimestampWithTimeStirng:(NSString *)time{
    
    NSDate * date = [NSDate  dateWithTimeIntervalSince1970:[time  integerValue]/1000] ;
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter  setDateFormat:@"YYYY-MM-dd"] ;
    
    return [dateFormatter  stringFromDate:date] ;
}

+(NSString *)getTimeWithTimeStirng:(NSString *)time{
    
    NSDate * date = [NSDate  dateWithTimeIntervalSince1970:[time  integerValue]/1000] ;
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter  setDateFormat:@"MM-dd hh:mm"] ;
    
    return [dateFormatter  stringFromDate:date] ;
}

+(NSString *)getDateDisplayString:(long long) miliSeconds{
    
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy-MM-dd hh:mm";
    } else {
        dateFmt.AMSymbol = @"上午";
        dateFmt.PMSymbol = @"下午";
        dateFmt.dateFormat = @"aaa";
    }
    return [dateFmt stringFromDate:myDate];
}

+(NSString *)ur_getNowTimeStamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;

}


@end
