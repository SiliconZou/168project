//
//  NSDateFormatter+StyleTransformation.m
//  PassNurseExam
//
//  Created by qc on 2018/8/16.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "NSDateFormatter+StyleTransformation.h"

@implementation NSDateFormatter (StyleTransformation)

+(instancetype)ur_serverDateFormatter{
    static NSDateFormatter * dateFormatter = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter  alloc] init];
        //直接指定时区
        NSTimeZone * timeZone = [NSTimeZone  timeZoneForSecondsFromGMT:8 * 3600] ;
        
        dateFormatter.timeZone = timeZone ;
        dateFormatter.dateFormat =@"yyyy-MM-ddTHH:mm:ss.SSSSSSSZ" ;
    });
    return dateFormatter ;
}

+(instancetype)ur_longDateFormatter{
    static NSDateFormatter * dateFormatter = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter  alloc] init];
        //直接指定时区
        NSTimeZone * timeZone = [NSTimeZone  timeZoneForSecondsFromGMT:8 * 3600] ;
        
        dateFormatter.timeZone = timeZone ;
        dateFormatter.dateFormat =@"yyyy-MM-dd HH:mm:ss" ;
    });
    return dateFormatter ;
}

+(instancetype)ur_shortDateFormatter{
    static NSDateFormatter * dateFormatter = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter  alloc] init];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone * timeZone = [NSTimeZone   localTimeZone] ;
        dateFormatter.timeZone = timeZone ;
        dateFormatter.dateFormat = @"yyyy-MM-dd" ;
    });
    return dateFormatter ;
}

+(instancetype)ur_shortDateTimeFormatter{
    static NSDateFormatter * dateFormatter = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter  alloc] init];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone * timeZone = [NSTimeZone   localTimeZone] ;
        dateFormatter.timeZone = timeZone ;
        dateFormatter.dateFormat = @"MM-dd HH:mm" ;
    });
    return dateFormatter ;
}

+(instancetype)ur_timeFormatter{
    static NSDateFormatter * dateFormatter = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter  alloc] init];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone * timeZone = [NSTimeZone   localTimeZone] ;
        dateFormatter.timeZone = timeZone ;
        dateFormatter.dateFormat =@"HH:mm:ss";
    });
    return dateFormatter ;
}

+(instancetype)ur_hourMinuteFormatter{
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        //[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
        fmt.timeZone = timezone;
        fmt.dateFormat = @"HH:mm";
    });
    return fmt;
}

+(instancetype)ur_monthDayFormatter{
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        //[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
        fmt.timeZone = timezone;
        fmt.dateFormat = @"MM-dd";
    });
    return fmt;
}

@end
