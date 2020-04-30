//
//  UIImage+Operation.h
//  PassNurseExam
//
//  Created by qc on 2018/9/13.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Operation)

/**
 图片旋转(小图片的处理方法)

 @param image 需要旋转的图片
 @param orientation 旋转方向
 @return 返回旋转后的图片
 */
+(UIImage *)ur_image:(UIImage *)image rotation:(UIImageOrientation)orientation ;


/**
 图片旋转(大图片的处理方法)

 @param image 需要旋转的图片
 @param rotation 旋转方向
 @return 返回旋转后的图片
 */
+(UIImage *)ur_getRitationImage:(UIImage *)image rotation:(CGFloat)rotation ;


/**
 图片缩放(小图)

 @param image 需要缩放的图片
 @param newSize 缩放的尺寸
 @return 返回缩放后的图片
 */
+(UIImage *)ur_image:(UIImage *)image transformtoSize:(CGSize)newSize ;

/**
 图片缩放(大图)

 @param image 需要缩放的图片
 @param size 缩放的尺寸
 @return 返回缩放后的图片
 */
+(UIImage *)ur_resizeImage:(UIImage *)image toSize:(CGSize)size ;


#pragma mark ---- 获取图片第一帧
+ (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size;

@end
