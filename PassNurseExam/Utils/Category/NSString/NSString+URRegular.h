//
//  NSString+URRegular.h
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URRegular)

- (BOOL)ur_isNumberInteger;

- (BOOL)ur_isAmountFormat;

// 是否是信用卡 12-19位
- (BOOL)ur_isCreditCardFormat;

- (NSString *)ur_removeSpaceAll;

- (NSString *)ur_removeSpecialCharacter;

- (NSString *)ur_bankcardFormat;

/**
 *  判断字符串是否为空或nil，
 *  @param str 字符串
 *  @return 是／否
 */
+ (BOOL)isEmpty:(NSString *)str;

/**
 *  判断字符串是否为空或nil或只有空格，
 *  @param str 字符串
 *  @return 是／否
 */
+ (BOOL)isBlank:(NSString *)str;

+(BOOL)isBlankString:(NSString *)aStr ;

/**
 *  去除头尾空格
 *
 *  @return 字符串
 */
- (NSString *)trimString;

/**
 *  去除所有空格
 *
 *  @return 字符串
 */
- (NSString *)trimAllWhitespace;

/**
 添加字符串
 
 @param string 添加字符串
 @return 字符串
 */
- (NSString *)addString:(NSString *)string;


/**
 主字符串中移除某个字符串
 
 @param subString 某个字符串
 @return 字符串
 */
-(NSString *)removeSubString:(NSString *)subString;

-(BOOL)containsOnlyLetters;
-(BOOL)containsOnlyNumbers;
-(BOOL)containsOnlyNumbersAndLetters;

-(NSDate *)dateValueWithMillisecondsSince1970;

/**
 *  单词个数
 *
 *  @return 数目
 */
- (NSInteger)wordCount;

/**
 *  计算字符串字节长度
 *
 *  @return 长度
 */
- (NSInteger)byteCount;

+ (NSString *)isOrNoPasswordStyle:(NSString *)passWordName ;

/**
 * 判断字符串中是否含有数字和大小写字母
 */
+(BOOL)judgePassWordLegal:(NSString *)pass ;

/**
 获取uuid

 @return 返回
 */
+(NSString *)getUUIDString ;

@end
