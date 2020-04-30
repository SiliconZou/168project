//
//  UIView+Line.h
//  PassNurseExam
//
//  Created by qc on 2018/9/17.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Line)


- (void )addLineWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endpoint lineColor:(UIColor *)color lineWidth:(CGFloat)lineWidth;

/**
 顶部线

 @param color 颜色
 @return UIView对象
 */
+(UIView *)ur_topLineWithColor:(UIColor *)color ;

/**
 底部线

 @param color 颜色
 @return UIView对象
 */
+(UIView *)ur_bottomLineWithColor:(UIColor *)color ;

/**
 左侧线

 @param color 颜色
 @return UIView对象
 */
+(UIView *)ur_leftLineWithColor:(UIColor *)color ;

/**
 右侧线

 @param color 颜色
 @return UIView对象
 */
+(UIView *)ur_rightLineWithColor:(UIColor *)color ;

/**
 添加边框

 @param cornerRadius 边框圆角
 @param borderColor  边框颜色
 @param borderWidth 边框宽度
 @return  UIImageView对象
 */
-(UIView *)ur_addAllCornerRadius:(CGFloat)cornerRadius
                     borderColor:(UIColor *)borderColor
                     borderWidth:(CGFloat)borderWidth ;

/**
 添加边框

 @param cornerRadius 边框角度
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @param fillColor  填充颜色
 @return UIImageView对象
 */
-(UIView *)ur_addAllCornerRadius:(CGFloat)cornerRadius
                     borderColor:(UIColor *)borderColor
                     borderWidth:(CGFloat)borderWidth
                       fillColor:(UIColor *)fillColor;

/**
 添加边框

 @param cornerRadius 边框角度
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @param fillColor 填充颜色
 @param size 边框尺寸
 @return UIImageView对象
 */
-(UIView *)ur_addAllCornerRadius:(CGFloat)cornerRadius
                     borderColor:(UIColor *)borderColor
                     borderWidth:(CGFloat)borderWidth
                       fillColor:(UIColor *)fillColor
                            size:(CGSize)size;

/**
 添加虚线边框

 @param cornerRadius 边框圆角
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @param fillColor 填充颜色
 @param size 边框尺寸
 */
-(void)ur_addDashBorderWithCorneiRadius:(CGFloat)cornerRadius
                                borderColor:(UIColor *)borderColor
                                borderWidth:(CGFloat)borderWidth
                                  fillColor:(UIColor *)fillColor
                                       size:(CGSize)size ;

@end
