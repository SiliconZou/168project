//
//  NSString+URRegular.m
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "NSString+URRegular.h"

#define REGEX_Number @"^[0-9]*$"

@implementation NSString (URRegular)

- (BOOL)ur_isNumberInteger {
    
    NSString *match= REGEX_Number;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)ur_isInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)ur_isFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)ur_isAmountFormat {
    
    if ([self ur_isInt]) {
        return [self integerValue] < 1000000;
    } else if ([self ur_isFloat]) {
        
        double doubleValue = [self doubleValue];
        
        if (doubleValue >= 1000000) return NO;
        
        if (([self length] - [NSString stringWithFormat:@"%d", (int)doubleValue].length) <= 3) {
            return YES;
        }
    }
    return NO;
}

// 是否是信用卡 12-19位
- (BOOL)ur_isCreditCardFormat {
    NSString *str = [self ur_removeSpaceAll];
    if ([str ur_isNumberInteger]) {
        return (str.length >= 12 && str.length <= 19);
    }
    return NO;
}

- (NSString *)ur_removeSpaceAll {
    return [self trimAllWhitespace];
}

- (NSString *)ur_removeSpecialCharacter {
    
    NSCharacterSet *set= [NSCharacterSet characterSetWithCharactersInString:@"@:;'／/：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$?^?'@#$%^&*()_+'\"“”》《。，,!.？！"];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)ur_bankcardFormat {
    NSMutableString *str = [[self ur_removeSpaceAll] mutableCopy];
    int tmp = str.length % 4;
    int i = (int)str.length - (tmp == 0 ? 4 : tmp);
    for (;i > 0; i -= 4) {
        [str insertString:@" " atIndex:i];
    }
    return str;
}

+ (BOOL)isEmpty:(NSString *)str{
    NSString *string = str;
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string length]==0) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isBlank:(NSString *)str{
    NSString *string = str;
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    if ([string isEqual:@"(null)"]) {
        return YES ;
    }
    
    if ([string  isEqual:@"null"]) {
        return YES ;
    }
    
    return NO;
}

+(BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}


- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimAllWhitespace{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(NSString *)addString:(NSString *)string{
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

-(NSString *)removeSubString:(NSString *)subString{
    if ([self containsString:subString]){
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

-(BOOL)containsOnlyLetters{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

-(BOOL)containsOnlyNumbers{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

-(BOOL)containsOnlyNumbersAndLetters{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

-(NSDate *)dateValueWithMillisecondsSince1970 {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
}

- (NSInteger)wordCount{
    
    NSInteger i, n = [self length], l = 0, a = 0, b = 0;
    
    unichar c;
    
    for(i=0;i<n;i++) {
        c=[self characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(NSInteger)ceilf((float)(a+b)/2.0);
}

//计算NSString字节长度,汉字占2个，英文占1个
-  (NSInteger)byteCount {
  
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
}



+ (NSString *)isOrNoPasswordStyle:(NSString *)passWordName{
    
    NSString * message;
    
    if (passWordName.length<6) {
        message=@"密码不能少于6位，请您重新输入";
    } else if (passWordName.length>18){
        message = @"密码最大长度为18位，请您重新输入";
    } else if ([self JudgeTheillegalCharacter:passWordName]){
        message = @"密码不能包含特殊字符，请您重新输入";
    } else if (![self judgePassWordLegal:passWordName]){
        message = @"密码必须同时包含大小字母和数字";
    }
    
    return message;
}

+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
    
    //提示标签不能输入特殊字符
    
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    if (![emailTest evaluateWithObject:content]) {
        
        return YES;
        
    }
    
    return NO;
    
}

+ (BOOL)judgePassWordLegal:(NSString *)pass{
    
    BOOL result ;
    
    // 判断长度大于6位后再接着判断是否同时包含数字和大小写字母
    
    NSString * regex =@"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,16}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    result = [pred evaluateWithObject:pass];
    
    return result;
    
}

+(NSString *)getUUIDString{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    
    CFRelease(uuid_ref);
    
    CFRelease(uuid_string_ref);
    
    return [uuid lowercaseString];
    
}

@end
