//
//  NSData+URBase64.m
//  PassNurseExam
//
//  Created by qc on 2018/9/13.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (URBase64)

+ (NSData *)dataFromBase64String:(NSString *)string;

@end
