//
//  NSString+IDCardVerify.m
//  PassNurseExam
//
//  Created by qc on 2018/8/14.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "NSString+IDCardVerify.h"

@implementation NSString (IDCardVerify)

+(BOOL)determinedValidateIDCardNumber:(NSString *)idCardNumber {
    
    idCardNumber = [idCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!idCardNumber) {
        return NO;
    }else {
        length = (int)idCardNumber.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [idCardNumber substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [idCardNumber substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumber
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCardNumber.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [idCardNumber substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumber
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCardNumber.length)];
            
            
            if(numberofMatch >0) {
                int S =   ([idCardNumber substringWithRange:NSMakeRange(0,1)].intValue +
                           [idCardNumber substringWithRange:NSMakeRange(10,1)].intValue) *7 +
                          ([idCardNumber substringWithRange:NSMakeRange(1,1)].intValue +
                           [idCardNumber substringWithRange:NSMakeRange(11,1)].intValue) *9 +
                          ([idCardNumber substringWithRange:NSMakeRange(2,1)].intValue +
                           [idCardNumber substringWithRange:NSMakeRange(12,1)].intValue) *10 +
                          ([idCardNumber substringWithRange:NSMakeRange(3,1)].intValue +
                           [idCardNumber substringWithRange:NSMakeRange(13,1)].intValue) *5 +
                          ([idCardNumber substringWithRange:NSMakeRange(4,1)].intValue +
                           [idCardNumber substringWithRange:NSMakeRange(14,1)].intValue) *8 +
                          ([idCardNumber substringWithRange:NSMakeRange(5,1)].intValue +
                           [idCardNumber substringWithRange:NSMakeRange(15,1)].intValue) *4 +
                          ([idCardNumber substringWithRange:NSMakeRange(6,1)].intValue +
                           [idCardNumber substringWithRange:NSMakeRange(16,1)].intValue) *2 +
                           [idCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 +
                           [idCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6 +
                           [idCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                NSString *eighteen = [idCardNumber substringWithRange:NSMakeRange(17,1)];
                if ([eighteen isEqualToString:@"x"]) {
                    eighteen = @"X";
                }
                
                if ([M isEqualToString:eighteen]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}

+(NSInteger)getGenderAccordingEnteredIDCardNumber:(NSString *)idCardNumber {
    
    idCardNumber = [idCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([idCardNumber length] == 18) {
        NSInteger number = [[idCardNumber substringWithRange:NSMakeRange(16,1)] integerValue];
        if (number % 2 == 0) {  //偶数为女
            return 0;
        } else {
            return 1;
        }
    }
    if ([idCardNumber length] == 16) {
        NSInteger number = [[idCardNumber substringWithRange:NSMakeRange(14,1)] integerValue];
        if (number % 2 == 0) {  //偶数为女
            return 0;
        } else {
            return 1;
        }
    }
    
    return 2;
}

+(NSInteger)getAgeAccordingEnteredIDCardNumber:(NSString *)idCardNumber {
    
    NSInteger length = (NSInteger)[idCardNumber length];
    NSInteger age = 0;
    NSInteger year = 0;
    
    switch (length) {
        case 15:{
            year = [idCardNumber substringWithRange:NSMakeRange(6,2)].integerValue + 1900;
            NSString *birthDay = [NSString stringWithFormat:@"%li%@%@", (long)year, [idCardNumber substringWithRange:NSMakeRange(8,2)], [idCardNumber substringWithRange:NSMakeRange(10,2)]];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            NSString *nowDay = [dateFormatter stringFromDate:[NSDate date]];
            
            age = ([nowDay integerValue] - [birthDay integerValue]) / 10000;
        }
            break;
        case 18:{
            year = [idCardNumber substringWithRange:NSMakeRange(6,4)].integerValue;
            NSString *birthDay = [NSString stringWithFormat:@"%li%@%@", (long)year, [idCardNumber substringWithRange:NSMakeRange(10,2)], [idCardNumber substringWithRange:NSMakeRange(12,2)]];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            NSString *nowDay = [dateFormatter stringFromDate:[NSDate date]];
            
            age = ([nowDay integerValue] - [birthDay integerValue]) / 10000;
        }
            break;
            
        default:
            break;
    }
    
    return age;
}

+(NSString *)getBirthDateAccordingEnteredIDCardNumber:(NSString *)idCardNumber {
    
    NSInteger length = (NSInteger)[idCardNumber length];

    NSInteger year = 0;
    
    NSString * birthDateString ;
    
    switch (length) {
        case 15:{
            year = [idCardNumber substringWithRange:NSMakeRange(6,2)].integerValue + 1900;
            NSString *birthDay = [NSString stringWithFormat:@"%li%@%@", (long)year, [idCardNumber substringWithRange:NSMakeRange(8,2)], [idCardNumber substringWithRange:NSMakeRange(10,2)]];
            
            NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
            [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [inputFormatter setDateFormat:@"yyyyMMdd"];
            NSDate *inputDate = [inputFormatter dateFromString:birthDay];
            NSLog(@"date= %@", inputDate);
            NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
            [outputFormatter setLocale:[NSLocale currentLocale]];
            [outputFormatter setDateFormat:@"yyyy-MM-dd"];
            
            birthDateString= [outputFormatter stringFromDate:inputDate];
            
        }
            break;
        case 18:{
            year = [idCardNumber substringWithRange:NSMakeRange(6,4)].integerValue;
            NSString *birthDay = [NSString stringWithFormat:@"%li%@%@", (long)year, [idCardNumber substringWithRange:NSMakeRange(10,2)], [idCardNumber substringWithRange:NSMakeRange(12,2)]];
            
            NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
            [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [inputFormatter setDateFormat:@"yyyyMMdd"];
            NSDate *inputDate = [inputFormatter dateFromString:birthDay];
            NSLog(@"date= %@", inputDate);
            NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
            [outputFormatter setLocale:[NSLocale currentLocale]];
            [outputFormatter setDateFormat:@"yyyy-MM-dd"];
            
            birthDateString= [outputFormatter stringFromDate:inputDate];
            
        }
            break;
            
        default:
            break;
    }
    
    return birthDateString;
}

+(BOOL)determineInputIDCradNumberLength:(NSString *)idCardNumber {
    
    if (idCardNumber.length==18) {
        
        return YES ;
        
    } else {
        
        return NO ;
        
    }
    
}

@end
