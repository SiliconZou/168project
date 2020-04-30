//
//  NSString+IDCardVerify.h
//  PassNurseExam
//
//  Created by qc on 2018/8/14.
//  Copyright © 2018年 ucmed. All rights reserved.
//

/**
 *  本类与身份证相关
 */
#import <Foundation/Foundation.h>

@interface NSString (IDCardVerify)

/**
 判断输入的身份证号码是否有效

 @param idCardNumber 身份证号码
 @return 返回判断的结果
 */
+(BOOL)determinedValidateIDCardNumber:(NSString *)idCardNumber ;

/**
 根据输入的身份证号码获取性别

 @param idCardNumber 身份证号码
 @return 返回性别  0 女  1 男
 */
+(NSInteger)getGenderAccordingEnteredIDCardNumber:(NSString *)idCardNumber ;

/**
 根据输入的身份证号码获取年龄

 @param idCardNumber 身份证号码
 @return 返回计算的年龄
 */
+(NSInteger)getAgeAccordingEnteredIDCardNumber:(NSString *)idCardNumber ;

/**
 根据输入的身份证号码获取出生日期

 @param idCardNumber 身份证号码
 @return 返回 获取到的出生日期
 */
+(NSString *)getBirthDateAccordingEnteredIDCardNumber:(NSString *)idCardNumber ;

/**
 判断输入的身份证号是否是18位

 @param idCardNumber 身份证号码
 @return 返回判断结果
 */
+(BOOL)determineInputIDCradNumberLength:(NSString *)idCardNumber ;

@end
