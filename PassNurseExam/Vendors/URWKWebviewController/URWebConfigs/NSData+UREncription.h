//
//  NSData+UREncription.h
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/31.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (UREncription)

- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha512;

@end
