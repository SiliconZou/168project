//
//  NSAttributedString+Extension.m
//  PassNurseExam
//
//  Created by qc on 2018/9/13.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "NSAttributedString+Extension.h"
#import <CoreText/CoreText.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0

@implementation NSAttributedString (Extension)

+ (instancetype)ur_attributedStringWithString:(NSString*)string{
    if (string){
        return [[self alloc] initWithString:string];
    }else{
        return nil;
    }
}

+ (instancetype)ur_attributedStringWithAttributedString:(NSAttributedString*)attrStr{
    if (attrStr){
        return [[self alloc] initWithAttributedString:attrStr];
    }else{
        return nil;
    }
}

- (instancetype)ur_initWithString:(NSString *)str{
    str = str ? str : @"";
    return [self initWithString:str];
}

- (instancetype)ur_initWithString:(NSString *)str attributes:(NSDictionary<NSString *, id> *)attrs{
    str = str ? str : @"";
    return [self initWithString:str attributes:attrs];
}

- (CGSize)ur_sizeConstrainedToSize:(CGSize)maxSize{
    return [self ur_sizeConstrainedToSize:maxSize fitRange:NULL];
}

- (CGSize)ur_sizeConstrainedToSize:(CGSize)maxSize fitRange:(NSRange*)fitRange{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self);
    CGSize sz = CGSizeMake(0.f, 0.f);
    if (framesetter){
        CFRange fitCFRange = CFRangeMake(0,0);
        sz = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0,0),NULL,maxSize,&fitCFRange);
        sz = CGSizeMake( floor(sz.width+1) , floor(sz.height+1) ); // take 1pt of margin for security
        CFRelease(framesetter);
        
        if (fitRange){
            *fitRange = NSMakeRange((NSUInteger)fitCFRange.location, (NSUInteger)fitCFRange.length);
        }
    }
    return sz;
}


@end

#endif
