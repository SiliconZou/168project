//
//  NSString+UR.m
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "NSString+UR.h"

static NSString *const kQuerySeparator  = @"&";
static NSString *const kQueryDivider    = @"=";
static NSString *const kQueryBegin      = @"?";
static NSString *const kFragmentBegin   = @"#";

@implementation NSString (UR)

- (CGSize)ur_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    if (self.length == 0 || font == nil) {
        return CGSizeZero;
    }
    return [self boundingRectWithSize:maxSize
                              options:
            NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName: font} context:nil].size;
}


- (NSString *)ur_formaterName {
    
    return [self ur_formaterLength: 3];
}

- (NSString *)ur_formaterLength:(NSUInteger)length {
    return (self.length > length) ? [NSString stringWithFormat:@"%@...", [self substringToIndex:length]] : self;
}

- (NSString *)ur_limitLength:(int)length {
    if (self.length > length) {
        // Emoji占2个字符，如果是超出了半个Emoji，用 length 位置来截取会出现Emoji截为2半
        // 超出最大长度的那个字符序列(Emoji算一个字符序列)的range
        NSRange range = [self rangeOfComposedCharacterSequenceAtIndex: length];
        return [self substringToIndex:range.location];
    }
    return self;
}

- (NSDictionary *)ur_urlQueryParse {
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    NSArray *array = [self componentsSeparatedByString:@"&"];
    for (NSString *tmp in array) {
        NSArray<NSString *> *arr = [tmp componentsSeparatedByString:@"="];
        if (arr.count == 2) {
            data[arr[0]] = arr[1];
        }
    }
    return data;
}

- (NSDictionary*)ur_URLQueryDictionary{
    NSMutableDictionary *mute = @{}.mutableCopy;
    for (NSString *query in [self componentsSeparatedByString:kQuerySeparator]) {
        NSArray *components = [query componentsSeparatedByString:kQueryDivider];
        if (components.count == 0) {
            continue;
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        NSString *key = [components[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        id value = nil;
        if (components.count == 1) {
            // key with no value
            value = [NSNull null];
        }
        if (components.count == 2) {
            value = [components[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            // cover case where there is a separator, but no actual value
            value = [value length] ? value : [NSNull null];
        }
        if (components.count > 2) {
            NSString *prefixStr = [NSString stringWithFormat:@"%@=",components[0]];
            value = [[query substringFromIndex:prefixStr.length] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
#pragma clang diagnostic pop
        if (value == nil || value == [NSNull null]) {
            continue;
        } else {
            mute[key] = value;
        }
    }
    return mute.count ? mute.copy : nil;
}



+(NSMutableAttributedString *)numremobertion:(NSString *)str number:(NSInteger)num{
    //让label后面几位变成不一样的字体
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:str];
    for (int i = 0; i < str.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        // NSString *a = [str substringWithRange:NSMakeRange(i, 1)];
        
        if (str.length-i<=num) {
            
            [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1.00f green:0.82f blue:0.06f alpha:1.00f],NSFontAttributeName:[UIFont systemFontOfSize:14],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(i, 1)];
        }
    }
    
    return attributeString;
}


- (NSString *)ur_urlEncode {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
#pragma clang diagnostic pop
}

// 银行卡号前9位
- (NSString *)ur_bankcardHeadNine {
    return self.length > 9 ? [NSString stringWithFormat:@"%@...", [self substringToIndex:9] ] : self;
}

// 银行卡号后4位
- (NSString *)ur_bankcardTail {
    return self.length >= 4 ? [self substringFromIndex: self.length - 4] : self;
}


@end
