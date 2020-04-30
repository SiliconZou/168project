//
//  UILabel+Extension.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)


+ (UILabel *)normalLabelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines{
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = titleColor;
    label.font = font;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberLines < 0 ? 0 : numberLines;
    if (label.numberOfLines > 0) {
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    else {
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.preferredMaxLayoutWidth = URScreenWidth();
    }
    return label;
}

+ (UILabel *)cornerLabelWithRadius:(CGFloat)cornerRadius backColor:(UIColor *)backColor title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines{
    UILabel *label = [UILabel normalLabelWithTitle:title titleColor:titleColor font:font textAlignment:textAlignment numberLines:numberLines];
    label.backgroundColor = backColor;
    label.layer.cornerRadius = cornerRadius;
    label.clipsToBounds = YES;
    return label;
}


//圆角边框按钮
+ (UILabel *)borderLabelWithRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines{
    UILabel *label = [UILabel normalLabelWithTitle:title titleColor:titleColor font:font textAlignment:textAlignment numberLines:numberLines];
    label.layer.borderColor = borderColor.CGColor;
    label.layer.borderWidth = borderWidth;
    label.layer.cornerRadius = cornerRadius;
    label.clipsToBounds = YES;
    return label;
}

@end
 
