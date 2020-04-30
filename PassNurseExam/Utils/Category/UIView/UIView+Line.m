//
//  UIView+Line.m
//  PassNurseExam
//
//  Created by qc on 2018/9/17.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "UIView+Line.h"

typedef NS_ENUM(NSInteger ,URLineDirection) {
    URLineDirectionUp = 0,
    URLineDirectionDown ,
    URLineDirectionLeft ,
    URLineDirectionRight
};

static NSMutableDictionary *imageCache = nil;

@implementation UIView (Line)

- (void )addLineWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endpoint lineColor:(UIColor *)color lineWidth:(CGFloat)lineWidth
{
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:startPoint];
    [linePath addLineToPoint:endpoint];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = lineWidth;
    lineLayer.strokeColor = color.CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    
    [self.layer addSublayer:lineLayer];
}

+ (NSString *)cacheKeyWithColor:(UIColor *)color direction:(URLineDirection)direction{
    CGFloat r,g,b;
    [color getRed:&r green:&g blue:&b alpha:NULL];
    return [NSString stringWithFormat:@"%f_%f_%f_%@", r, g, b, @(direction)];
}

+ (UIImage *)lineImageWithColor:(UIColor *)color direction:(URLineDirection)direction{
    if (imageCache == nil){
        imageCache = [NSMutableDictionary dictionary];
    }
    
    NSString *cacheKey = [self cacheKeyWithColor:color direction:direction];
    UIImage *image = imageCache[cacheKey];
    if (image){
        return image;
    }
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize size = CGSizeMake(scale, scale);
    CGRect rect = CGRectZero;
    
    switch (direction) {
        case URLineDirectionUp:
            rect = CGRectMake(0.0f, 0.0f, scale, 1.0f);
            break;
        case URLineDirectionDown:
            rect = CGRectMake(0.0f, scale - 1.0f, scale, 1.0f);
            break;
        case URLineDirectionLeft:
            rect = CGRectMake(0.0f, 0.0f, 1.0f, scale);
            break;
        case URLineDirectionRight:
            rect = CGRectMake(scale - 1.0f, 0.0f, 1.0f, scale);
            break;
        default:
            break;
    }
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageCache[cacheKey] = image;
    return image;
}

+(UIView *)ur_topLineWithColor:(UIColor *)color {
    
    UIImageView * imageView = [[UIImageView  alloc] initWithFrame:CGRectMake(0, 0, 1.0f, 1.0f)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth ;
    imageView.image = [self   lineImageWithColor:color direction:URLineDirectionUp] ;
    return imageView ;
}

+(UIView *)ur_bottomLineWithColor:(UIColor *)color {
    
    UIImageView * imageView = [[UIImageView  alloc] initWithFrame:CGRectMake(0, 0, 1.0f, 1.0f)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin ;
    imageView.image = [self   lineImageWithColor:color direction:URLineDirectionDown] ;
    return imageView ;
}

+(UIView *)ur_leftLineWithColor:(UIColor *)color {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1.0f, 1.0f)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView.image = [self lineImageWithColor:color direction:URLineDirectionLeft];
    return imageView;
}

+(UIView *)ur_rightLineWithColor:(UIColor *)color {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1.0f, 1.0f)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    imageView.image = [self lineImageWithColor:color direction:URLineDirectionRight];
    return imageView;
}

-(UIView *)ur_addAllCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    return [self  ur_addAllCornerRadius:cornerRadius borderColor:borderColor borderWidth:borderWidth fillColor:[UIColor   clearColor] size:self.bounds.size] ;
}

-(UIView *)ur_addAllCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth fillColor:(UIColor *)fillColor {
    
    return [self  ur_addAllCornerRadius:cornerRadius borderColor:borderColor borderWidth:borderWidth fillColor:fillColor size:self.bounds.size] ;
}

-(UIView *)ur_addAllCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth fillColor:(UIColor *)fillColor size:(CGSize)size {
    //将size为0 的view不做处理，否则会发出警告
    if (size.width ==0 || size.height ==0) {
        return [[UIView  alloc] init];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, false, [UIScreen  mainScreen].scale) ;
    CGContextRef contextRef = UIGraphicsGetCurrentContext() ;
    
    CGContextSetLineWidth(contextRef, borderWidth) ;
    CGContextSetStrokeColorWithColor(contextRef, borderColor.CGColor) ;
    CGContextSetLineCap(contextRef, kCGLineCapRound);
    CGContextSetFillColorWithColor(contextRef, fillColor.CGColor) ;
    
    CGFloat width = size.width ;
    CGFloat height = size.height ;
    CGContextMoveToPoint(contextRef, width-borderWidth, cornerRadius +borderWidth) ;// 开始坐标右边开始
    CGContextAddArcToPoint(contextRef, width-borderWidth, height-borderWidth, width-cornerRadius-borderWidth, height-borderWidth, cornerRadius) ; // 右下角
    CGContextAddArcToPoint(contextRef, borderWidth, height - borderWidth, borderWidth, height - cornerRadius - borderWidth, cornerRadius); // 左下角
    CGContextAddArcToPoint(contextRef, borderWidth, borderWidth, width - borderWidth, borderWidth, cornerRadius); // 左上角
    CGContextAddArcToPoint(contextRef, width - borderWidth, borderWidth, width - borderWidth, cornerRadius + borderWidth, cornerRadius); // 右上角
    
    CGContextDrawPath(contextRef, kCGPathFillStroke) ;
    UIImage * output = UIGraphicsGetImageFromCurrentImageContext() ;
    UIGraphicsEndImageContext() ;
    
    UIImageView * imageView = [[UIImageView  alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.image = output ;
    [self insertSubview:imageView atIndex:0];
    return imageView ;
}

-(void)ur_addDashBorderWithCorneiRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth fillColor:(UIColor *)fillColor size:(CGSize)size {
    
    CAShapeLayer * shapeLayer = [CAShapeLayer  layer] ;
    CGRect  shapeRect = CGRectMake(0.0f, 0.0f, size.width, size.height) ;
    [shapeLayer  setBounds:shapeRect];
    [shapeLayer  setPosition:CGPointMake(size.width/2, size.height/2)] ;
    [shapeLayer  setFillColor:fillColor.CGColor] ;
    [shapeLayer  setStrokeColor:borderColor.CGColor];
    [shapeLayer  setLineWidth:borderWidth] ;
    [shapeLayer  setLineJoin:kCALineJoinRound] ;
    [shapeLayer  setLineDashPattern:@[@2,@2]];
    
    UIBezierPath * bezierPath = [UIBezierPath  bezierPathWithRoundedRect:shapeRect cornerRadius:cornerRadius] ;
    [shapeLayer  setPath:bezierPath.CGPath] ;
    [self.layer  addSublayer:shapeLayer] ;
}

@end
