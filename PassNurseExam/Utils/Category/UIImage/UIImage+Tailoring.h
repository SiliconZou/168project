//
//  UIImage+Tailoring.h
//  PassNurseExam
//
//  Created by qc on 2018/8/28.
//  Copyright © 2018年 ucmed. All rights reserved.
//

/**
 * 图片裁剪处理
 */

#import <UIKit/UIKit.h>

@interface UIImage (Tailoring)

/**
 CGContext方式裁剪

 @param image 要裁剪的图片
 @param cornerRadius 圆角的大小
 @return 返回裁剪之后的图片
 */
+(UIImage *)imageWithCGContextClip:(UIImage *)image withCornerRadius:(CGFloat)cornerRadius ;

/**
 贝塞尔曲线方式裁剪

 @param image 要裁剪的图片
 @param cornerRadius 圆角的大小
 @return 返回裁剪之后的图片
 */
+(UIImage *)imageWithBezierPathClip:(UIImage *)image withCornerRadius:(CGFloat)cornerRadius ;


//+(void)setRoundImageWithURL:(NSURL *)url placeHoder:(UIImage *)placeHoder cornerRadius:(CGFloat)radius ;


@end
