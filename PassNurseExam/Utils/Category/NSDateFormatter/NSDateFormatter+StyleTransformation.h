//
//  NSDateFormatter+StyleTransformation.h
//  PassNurseExam
//
//  Created by qc on 2018/8/16.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (StyleTransformation)

/**
 服务时间  "2015-06-29T17:12:46.9409259+08:00"
 */
+(instancetype)ur_serverDateFormatter ;

/**
 "2015-04-25 13:39:09" 年月日时分秒
 
 */
+(instancetype)ur_longDateFormatter ;

/**
 "2015-04-25" 年月日
 */
+(instancetype)ur_shortDateFormatter ;

/**
 "04-25 13:39" 月日时分
 */
+(instancetype)ur_shortDateTimeFormatter ;

/**
 "13:39:09" 时分秒
 */
+(instancetype)ur_timeFormatter ;

/**
 "13:39" 时分
 */
+(instancetype)ur_hourMinuteFormatter ;

/**
 "06-29" 月日
 */
+(instancetype)ur_monthDayFormatter ;

@end
