//
//  UIImage+Operation.m
//  PassNurseExam
//
//  Created by qc on 2018/9/13.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "UIImage+Operation.h"

@implementation UIImage (Operation)

#pragma mark ---- 图片旋转

+(UIImage *)ur_image:(UIImage *)image rotation:(UIImageOrientation)orientation {
    
    long  double rotate = 0.0 ;
    CGRect  rect ;
    float translateX = 0 ;
    float translateY = 0 ;
    float scaleX = 0 ;
    float scaleY = 0 ;
    
    switch (orientation) {
        case UIImageOrientationLeft:{
            rotate = M_PI_2 ;
            rect = CGRectMake(0, 0, image.size.height, image.size.width) ;
            translateX = 0 ;
            translateY = -rect.size.width ;
            scaleY = rect.size.width / rect.size.height ;
            scaleX = rect.size.height / rect.size.width ;
            
        }
            break;
            
        case UIImageOrientationRight:{
            rotate =3 *M_PI_2;
            rect =CGRectMake(0,0,image.size.height, image.size.width);
            translateX= -rect.size.height;
            translateY=0;
            scaleY =rect.size.width/rect.size.height;
            scaleX =rect.size.height/rect.size.width;
        }
            break ;
            
        case UIImageOrientationDown:{
            rotate =M_PI;
            rect =CGRectMake(0,0,image.size.width, image.size.height);
            translateX= -rect.size.width;
            translateY= -rect.size.height;
        }
            
        default:
            rotate =0.0;
            rect =CGRectMake(0,0,image.size.width, image.size.height);
            translateX=0;
            translateY=0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size) ;
    CGContextRef contextRef = UIGraphicsGetCurrentContext() ;
    // 做CTM交换
    CGContextTranslateCTM(contextRef, 0.0, rect.size.height) ;
    CGContextScaleCTM(contextRef, 1.0, -1.0) ;
    CGContextRotateCTM(contextRef, rotate) ;
    CGContextTranslateCTM(contextRef, translateX, translateY) ;
    
    CGContextScaleCTM(contextRef, translateX, translateY) ;
    
    // 绘制图片
    CGContextDrawImage(contextRef, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage) ;
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext() ;
    
    return newImage ;
}

+(UIImage *)ur_getRitationImage:(UIImage *)image rotation:(CGFloat)rotation {

    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIAffineTransform" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    CGAffineTransform transform = CATransform3DGetAffineTransform([self rotateTransFrom:CATransform3DIdentity clockWise:NO angle:rotation]);
    [filter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}

+(CATransform3D)rotateTransFrom:(CATransform3D)initialTransform clockWise:(BOOL)clockwise angle:(CGFloat)angle {
    CGFloat arg = angle * M_PI / 180.0f ;
    if (!clockwise) {
        arg *=-1 ;
    }
    
    CATransform3D transform = initialTransform ;
    transform = CATransform3DRotate(transform, arg, 0, 0, 1) ;
    CGFloat _flipState1 = 0 ;
    CGFloat _flipState2 = 0 ;
    transform = CATransform3DRotate(transform, _flipState1 * M_PI, 0, 1, 0) ;
    transform = CATransform3DRotate(transform, _flipState2 * M_PI, 1, 0, 0) ;
    
    return transform ;
}

#pragma mark -- 图片缩放

+(UIImage *)ur_image:(UIImage *)image transformtoSize:(CGSize)newSize {
    // 创建一个bitmap的context
    UIGraphicsBeginImageContext(newSize) ;
    
    // 绘制改变大小的图片
    [image   drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)] ;
    // 从当前context中创建一个改变大小后的图片
    UIImage * transformedImage = UIGraphicsGetImageFromCurrentImageContext() ;
    // 使当前的context出堆栈
    UIGraphicsEndImageContext() ;
    // 返回新的改变大小后的图片
    return  transformedImage ;
}

+(UIImage *)ur_resizeImage:(UIImage *)image toSize:(CGSize)size {
    
    CIImage * ciImage = [[CIImage  alloc] initWithImage:image];
    // 创建一个input image类型的滤镜
    CIFilter * filter  = [CIFilter   filterWithName:@"CIAffineTransform" keysAndValues:kCIInputImageKey,ciImage, nil];
    
    // 设置默认的滤镜效果
    [filter  setDefaults] ;
    
    // 设置缩放比例
    CGFloat  scale = 1 ;
    if (size.width!=CGFLOAT_MAX) {
        
        scale = (CGFloat)size.width / image.size.width ;
        
    } else if (size.height != CGFLOAT_MAX) {
        
        scale = (CGFloat)size.height / image.size.height ;
    }
    
    // 进行赋值
    CGAffineTransform  transform = CGAffineTransformMakeScale(scale, scale) ;
    [filter  setValue:[NSValue  valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    // 通过GPU的方式来进行处理
    CIContext * context = [CIContext  contextWithOptions:@{
                                                           kCIContextUseSoftwareRenderer:@(NO)
                                                           }] ;
    
    CIImage * outputImage = [filter  outputImage] ;
    CGImageRef cgImageRef = [context  createCGImage:outputImage fromRect:[outputImage  extent]] ;
    
    UIImage * resultImage = [UIImage   imageWithCGImage:cgImageRef] ;
    
    CGImageRelease(cgImageRef) ;
    
    return resultImage ;
}


#pragma mark ---- 获取图片第一帧
+ (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 600) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}

@end
