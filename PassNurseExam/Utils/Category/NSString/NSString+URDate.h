//
//  NSString+URDate.h
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URDate)

// yyyy-MM-dd 转 01月01日
- (NSString *)ur_dateFormatter_MonthDay;

// yyyy-MM-dd 转 yyyy年MM月
- (NSString *)ur_dateFormatter_YearMonth;

// 标准格式 转 yyyy-MM-dd
- (NSString *)ur_dateFormatter_FromStandard;
// yyyy-MM-dd 转 12月
-(NSString *)ur_dateFormatter_Month;
// yyyy-MM-dd 转 2017年
-(NSString *)ur_dateFormatter_Year;

// yyyy-MM-dd 转 date
- (NSDate *)ur_date_Day;

// 2017-12-14 00:00:06 转 01-30 16:35
- (NSString *)ur_dateFormatter_repay;

/**
 时间戳转时间

 @param time 时间戳
 @return 转换成的时间
 */
+(NSString *)getTimeFromTimestampWithTimeStirng:(NSString *)time ;

+(NSString *)getTimeWithTimeStirng:(NSString *)time ;

+(NSString *)getDateDisplayString:(long long) miliSeconds ;

+(NSString *)ur_getNowTimeStamp ;


@end
