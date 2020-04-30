//
//  URCreatQRCodeBarcode.h
//  MSSpeed
//
//  Created by qc on 2017/11/29.
//  Copyright © 2017年 qc. All rights reserved.
//

/**
 *创建二维码条形码
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface URCreatQRCodeBarcode : NSObject

/**
 二维码生成(Erica Sadun 原生代码生成)

 @param string 内容字符串
 @param size 二维码的大小
 @param color 二维码颜色
 @param bgColor 背景颜色
 @return 返回生成的二维码
 */
+(UIImage *)urCreatQRCodeWithString:(NSString *)string
                         withSize:(CGSize)size
                        withColor:(UIColor *)color
              withBackgroundColor:(UIColor *)bgColor ;

/**
 条形码生成

 @param string 内容字符串
 @param size 条形码的大小
 @param color 条形码的颜色
 @param bgColor 背景颜色
 @return 返回生成的条形码
 */
+(UIImage *)urCreatBarCodeWithString:(NSString *)string
                          withSize:(CGSize)size
                         withColor:(UIColor *)color
               withBackgroundColor:(UIColor *)bgColor ;

@end
