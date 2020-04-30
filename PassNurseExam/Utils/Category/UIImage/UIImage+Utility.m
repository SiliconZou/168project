//
//  UIImage+Utility.m
//  MSSpeed
//
//  Created by qc on 2017/11/22.
//  Copyright © 2017年 qc. All rights reserved.
//

#import "UIImage+Utility.h"
#import <objc/runtime.h>

static char newIsCustomImage;
static char customImageName;

@implementation UIImage (Utility)

-(UIImage *)ur_clipWithRect:(CGRect)rect{
    rect.size.height = rect.size.height * self.scale ;
    rect.size.width = rect.size.width * self.scale ;
    rect.origin.x = rect.origin.x * self.scale ;
    rect.origin.y = rect.origin.y * self.scale ;
    
    CGImageRef  imageRef = self.CGImage ;
    CGImageRef  subImageRef = CGImageCreateWithImageInRect(imageRef, rect) ;
    
    UIImage * smallImage = [UIImage    imageWithCGImage:subImageRef scale:self.scale orientation:self.imageOrientation] ;
    CGImageRelease(subImageRef) ;
    
    return smallImage ;
}

-(UIImage *)imageWithRotatedByDegress:(CGFloat)degress{
    CGSize  rotatedSize = [UIScreen   mainScreen].bounds.size ;
    UIGraphicsBeginImageContext(rotatedSize) ;
    
    CGContextRef   bitmap = UIGraphicsGetCurrentContext() ;
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2) ;
    
    CGContextRotateCTM(bitmap, (degress)) ;
    
    CGContextScaleCTM(bitmap, 1.0, -1.0) ;
    
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width/2, -self.size.height/2, self.size.width, self.size.width), self.CGImage) ;
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext() ;
    
    return newImage ;
}

/**
 横屏的时候直接截screen；竖屏由于更多中有一个分享，所以取thedelegate视图
 */
+(UIImage *)ur_captureScreen:(CGFloat)resolution{
    id<UIApplicationDelegate>delegate = [UIApplication  sharedApplication].delegate ;
    UIWindow * window = delegate.window ;
    UIView * view = window ;
    // 真机上分享到腾讯微博图片变小(新浪好的)，写2.0或0.0都不行。估计是腾讯api问题。先改成1.0吧
    CGSize  size = CGSizeMake(window.screen.bounds.size.width, window.screen.bounds.size.height) ;
    
    UIGraphicsBeginImageContextWithOptions(size,NO, resolution) ;
    
    CGContextRef   contextRef = UIGraphicsGetCurrentContext() ;
    
    [view.layer renderInContext:contextRef];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext() ;
    
    UIGraphicsEndImageContext() ;
    
    return [image   ur_clipWithRect:CGRectMake(0, 20, image.size.width, image.size.height)] ;
}

/**
 根据颜色返回一张图片
 
 @param color 颜色
 @return 返回图片
 */
+(UIImage *)ur_imageWithColor:(UIColor *)color{
    CGRect  imageRect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f) ;
    
    UIGraphicsBeginImageContext(imageRect.size) ;
    
    CGContextRef  contextRef = UIGraphicsGetCurrentContext() ;
    
    CGContextSetFillColorWithColor(contextRef, color.CGColor) ;
    
    CGContextFillRect(contextRef, imageRect) ;
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext() ;
    
    UIGraphicsEndImageContext() ;
    
    return  image ;
}

-(UIImage *)ur_resizedImageByMagick:(NSString *)spec{
    if ([spec   hasPrefix:@"!"]) {
        NSString * specWithoutSuffix = [spec  substringToIndex:spec.length] ;
        
        NSArray * array =[specWithoutSuffix    componentsSeparatedByString:@"x"];
        
        NSUInteger  width = [[array  objectAtIndex:0] integerValue];
        
        NSUInteger  height = [[array   objectAtIndex:1] integerValue];
        
        UIImage * image = [self   ur_resizedImageByMinimumSize:CGSizeMake(width, height)] ;
        
        return [image  ur_croppedImageWithRect:CGRectMake(0, 0, width, height)] ;
    }
    
    if ([spec  hasSuffix:@"#"]) {
        NSString * specWithOutSuffix = [spec  substringToIndex:spec.length] ;
        
        NSArray * array =[specWithOutSuffix  componentsSeparatedByString:@"x"] ;
        
        NSUInteger width = [[array   objectAtIndex:0] integerValue];
        
        NSUInteger height = [[array objectAtIndex:1] integerValue];
        
        UIImage * image = [self   ur_resizedImageByMinimumSize:CGSizeMake(width, height)] ;
        
        return [image  ur_croppedImageWithRect:CGRectMake((image.size.width-width)/2, (image.size.height-height)/2, width, height)] ;
    }
    
    if ([spec  hasSuffix:@"^"]) {
        NSString * specWithOutSuffix = [spec  substringToIndex:spec.length-1];
        NSArray * array = [specWithOutSuffix  componentsSeparatedByString:@"x"] ;
       
       return  [self  ur_resizedImageByMinimumSize:CGSizeMake([[array  objectAtIndex:0] longLongValue], [[array  objectAtIndex:0] longLongValue])] ;
    }
    
    NSArray * array = [spec  componentsSeparatedByString:@"x"] ;
    
    if (array.count ==1) {
        return [self  ur_resizedImageByWidth:spec.integerValue] ;
    }
    
    if ([[array  objectAtIndex:0] isEqualToString:@""]) {
        return [self  ur_resizedImageByHeight:[[array  objectAtIndex:1]integerValue]] ;
    }
    
    return [self ur_resizedImageWithMaximumSize:CGSizeMake([array[0]  longLongValue], [array[1] longLongValue])] ;
}

-(CGImageRef)newCGImageWithCorrectionOrientation{
    if (self.imageOrientation == UIImageOrientationDown) {
        return CGImageRetain(self.CGImage) ;
    }
    
    UIGraphicsBeginImageContext(self.size) ;
    
    CGContextRef  contextRef = UIGraphicsGetCurrentContext() ;
    
    if (self.imageOrientation == UIImageOrientationRight) {
        
        CGContextRotateCTM(contextRef, 90 * M_PI / 180) ;
    }else if (self.imageOrientation == UIImageOrientationLeft){
        CGContextRotateCTM(contextRef, -90 * M_PI/ 180) ;
    }else if (self.imageOrientation ==UIImageOrientationUp){
        CGContextRotateCTM(contextRef, 180 * M_PI /180) ;
    }

    [self  drawAtPoint:CGPointMake(0, 0)] ;
    
    CGImageRef  imageRef = CGBitmapContextCreateImage(contextRef) ;
   
    UIGraphicsEndImageContext() ;
    
    return imageRef  ;
}

-(UIImage *)ur_resizedImageByWidth:(NSUInteger)width{
    CGImageRef  imageRef = [self  newCGImageWithCorrectionOrientation] ;
    CGFloat origin_width = CGImageGetWidth(imageRef) ;
    CGFloat origin_height = CGImageGetHeight(imageRef) ;
    CGFloat ratio = width / origin_width ;
    CGImageRelease(imageRef);
    return [self  ur_drawImageInBounds:CGRectMake(0, 0, width, round(origin_height * ratio))] ;
}

-(UIImage *)ur_resizedImageByHeight:(NSUInteger)height{
    CGImageRef  imageRef = [self  newCGImageWithCorrectionOrientation] ;
    CGFloat origin_width = CGImageGetWidth(imageRef) ;
    CGFloat origin_height = CGImageGetHeight(imageRef) ;
    CGFloat ratio = height / origin_height ;
    CGImageRelease(imageRef);
    return [self ur_drawImageInBounds:CGRectMake(0, 0, round(origin_width * ratio), height)] ;
}

-(UIImage *)ur_resizedImageByMinimumSize:(CGSize)size{
    CGImageRef  imageRef =[self   newCGImageWithCorrectionOrientation];
    CGFloat origin_width = CGImageGetWidth(imageRef) ;
    CGFloat origin_height = CGImageGetHeight(imageRef) ;
    CGFloat width_ratio = size.width / origin_width ;
    CGFloat height_ratio = size.height / origin_height ;
    CGFloat scale_ratio = width_ratio > height_ratio ? width_ratio : height_ratio ;
    CGImageRelease(imageRef);
    return [self  ur_drawImageInBounds:CGRectMake(0, 0, round(origin_width * scale_ratio), round(origin_height * scale_ratio))] ;
}

-(UIImage *)ur_resizedImageWithMaximumSize:(CGSize)size{
    CGImageRef imgRef = [self newCGImageWithCorrectionOrientation];
    CGFloat original_width  = CGImageGetWidth(imgRef);
    CGFloat original_height = CGImageGetHeight(imgRef);
    CGFloat width_ratio = size.width / original_width;
    CGFloat height_ratio = size.height / original_height;
    CGFloat scale_ratio = width_ratio < height_ratio ? width_ratio : height_ratio;
    CGImageRelease(imgRef);
    
    return [self ur_drawImageInBounds:CGRectMake(0, 0, round(original_width * scale_ratio), round(original_width * scale_ratio))] ;
}

- (UIImage *)ur_drawImageInBounds:(CGRect)bounds{
 UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    [self drawInRect: bounds];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

-(UIImage *)ur_croppedImageWithRect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size) ;
    CGContextRef contextRef = UIGraphicsGetCurrentContext() ;
    CGRect  drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, rect.size.width, rect.size.height) ;
    CGContextClipToRect(contextRef, drawRect) ;
    [self  drawInRect:drawRect] ;
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext() ;
    UIGraphicsEndImageContext() ;
    return image ;
}

+(UIImage *)ur_circleImageWithName:(NSString *)imageName
                   withBorderWidth:(CGFloat)borderWidth
                   withBorderColor:(UIColor *)borderColor{
    UIImage * oldImage = [UIImage  imageNamed:imageName] ;
    //1.开启上下文
    CGFloat imageWidth = oldImage.size.width ;
    CGFloat imageHeight = oldImage.size.height ;
    CGSize imageSize = CGSizeMake(imageWidth, imageHeight) ;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0) ;
    //2.获取当前上下文
    CGContextRef  contextRef = UIGraphicsGetCurrentContext() ;
    // 花边框  大圆
    [borderColor  set] ;
    
    CGFloat  bigRadius = imageWidth * 0.5 ;
    CGFloat  centerX = bigRadius ;
    CGFloat  centerY = bigRadius ;
    CGContextAddArc(contextRef, centerX, centerY, bigRadius, 0, M_PI *2.0, 0) ;
    
    CGContextFillPath(contextRef) ;
    
    // 小圆
    CGFloat   smallRadius = bigRadius - borderWidth ;
    CGContextAddArc(contextRef, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextClip(contextRef) ;
    
    [oldImage  drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)] ;
    // 取图
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext() ;
    // 结束上下文
    UIGraphicsEndImageContext() ;
    
    return newImage ;
}
// 指定大小，要把图显示到多大的区域
-(UIImage *)ur_sourceImage:(UIImage *)imageName
            withTargetSize:(CGSize)targetSize{
    UIImage * newImage = nil ;
    CGSize  imageSize = imageName.size ;
    CGFloat imageWidth = imageName.size.width ;
    CGFloat imageHeight  =imageName.size.height ;
    CGFloat targetWidth =targetSize.width ;
    CGFloat targetHeight = targetSize.height ;
    CGFloat scaleFactor = 0.0f;
    CGFloat scaleWidth = targetWidth ;
    CGFloat scaleHeight = targetHeight ;
    CGPoint thumbnailPoint = CGPointZero ;
    
    if (CGSizeEqualToSize(imageSize, targetSize)==NO) {
        CGFloat widthFactor = targetWidth / imageWidth;
        CGFloat heightFactor = targetHeight / imageHeight;
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor ;
        }else{
            scaleFactor = heightFactor ;
        }
        
        scaleWidth = imageWidth * scaleFactor;
        scaleHeight = imageHeight * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaleHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaleWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaleWidth;
    thumbnailRect.size.height = scaleHeight;
    
    [imageName drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if (!newImage) {
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(UIImage *)ur_sourceImage:(UIImage *)image
           withTargetWidth:(CGFloat)targetWidth{
    UIImage *newImage = nil;
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [image drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(UIImage *)ur_sourceImage:(UIImage *)image
                 withScale:(CGFloat)scale{
    if (scale > 1) {
        return image;
    }
    
    UIImage *newImage = nil;
    CGSize imageSize = image.size;
    CGPoint targetPoint = CGPointZero;
    targetPoint.x = (imageSize.width - imageSize.width * scale) * 0.5f;
    targetPoint.y = (imageSize.height - imageSize.height * scale) * 0.5f;
    
    CGFloat imageW = imageSize.width;
    CGFloat imageH = imageSize.height;
    CGFloat targetWidth = imageW * scale;
    CGFloat targetHeight = imageH * scale;
    CGRect targetRect = (CGRect){targetPoint, CGSizeMake(targetWidth, targetHeight)};
    [image drawInRect:targetRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (!newImage) {
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage *)ur_resizableImageWithImageName:(NSString *)imageName{
    UIImage *loginImage = [UIImage imageNamed:imageName];
    CGFloat topEdge = loginImage.size.height * 0.5;
    CGFloat leftEdge = loginImage.size.width * 0.5;
    return [loginImage resizableImageWithCapInsets:UIEdgeInsetsMake(topEdge, leftEdge, topEdge, leftEdge)];
}

/** 压缩图片到指定的物理大小*/
- (NSData *)ur_compressImageDataWithMaxLimit:(CGFloat)maxLimit {
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.2f; // 最大压缩品质
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    NSInteger imageDataLength = [imageData length];
    while ((imageDataLength <= maxLimit * 1024 * 1024) && (compression >= maxCompression)) {
        compression -= 0.03;
        imageData = UIImageJPEGRepresentation(self, compression);
        imageDataLength = [imageData length];
    }
    return imageData;
}

-(UIImage *)ur_compressImageWithMaxLimit:(CGFloat)maxLimit {
    NSData *imageData = [self ur_compressImageDataWithMaxLimit:maxLimit];
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

+(UIImage *)ur_imageCompression:(UIImage *)image{
    
    return [self   ur_imageCompression:image
                          withMaskName:nil] ;
}

+(UIImage *)ur_imageCompression:(UIImage *)image
                   withMaskName:(NSString *)maskName{
    double imageSize ;
    NSData * dataLength =UIImageJPEGRepresentation(image, 1) ;
    
    NSInteger fixelW = (NSInteger)image.size.width ;
    NSInteger fixelH= (NSInteger)image.size.height;
    NSInteger thumbW = fixelW % 2  == 1 ? fixelW + 1 : fixelW;;
    NSInteger thumbH = fixelH % 2  == 1 ? fixelH + 1 : fixelH;
    double scale = ((double)fixelW/fixelH);
    
    if (scale <= 1 && scale > 0.5625) {
        
        if (fixelH < 1664) {
            if (dataLength.length/1024.0 < 150) {
                return image;
            }
            imageSize = (fixelW * fixelH) / pow(1664, 2) * 150;
            imageSize = imageSize < 60 ? 60 : imageSize;
        }
        else if (fixelH >= 1664 && fixelH < 4990) {
            thumbW = fixelW / 2;
            thumbH = fixelH / 2;
            imageSize   = (thumbH * thumbW) / pow(2495, 2) * 300;
            imageSize = imageSize < 60 ? 60 : imageSize;
        }
        else if (fixelH >= 4990 && fixelH < 10240) {
            thumbW = fixelW / 4;
            thumbH = fixelH / 4;
            imageSize = (thumbW * thumbH) / pow(2560, 2) * 300;
            imageSize = imageSize < 100 ? 100 : imageSize;
        }
        else {
            NSInteger multiple = fixelH / 1280 == 0 ? 1 : fixelH / 1280;
            thumbW = fixelW / multiple;
            thumbH = fixelH / multiple;
            imageSize = (thumbW * thumbH) / pow(2560, 2) * 300;
            imageSize = imageSize < 100 ? 100 : imageSize;
        }
    }
    else if (scale <= 0.5625 && scale > 0.5) {
        
        if (fixelH < 1280 && dataLength.length/1024 < 200) {
            
            return image;
        }
        NSInteger multiple = fixelH / 1280 == 0 ? 1 : fixelH / 1280;
        thumbW = fixelW / multiple;
        thumbH = fixelH / multiple;
        imageSize = (thumbW * thumbH) / (1440.0 * 2560.0) * 400;
        imageSize = imageSize < 100 ? 100 : imageSize;
    }
    else {
        int multiple = (int)ceil(fixelH / (1280.0 / scale));
        thumbW = fixelW / multiple;
        thumbH = fixelH / multiple;
        imageSize = ((thumbW * thumbH) / (1280.0 * (1280 / scale))) * 500;
        imageSize = imageSize < 100 ? 100 : imageSize;
    }
    
    return [self   ur_imageCompression:image withThumbWidth:thumbW withThumbHeight:thumbH withImageSize:imageSize withMaskName:maskName] ;
}

+ (UIImage *)ur_imageCompression:(UIImage *)image
                 withCustomImage:(UIImage *)imageName {
    
    if (imageName) {
        objc_setAssociatedObject(self, &newIsCustomImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &customImageName, imageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [self ur_imageCompression:image withMaskName:nil];
}

+(UIImage *)ur_imageCompression:(UIImage *)image
                 withThumbWidth:(NSInteger)thumbWidth
                withThumbHeight:(NSInteger)thumbHeight
                  withImageSize:(double)imageSize
                   withMaskName:(NSString *)maskName{
    UIImage *thumbImage = [image fixOrientation];
    thumbImage = [thumbImage resizeImage:image thumbWidth:thumbWidth thumbHeight:thumbHeight withMask:maskName];
    
    int qualityCompress = 1.0;
    
    NSData *dataLen = UIImageJPEGRepresentation(thumbImage, qualityCompress);
    
    NSUInteger lenght = dataLen.length;
    while (lenght / 1024 > imageSize && qualityCompress > 0.06) {
        
        qualityCompress -= 0.06;
        dataLen    = UIImageJPEGRepresentation(thumbImage, qualityCompress);
        lenght     = dataLen.length;
        thumbImage = [UIImage imageWithData:dataLen];
    }
    NSLog(@"Luban-iOS image data size after compressed ==%f kb",dataLen.length/1024.0);
    return thumbImage;
}

- (UIImage *)resizeImage:(UIImage *)image
              thumbWidth:(NSInteger)width
             thumbHeight:(NSInteger)height
                withMask:(NSString *)maskName {
    
    int outW = (int)image.size.width;
    int outH = (int)image.size.height;
    
    int inSampleSize = 1;
    
    if (outW > width || outH > height) {
        int halfW = outW / 2;
        int halfH = outH / 2;
        
        while ((halfH / inSampleSize) > height && (halfW / inSampleSize) > width) {
            inSampleSize *= 2;
        }
    }
    int heightRatio = (int)ceil(outH / (float) height);
    int widthRatio  = (int)ceil(outW / (float) width);
    
    if (heightRatio > 1 || widthRatio > 1) {
        
        inSampleSize = heightRatio > widthRatio ? heightRatio : widthRatio;
    }
    CGSize thumbSize = CGSizeMake((NSUInteger)((CGFloat)outW/widthRatio), (NSUInteger)((CGFloat)outH/heightRatio));
    
    UIGraphicsBeginImageContext(thumbSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [image drawInRect:CGRectMake(0, 0, thumbSize.width, thumbSize.height)];
    if (maskName) {
        
        CGContextTranslateCTM (context, thumbSize.width / 2, thumbSize.height / 2);
        CGContextScaleCTM (context, 1, -1);
        
        [self drawMaskWithString:maskName context:context radius:0 angle:0 colour:[UIColor colorWithRed:1.0  green:1.0 blue:1.0 alpha:0.5] font:[UIFont systemFontOfSize:38.0] slantAngle:(CGFloat)(M_PI/6) size:thumbSize];
    }
    else {
        BOOL iscustom = [objc_getAssociatedObject(self, &newIsCustomImage) boolValue];
        
        if (iscustom) {
            NSString *imageName = objc_getAssociatedObject(self, &customImageName);
            UIImage *imageMask = [UIImage imageNamed:imageName];
            if (imageMask) {
                [imageMask drawInRect:CGRectMake(0, 0, thumbSize.width, thumbSize.height)];
            }
        }
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    objc_setAssociatedObject(self, &newIsCustomImage, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return resultImage;
}

- (UIImage *)fixOrientation {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void) drawMaskWithString:(NSString *)str
                    context:(CGContextRef)context
                     radius:(CGFloat)radius
                      angle:(CGFloat)angle
                     colour:(UIColor *)colour
                       font:(UIFont *)font
                 slantAngle:(CGFloat)slantAngle
                       size:(CGSize)size{
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:colour,
                                 NSFontAttributeName:font};
    // Save the context
    CGContextSaveGState(context);
    // Undo the inversion of the Y-axis (or the text goes backwards!)
    CGContextScaleCTM(context, 1, -1);
    // Move the origin to the centre of the text (negating the y-axis manually)
    CGContextTranslateCTM(context, radius * cos(angle), -(radius * sin(angle)));
    // Rotate the coordinate system
    CGContextRotateCTM(context, -slantAngle);
    // Calculate the width of the text
    CGSize offset = [str sizeWithAttributes:attributes];
    // Move the origin by half the size of the text
    CGContextTranslateCTM (context, -offset.width / 2, -offset.height / 2); // Move the origin to the centre of the text (negating the y-axis manually)
    // Draw the text
    
    NSInteger width  = ceil(cos(slantAngle)*offset.width);
    NSInteger height = ceil(sin(slantAngle)*offset.width);
    
    NSInteger row    = size.height/(height+100.0);
    NSInteger coloum = size.width/(width+100.0)>6?:6;
    CGFloat xPoint   = 0;
    CGFloat yPoint   = 0;
    for (NSInteger index = 0; index < row*coloum; index++) {
        
        xPoint = (index%coloum) *(width+100.0)-[UIScreen mainScreen].bounds.size.width;
        yPoint = (index/coloum) *(height+100.0);
        [str drawAtPoint:CGPointMake(xPoint, yPoint) withAttributes:attributes];
        xPoint += -[UIScreen mainScreen].bounds.size.width;
        yPoint += -[UIScreen mainScreen].bounds.size.height;
        [str drawAtPoint:CGPointMake(xPoint, yPoint) withAttributes:attributes];
    }
    
    // Restore the context
    CGContextRestoreGState(context);
}

+ (UIImage *)ur_imageCorner:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGContextMoveToPoint(context, width - borderWidth, cornerRadius + borderWidth);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, width - borderWidth, height - borderWidth, width - cornerRadius - borderWidth, height - borderWidth, cornerRadius);  // 右下角
    CGContextAddArcToPoint(context, borderWidth, height - borderWidth, borderWidth, height - cornerRadius - borderWidth, cornerRadius); // 左下角
    CGContextAddArcToPoint(context, borderWidth, borderWidth, width - borderWidth, borderWidth, cornerRadius); // 左上角
    CGContextAddArcToPoint(context, width - borderWidth, borderWidth, width - borderWidth, cornerRadius + borderWidth, cornerRadius); // 右上角
    CGContextClip(context);
    CGRect rect = CGRectMake(0, 0, image.size.width , image.size.height);
    [image drawInRect:rect];
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

@end
