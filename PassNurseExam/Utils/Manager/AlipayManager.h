//
//  AlipayManager.h
//  TianYiBuy
//
//  Created by apple on 2018/3/12.
//  Copyright © 2018年 kajibu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlipayManager : NSObject
/**
 9.0之后的回调

 @param url url
 */
+ (void)openURL:(NSURL *)url;



@end
