//
//  UIView+CornerRadius.h
//  PassNurseExam
//
//  Created by qc on 2018/9/3.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)


/**
 设置圆角并设置边框

 @param cornerRadius 设置圆角的大小
 @param borderWidth 边框的宽度
 @param borderColor 边框的颜色
 @param cornerType 圆角的位置
 */
-(void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                     borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor
                            type:(UIRectCorner)cornerType ;

/**
 切圆角
 
 @param corners 圆角
 @param cornerRadius 圆角度数
 @param bounds bounds
 */
- (void)addCorners:(UIRectCorner)corners radius:(CGFloat)cornerRadius bounds:(CGRect)bounds;

@end
