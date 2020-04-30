//
//  NSString+PinYin.h
//  PassNurseExam
//
//  Created by qc on 2018/8/24.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PinYin)

/**
 匹配皮音字母，判断拼音字谜字符串是否完全匹配，包括了一些多音字的判断
 
 @param pinyin 传入需要匹配的拼音字母
 */
-(BOOL)ur_matchPinYin:(NSString *)pinyin ;

/**
 取字符串的首个拼音字母, 包括一些多音字的判断
 */
-(NSString *)ur_pinyinFirstLetterArray ;

@end
