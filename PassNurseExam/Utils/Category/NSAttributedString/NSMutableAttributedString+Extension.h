//
//  NSMutableAttributedString+Extension.h
//  PassNurseExam
//
//  Created by qc on 2018/9/13.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0

@interface NSMutableAttributedString (Extension)

/**
 *  设置字体
 *
 *  @param font 字体类型
 */
- (void)ur_setFont:(UIFont *)font;

/**
 *  设置字体，并确定字体适用范围
 *
 *  @param font  字体
 *  @param range 范围
 */
- (void)ur_setFont:(UIFont *)font range:(NSRange)range;

/**
 *  设置字体，通过字体名称及字体大小
 *
 *  @param fontName 字体名称
 *  @param size     字体大小
 */
- (void)ur_setFontName:(NSString *)fontName size:(CGFloat)size;

/**
 *  设置字体，通过字体名称及字体大小,并设置字体适用范围
 *
 *  @param fontName 字体名称
 *  @param size     字体大小
 *  @param range    适用范围
 */
- (void)ur_setFontName:(NSString *)fontName size:(CGFloat)size range:(NSRange)range;

/**
 *  设置字体颜色
 *
 *  @param color 颜色
 */
- (void)ur_setTextColor:(UIColor *)color;

/**
 *  设置字体颜色，并确定适用范围
 *
 *  @param color 颜色
 *  @param range 适用范围
 */
- (void)ur_setTextColor:(UIColor*)color range:(NSRange)range;

/**
 *  设置下划线
 *
 *  @param style 下划线类型
 */
- (void)ur_setTextStrikethroughStyle:(NSUnderlineStyle)style;

/**
 *  设置下划线, 并确定适用范围
 *
 *  @param style 下划线类型
 *  @param range 适用范围
 */
- (void)ur_setTextStrikethroughStyle:(NSUnderlineStyle)style range:(NSRange)range;

/**
 *  设置下划线类型
 *
 *  @param style 下划线类型
 */
- (void)ur_setTextUnderLineStyle:(NSUnderlineStyle)style;

/**
 *  设置下划线类型，并设置适用范围
 *
 *  @param style 下划线类型
 *  @param range 适用范围
 */
- (void)ur_setTextUnderLineStyle:(NSUnderlineStyle)style range:(NSRange)range;

/**
 *  设置段落样式
 *
 *  @param block 回传样式信息
 */
- (void)ur_modifyParagraphStylesWithBlock:(void (^)(NSMutableParagraphStyle *paragraphStyle))block;
/**
 *  在一定范围内设置段落样式
 *
 *  @param range 范围
 *  @param block 回传样式信息
 */
- (void)ur_modifyParagraphStylesInRange:(NSRange)range withBlock:(void(^)(NSMutableParagraphStyle *paragraphStyle))block;

/**
 *  设置段落样式
 *
 *  @param paragraphStyle 样式
 */
- (void)ur_setParagraphStyle:(NSParagraphStyle *)paragraphStyle;

/**
 *  设置段落样式
 *
 *  @param paragraphStyle 样式
 *  @param range          范围
 */
- (void)ur_setParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range;

+(NSAttributedString*)getAttributedString:(NSString *)string withLineSpace:(CGFloat)lineSpace ;


@end

#endif
