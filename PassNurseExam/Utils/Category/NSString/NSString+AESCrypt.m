//
//  NSString+AESCrypt.m
//  PassNurseExam
//
//  Created by qc on 2018/8/14.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "NSString+AESCrypt.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (AESCrypt)

- (NSString*)SHA265:(int)len {
    
    unsigned char hashedChars[len];
    CC_SHA256([self UTF8String],
              (uint32_t)[self lengthOfBytesUsingEncoding:NSASCIIStringEncoding],
              hashedChars);
    NSData *hashedData = [NSData dataWithBytes:hashedChars length:len];
    NSCharacterSet *charsToRemove = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    NSString *resultString = [[[hashedData description] stringByTrimmingCharactersInSet:charsToRemove] stringByReplacingOccurrencesOfString:@" " withString:@""];
    return resultString;
}

- (NSString *)SHA256{
    const char *s = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}



@end
