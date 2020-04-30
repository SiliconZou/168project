//
//  UIImage+Tailoring.m
//  PassNurseExam
//
//  Created by qc on 2018/8/28.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "UIImage+Tailoring.h"
#import "SDWebImageManager.h"

@implementation UIImage (Tailoring)

+(UIImage *)imageWithCGContextClip:(UIImage *)image withCornerRadius:(CGFloat)cornerRadius {
    
    NSInteger imageWidth = image.size.width * image.scale ;
    NSInteger imageHeight = image.size.height * image.scale ;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), false, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, cornerRadius);
    CGContextAddArcToPoint(context, 0, 0, cornerRadius, 0, cornerRadius);
    CGContextAddLineToPoint(context, imageWidth-cornerRadius, 0);
    CGContextAddArcToPoint(context, imageWidth, 0, imageWidth, cornerRadius, cornerRadius);
    CGContextAddLineToPoint(context, imageWidth, imageHeight-cornerRadius);
    CGContextAddArcToPoint(context, imageWidth, imageHeight, imageWidth-cornerRadius, imageHeight, cornerRadius);
    CGContextAddLineToPoint(context, cornerRadius, imageHeight);
    CGContextAddArcToPoint(context, 0, imageHeight, 0, imageHeight-cornerRadius, cornerRadius);
    CGContextAddLineToPoint(context, 0, cornerRadius);
    CGContextClosePath(context);
    
    CGContextClip(context);     // 先裁剪 context，再画图，就会在裁剪后的 path 中画
    [image drawInRect:CGRectMake(0, 0, imageWidth, imageHeight)];       // 画图
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage *dealImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return dealImage ;
}

+(UIImage *)imageWithBezierPathClip:(UIImage *)image withCornerRadius:(CGFloat)cornerRadius {
    
    NSInteger imageWidth = image.size.width * image.scale ;
    NSInteger imageHeight = image.size.height * image.scale ;
    CGRect rect = CGRectMake(0, 0, imageWidth, imageHeight);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), false, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    [image drawInRect:rect];
    
    UIImage *dealImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return dealImage;
}


//+(void)setRoundImageWithURL:(NSURL *)url placeHoder:(UIImage *)placeHoder cornerRadius:(CGFloat)radius{
//    NSString *urlStirng = [url absoluteString];
//    NSString *imagenName = [NSString stringWithFormat:@"%@%@",urlStirng,@"roundImage"];
//    __block NSString *path = [self base64String:imagenName];
//    UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:path];
//    if (image){
//        [self setImage:image];
//        return;
//    }else if (placeHoder){
//        [self setImage:placeHoder];
//    }
//    __weak typeof(self)weakSelf = self;
//    if (url){
//        
//        [[SDWebImageManager   sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//            
//        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//            __strong typeof(weakSelf)stongSelf = weakSelf;
//            if (!finished) return;
//            if (!image) return;
//            @synchronized (self) {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                    UIImage *cirleImage =  [image cirleImage];
//                    [[SDImageCache   sharedImageCache] storeImage:cirleImage forKey:path completion:^{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [stongSelf performSelector:@selector(reloadImageData:) withObject:cirleImage afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
//                        });
//                    }];
//                }) ;
//            }
//        }];
//    }
//}
//
//+(NSString*)base64String:(NSString*)str{
//    NSData* originData = [str dataUsingEncoding:NSASCIIStringEncoding];
//    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    return [NSString stringWithFormat:@"%@.png",encodeResult];
//}
//
//- (void)reloadImageData:(UIImage*)image{
//   [self setImage:image];
//  
//}
//
//- (UIImage*)cirleImage{
//    // NO代表透明
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
//    
//    // 获得上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    // 添加一个圆
//    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
//    CGContextAddEllipseInRect(ctx, rect);
//    // 裁剪
//    CGContextClip(ctx);
//    // 将图片画上去
//    [self drawInRect:rect];
//    UIImage *cirleImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return cirleImage;
//}
//
//+(void)setImage:(UIImage *)image {
//    
//}



@end
