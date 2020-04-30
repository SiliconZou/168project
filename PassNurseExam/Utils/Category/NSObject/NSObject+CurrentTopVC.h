//
//  NSObject+CurrentTopVC.h
//  TianYiMerchant
//
//  Created by qc on 2018/9/25.
//  Copyright © 2018年 HLM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CurrentTopVC)

- (UIViewController *)getCurrentVC;

+ (UIViewController *)getCurrentVC;

@end
