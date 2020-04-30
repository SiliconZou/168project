//
//  NSMutableAttributedString+Extension.m
//  PassNurseExam
//
//  Created by qc on 2018/9/13.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"
#import <CoreText/CoreText.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0

@implementation NSMutableAttributedString (Extension)

#pragma mark - Font

-(void)ur_setFont:(UIFont*)font{
    [self ur_setFontName:font.fontName size:font.pointSize];
}

-(void)ur_setFont:(UIFont*)font range:(NSRange)range{
    [self ur_setFontName:font.fontName size:font.pointSize range:range];
}

-(void)ur_setFontName:(NSString*)fontName size:(CGFloat)size{
    [self ur_setFontName:fontName size:size range:NSMakeRange(0,[self length])];
}

-(void)ur_setFontName:(NSString*)fontName size:(CGFloat)size range:(NSRange)range{
    [self removeAttribute:NSFontAttributeName range:range];
    [self addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontName size:size] range:range];
}

#pragma mark - Color

-(void)ur_setTextColor:(UIColor*)color{
    [self ur_setTextColor:color range:NSMakeRange(0,[self length])];
}

-(void)ur_setTextColor:(UIColor*)color range:(NSRange)range{
    [self removeAttribute:NSForegroundColorAttributeName range:range];
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)ur_setTextStrikethroughStyle:(NSUnderlineStyle)style{
    [self ur_setTextStrikethroughStyle:style range:NSMakeRange(0, self.length)];
}

- (void)ur_setTextStrikethroughStyle:(NSUnderlineStyle)style range:(NSRange)range{
    [self removeAttribute:NSStrikethroughStyleAttributeName range:range];
    [self addAttribute:NSStrikethroughStyleAttributeName value:@(style) range:range];
}

- (void)ur_setTextUnderLineStyle:(NSUnderlineStyle)style{
    [self ur_setTextUnderLineStyle:style range:NSMakeRange(0, self.length)];
}

- (void)ur_setTextUnderLineStyle:(NSUnderlineStyle)style range:(NSRange)range{
    [self removeAttribute:NSUnderlineStyleAttributeName range:range];
    [self addAttribute:NSUnderlineStyleAttributeName value:@(style) range:range];
}

- (void)ur_modifyParagraphStylesWithBlock:(void (^)(NSMutableParagraphStyle *paragraphStyle))block{
    [self ur_modifyParagraphStylesInRange:NSMakeRange(0, self.length) withBlock:block];
}

- (void)ur_modifyParagraphStylesInRange:(NSRange)range withBlock:(void (^)(NSMutableParagraphStyle *))block{
    NSParameterAssert(block != nil);
    
    NSRangePointer rangePtr = &range;
    NSUInteger loc = range.location;
    [self beginEditing];
    while (NSLocationInRange(loc, range)){
        NSParagraphStyle *paraStyle = [self attribute:NSParagraphStyleAttributeName
                                              atIndex:loc
                                longestEffectiveRange:rangePtr
                                              inRange:range];
        if (!paraStyle){
            paraStyle = [NSParagraphStyle defaultParagraphStyle];
        }
        NSMutableParagraphStyle *mutableParaStyle = [paraStyle mutableCopy];
        block(mutableParaStyle);
        [self ur_setParagraphStyle:mutableParaStyle range:*rangePtr];
        
        loc = NSMaxRange(*rangePtr);
    }
    [self endEditing];
}

- (void)ur_setParagraphStyle:(NSParagraphStyle *)paragraphStyle{
    [self ur_setParagraphStyle:paragraphStyle range:NSMakeRange(0, self.length)];
}

- (void)ur_setParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range{
    [self removeAttribute:NSParagraphStyleAttributeName range:range];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

+(NSAttributedString*)getAttributedString:(NSString *)string withLineSpace:(CGFloat)lineSpace{
    NSMutableParagraphStyle*paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing= lineSpace;
    NSDictionary*attriDict =@{NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString*attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:attriDict];
    
    return attributedString;
}



@end
#endif
