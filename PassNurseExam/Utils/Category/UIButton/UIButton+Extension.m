//
//  UIButton+Extension.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font imageName:(NSString * _Nullable)imageName
{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    return btn;
}

//无背景色的普通按钮
+ (UIButton *)normalBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font{
    return [self buttonWithTitle:title titleColor:titleColor titleFont:font imageName:nil];
}

//只有图片，没有文字的按钮
+ (UIButton *)ImgBtnWithImageName:(NSString *)imgName{
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    return btn;
}

//有背景色的按钮
+ (UIButton *)backcolorBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font backColor:(UIColor *)backColor{
    
    UIButton *btn = [UIButton normalBtnWithTitle:title titleColor:titleColor titleFont:font];
    btn.backgroundColor = backColor;
    return btn;
}

//圆角按钮
+ (UIButton *)cornerBtnWithRadius:(CGFloat)cornerRadius title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font backColor:(UIColor * _Nullable)backColor{
    
    UIButton *btn = [UIButton normalBtnWithTitle:title titleColor:titleColor titleFont:font];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = cornerRadius;

    if (backColor) {
        btn.backgroundColor = backColor;
    }
    return btn;
}

//圆角个数可变按钮
- (void)variableCorners:(UIRectCorner)corners radius:(CGFloat)cornerRadius bounds:(CGRect)bounds{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

//有边框的按钮
+ (UIButton *)borderBtnWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font{
    
    UIButton *btn = [UIButton normalBtnWithTitle:title titleColor:titleColor titleFont:font];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = cornerRadius;
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = borderWidth;
    return btn;
}

 

@end
