//
//  UIImage+Utility.h
//  MSSpeed
//
//  Created by qc on 2017/11/22.
//  Copyright © 2017年 qc. All rights reserved.
//

/**
 * 图片压缩处理
 */

#import <UIKit/UIKit.h>

@interface UIImage (Utility)

/**
 截取屏幕
 是否需要?
 */
+(UIImage *)ur_captureScreen:(CGFloat)resolution
NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.") ;

/**
 剪切出一个rect
 */
-(UIImage *)ur_clipWithRect:(CGRect)rect ;

/**
 根据颜色返回一张图片

 @param color 颜色
 @return 返回图片
 */
+(UIImage *)ur_imageWithColor:(UIColor *)color ;

-(UIImage *)ur_resizedImageByMagick:(NSString *)spec ;

/**
 根据宽度重新创建一个等比例的图片

 @param width 宽度
 @return 图片
 */
-(UIImage *)ur_resizedImageByWidth:(NSUInteger)width ;

/**
 根据高度重新创建一个等比例的图片

 @param height 高度
 @return 图片
 */
-(UIImage *)ur_resizedImageByHeight:(NSUInteger)height ;

/**
 根据size最长边，重新创建一个等比例的图片

 @param size 高和宽尺寸
 @return 图片
 */
-(UIImage *)ur_resizedImageWithMaximumSize:(CGSize)size ;

/**
 根据Size最短边，重新创建一个等比例的图片

 @param size 高和宽尺寸
 @return 图片
 */
-(UIImage *)ur_resizedImageByMinimumSize:(CGSize)size ;

/**
 设置图片border
 
 @param imageName 图片名称
 @param borderWidth border宽度
 @param borderColor border颜色
 @return 返回剪切后的图片
 */
+(UIImage *)ur_circleImageWithName:(NSString *)imageName
                   withBorderWidth:(CGFloat)borderWidth
                   withBorderColor:(UIColor *)borderColor ;

/**
 保持宽高比设置在多大的区域显示
 
 @param imageName 图片名称
 @param targetSize 显示区域大小
 @return 返回图片
 */
-(UIImage *)ur_sourceImage:(UIImage *)imageName
            withTargetSize:(CGSize)targetSize ;

/**
 指定宽度按比例缩放
 
 @param image 图片名称
 @param targetWidth  targetWidth
 @return 返回图片
 */
-(UIImage *)ur_sourceImage:(UIImage *)image
           withTargetWidth:(CGFloat)targetWidth ;
/**
 *  等比例缩放
 */
-(UIImage *)ur_sourceImage:(UIImage *)image
                 withScale:(CGFloat)scale ;

+(UIImage *)ur_resizableImageWithImageName:(NSString *)imageName;
/** 压缩图片到指定的物理大小*/
-(NSData *)ur_compressImageDataWithMaxLimit:(CGFloat)maxLimit;

-(UIImage *)ur_compressImageWithMaxLimit:(CGFloat)maxLimit;

/**
 图片压缩
 
 @param image 要压缩的图片
 @return 返回压缩之后的图片
 */
+(UIImage *)ur_imageCompression:(UIImage *)image ;

/**
 图片压缩
 
 @param image 要压缩的图片
 @param maskName maskName
 @return 返回压缩之后的图片
 */
+(UIImage *)ur_imageCompression:(UIImage *)image
                   withMaskName:(NSString*)maskName ;

+(UIImage *)ur_imageCompression:(UIImage *)image
                withCustomImage:(UIImage *)imageName ;


/**
 *  图片边框
 *
 *  @param image        待处理图片
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 *  @param cornerRadius 边框弧度
 *
 *  @return 处理过的图片
 */
+ (UIImage *)ur_imageCorner:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;

@end
