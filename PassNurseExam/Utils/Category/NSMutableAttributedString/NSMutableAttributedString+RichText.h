//
//  NSMutableAttributedString+RichText.h
//  PassNurseExam
//
//  Created by qc on 2018/8/28.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (RichText)

/**
 单纯改变一句话中的某些字的颜色

 @param color 需要改变成的颜色
 @param totalString 总的字符串
 @param subArray 需要改变的字符串的数组
 @return 生成的富文本
 */
+(NSMutableAttributedString *)ur_changeColorWithColor:(UIColor *)color  totalString:(NSString *)totalString subStringArray:(NSArray *)subArray ;

/**
 改变某些字的颜色和段落的行间距

 @param totalString 总的字符串
 @param color 需要改变成的颜色
 @param subArray 需要改变的字符串的数组
 @param lineSpace 行间距
 @return 生成的富文本
 */
+(NSMutableAttributedString *)ur_changeColorAndLineSpaceWithTotalString:(NSString *)totalString color:(UIColor *)color subStringArray:(NSArray *)subArray lineSpace:(CGFloat)lineSpace ;

/**
 单纯改变句子的字间距

 @param totalString 需要改变的字符串
 @param space 字间距
 @return 生成的富文本
 */
+(NSMutableAttributedString *)ur_changeSpaceWithTotalString:(NSString *)totalString space:(CGFloat)space ;

/**
 单纯改变段落的行间距

 @param totalString 需要改变的字符串
 @param lineSpace 行间距
 @return 生成的富文本
 */
+(NSMutableAttributedString *)ur_changeLineSpaceWithTotalString:(NSString *)totalString lineSpace:(CGFloat)lineSpace ;

/**
 同时改变行间距和字间距

 @param totalString 需要改变的字符串
 @param lineSpace 行间距
 @param textSpace 字间距
 @return 生成的富文本
 */
+(NSMutableAttributedString *)ur_changeLineAndTextSpaceWithTotalString:(NSString *)totalString lineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace ;

/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ur_changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray ;

/**
 *  为某些文字改为链接形式
 *
 *  @param totalString 总的字符串
 *  @param subArray    需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ur_addLinkWithTotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;

@end
