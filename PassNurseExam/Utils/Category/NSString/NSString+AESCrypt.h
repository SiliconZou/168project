//
//  NSString+AESCrypt.h
//  PassNurseExam
//
//  Created by qc on 2018/8/14.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AESCrypt)

- (NSString *)SHA265:(int)len;

- (NSString *)SHA256 ;



@end
