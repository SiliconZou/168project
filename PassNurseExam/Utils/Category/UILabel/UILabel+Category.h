//
//  UILabel+Category.h
//  上海长征医院
//
//  Created by ucmed on 17/5/2.
//  Copyright © 2017年 卓健科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

/**
 *  改变行间距
 */
+ (void)ur_changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)ur_changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)ur_changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

/**
 通过Lable宽度设置高度

 @param width 已知宽度
 @param text 文本内容
 */
- (void)ur_autoResetHeightByWidth:(CGFloat)width text:(NSString *)text ;

/**
   通过Label宽度设置高度, 并设置最低高度
 
   @param width  已知宽度
   @param text       文本内容
   @param miniHeight 最低高度
 */
- (void)ur_autoResetHeightByWidth:(CGFloat)width text:(NSString *)text  miniHeight:(CGFloat)miniHeight ;

/**
 通过Label宽度设置高度，并设置每一行高度

 @param width 已知宽度
 @param text 文本内容
 @param height 每行高度
 */
- (void)ur_autoResetHeightByWidth:(CGFloat)width text:(NSString *)text  oneLineHeight:(CGFloat)height ;

/**
 计算已知文本内容与宽度的情况下，控件的高度

 @param width 已知宽度
 @param text 文本内容
 @return 高度
 */
- (CGFloat)ur_calculHeightByWidth:(CGFloat)width tetx:(NSString *)text ;

/**
 自定义宽度
 */
- (void)ur_autoResetWidth ;

@end
