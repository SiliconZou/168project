//
//  UILabel+Extension.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)

//无底色的正常按钮
+ (UILabel *)normalLabelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines;

//有底色+圆角
+ (UILabel *)cornerLabelWithRadius:(CGFloat)cornerRadius backColor:(UIColor *)backColor title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines;

//圆角边框按钮
+ (UILabel *)borderLabelWithRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines;


@end

NS_ASSUME_NONNULL_END
