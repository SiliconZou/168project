//
//  NSString+Size.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Size)
/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)ur_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)ur_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)ur_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)ur_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)ur_reverseString:(NSString *)strSrc;

/**
 求字符串占据的宽高

 @param maxSize 设置默认的宽高
 @param font 字体
 @return 实际宽高
 */
-(CGSize)ur_sizeContraintToSize:(CGSize)maxSize font:(UIFont *)font ;

/**
 求字符串占据的宽高

 @param maxSize 设置默认的宽高
 @param font 字体
 @param lineSpcing 行间距
 @param paragraphSpacing 段落间距
 @return 实际宽高
 */
-(CGSize)ur_sizeContraintToSize:(CGSize)maxSize font:(UIFont *)font lineSpacing:(CGFloat)lineSpcing paragraphSpacing:(CGFloat)paragraphSpacing;

/**
 求字符串占据的宽高

 @param maxSize 设置默认的宽高
 @param font 字体
 @param lineSpcing 行间距
 @return 实际宽高
 */
-(CGSize)ur_sizeContraintToSize:(CGSize)maxSize font:(UIFont *)font lineSpacing:(CGFloat)lineSpcing;

/**
 使用iOS7+的方法覆盖iOS6中deprecate的同名函数

 @param font 字体
 @return size value
 */
-(CGSize)ur_sizeWithFont:(UIFont *)font;

/**
 *  为消除Warning添加的方法
 *  Add by DamonLiu 2015年11月27日09:33:12
 *
 *  @param font 字体属性
 *  @param size Size
 *
 *  @return calculated Size
 */
-(CGSize)ur_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  求字符串占据的高度
 *
 *  @param font          字体
 *  @param width         行宽
 *  @param lineBreakMode 断行格式
 *
 *  @return 实际占用高度
 */
- (CGSize)ur_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  使用iOS7+的方法覆盖iOS6中deprecate的同名函数
 *
 *  @param font          font
 *  @param size          size
 *  @param lineBreakMode lineBreakMode description
 *
 *  @return calculated   Size
 */
- (CGSize)ur_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  iOS6中的这个方法会返回CGSize，但是suggest的drawIntRect:withAttributed方法返回void。 鉴于之前每个调用地方都不会用到这个返回值，这里
 *  直接返回一个CGSizeZero。  考虑使用上面提供的方法计算一个Size来返回，但是如果制定了文本的Rect的话，为什么还要计算Size？
 *
 *  @param rect          文本要显示的位置
 *  @param font          字体
 *  @param lineBreakMode 换行方式
 *  @param alignment     对齐方式
 *
 *  @return CGSizeZero
 */
- (CGSize)ur_drawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

@end
