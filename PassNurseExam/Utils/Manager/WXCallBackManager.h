//
//  WXCallBackManager.h
//  PassNurseExam
//
//  Created by quchao on 2019/10/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXCallBackManager : NSObject

/**
 全局管理对象

 @return 返回初始化的对象
 */
+(WXCallBackManager *)sharedInstance ;

/**
 微信处理返回

 @param url url
 @return 返回
 */
-(BOOL)handleOpenURL:(NSURL *)url;

/**
 微信授权登录
 */
-(void)sendWXAuthReq ;

@end

NS_ASSUME_NONNULL_END
