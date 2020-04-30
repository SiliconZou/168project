//
//  UIButton+Extension.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extension)


//无背景色的普通按钮
+ (UIButton *)normalBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font;

//只有图片，没有文字的按钮
+ (UIButton *)ImgBtnWithImageName:(NSString *)imgName;

//有背景色的按钮
+ (UIButton *)backcolorBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font backColor:(UIColor *)backColor;

//圆角按钮
+ (UIButton *)cornerBtnWithRadius:(CGFloat)cornerRadius title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font backColor:(UIColor * _Nullable)backColor;

//圆角个数可变按钮
- (void)variableCorners:(UIRectCorner)corners radius:(CGFloat)cornerRadius bounds:(CGRect)bounds;


//有边框的按钮
+ (UIButton *)borderBtnWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font;


@end

NS_ASSUME_NONNULL_END
