//
//  UIImage+ImageWithColor.h
//  PassNurseExam
//
//  Created by qc on 2018/8/14.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageWithColor)

/**
 将颜色转换成image

 @param color color
 @return 返回转换成image
 */
+ (UIImage *)ur_imageWithColor:(UIColor *)color;

/**
 生成渐变色图片
 
 @param colors 传入渐变颜色数组
 @param size 图片大小
 @return 图片
 */
+ (UIImage *)ur_imageWithGradientColors:(NSArray*)colors
                                   size:(CGSize)size
                                  start:(CGPoint)start
                                    end:(CGPoint)end;


/**
 图片渲染

 @param imageName 图片名称
 @return 返回image
 */
+(UIImage *)ur_imageWithOriginalName:(NSString *)imageName ;



/**
 添加背景色 渐变色
 
 @param bounds 按钮的bounds
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param direction 绘制方向
 @return 渐变图片 0 水平；1 垂直
 */
+ (UIImage *)gradientBackImgWithFrame:(CGRect)bounds startColor:(UIColor *)startColor endColor:(UIColor *)endColor direction:(NSInteger)direction;


@end
