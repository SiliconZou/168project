//
//  NSAttributedString+Extension.h
//  PassNurseExam
//
//  Created by qc on 2018/9/13.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0

@interface NSAttributedString (Extension)

/**
 *  以NSString字符串初始化对象的构造器方法
 *
 *  @param string 字符串
 *
 *  @return NSAttributedString对象
 */
+ (instancetype)ur_attributedStringWithString:(NSString *)string;

/**
 *  以NSAttributedString对象初始化对象的构造器方法
 *
 *  @param attrStr NSAttributedString对象
 *
 *  @return NSAttributedString对象
 */
+ (instancetype)ur_attributedStringWithAttributedString:(NSAttributedString *)attrStr;

/**
 *  ＊＊安全＊＊ 初始化attributedString
 *
 *  @param str 字符串
 *
 *  @return 富文本
 */
- (instancetype)ur_initWithString:(NSString *)str;

/**
 *  ＊＊安全＊＊ 初始化attributedString
 *
 *  @param str   字符串
 *  @param attrs 格式
 *
 *  @return 富文本
 */
- (instancetype)ur_initWithString:(NSString *)str attributes:(NSDictionary<NSString *, id> *)attrs;

/**
 *  计算NSAttributedString对象占据的尺寸
 *
 *  @param maxSize 设置默认最大尺寸
 *
 *  @return 实际尺寸
 */
- (CGSize)ur_sizeConstrainedToSize:(CGSize)maxSize;

/**
 *  计算某一范围内NSAttributedString对象占据的尺寸
 *
 *  @param maxSize  设置默认最大尺寸
 *  @param fitRange 范围
 *
 *  @return 实际尺寸
 */
- (CGSize)ur_sizeConstrainedToSize:(CGSize)maxSize fitRange:(NSRange *)fitRange;

@end

#endif
