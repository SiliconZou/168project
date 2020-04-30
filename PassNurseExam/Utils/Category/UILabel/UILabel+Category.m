//
//  UILabel+Category.m
//  上海长征医院
//
//  Created by ucmed on 17/5/2.
//  Copyright © 2017年 卓健科技. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)
+ (void)ur_changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)ur_changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)ur_changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

-(void)ur_autoResetHeightByWidth:(CGFloat)width text:(NSString *)text {
    
    self.numberOfLines = 0 ;
    self.lineBreakMode = NSLineBreakByCharWrapping ;
    CGSize  size = [self  calculateLabelSizeWithTitle:text font:self.font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    size.height +=3 ;
    CGRect  frame = self.frame ;
    frame.size.height = size.height ;
    self.frame = frame ;
}

-(void)ur_autoResetHeightByWidth:(CGFloat)width text:(NSString *)text oneLineHeight:(CGFloat)height {
    
    self.numberOfLines = 0 ;
    self.lineBreakMode = NSLineBreakByCharWrapping ;
    CGSize  size = [self  calculateLabelSizeWithTitle:text font:self.font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping] ;
    CGRect   frame = self.frame ;
    frame.size.height = size.height * height / self.font.lineHeight ;
    self.frame = frame ;
}

-(void)ur_autoResetHeightByWidth:(CGFloat)width text:(NSString *)text miniHeight:(CGFloat)miniHeight {
    
    self.numberOfLines = 0 ;
    self.lineBreakMode = NSLineBreakByCharWrapping ;
    CGSize  size = [self  calculateLabelSizeWithTitle:text font:self.font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping] ;
    size.height +=3 ;
    if (size.height <miniHeight +3) {
        size.height = miniHeight ;
    }
    
    CGRect  frame = self.frame ;
    frame.size.height = size.height ;
    self.frame = frame ;
}

-(CGFloat)ur_calculHeightByWidth:(CGFloat)width tetx:(NSString *)text {
    self.numberOfLines = 0 ;
    self.lineBreakMode = NSLineBreakByCharWrapping ;
    CGSize  size = [self  calculateLabelSizeWithTitle:text font:self.font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping] ;
    return size.height ;
}

-(void)ur_autoResetWidth {
    self.lineBreakMode = NSLineBreakByCharWrapping ;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGSize  size = [self   calculateLabelSizeWithTitle:self.text font:self.font constrainedToSize:CGSizeMake(screenWidth, self.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping] ;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, self.frame.size.height) ;
}

- (CGSize)calculateLabelSizeWithTitle:(NSString *)title font:(UIFont *)font{
    if (title.length == 0) {
        return CGSizeZero;
    }
    NSDictionary * attrDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize size = [title sizeWithAttributes:attrDic]; //sizeWithAttributes is the default suggested replace method for selector(sizeWithFont:)
    return size;
}

- (CGSize)calculateLabelSizeWithTitle:(NSString *)title font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode{
    if (title.length == 0) {
        return CGSizeZero;
    }
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = lineBreakMode;
    
    CGRect frame = [title boundingRectWithSize:size
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{
                                                 NSFontAttributeName:font,
                                                 NSParagraphStyleAttributeName:paragraph
                                                 }
                                       context:nil];
    return frame.size;
}
@end
