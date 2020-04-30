//
//  AlipayManager.m
//  TianYiBuy
//
//  Created by apple on 2018/3/12.
//  Copyright © 2018年 kajibu. All rights reserved.
//

#import "AlipayManager.h"

@implementation AlipayManager


+ (void)openURL:(NSURL *)url
{
    // 支付跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        if([resultDic[@"resultStatus"] isEqualToString:@"9000"])//支付成功
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccessNoti" object:nil];
        }else
        {
            [URToastHelper showErrorWithStatus:(resultDic[@"memo"])];
        }
    }];
}


@end
