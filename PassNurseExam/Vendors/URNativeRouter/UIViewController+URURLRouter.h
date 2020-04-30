//
//  UIViewController+URURLRouter.h
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (URURLRouter)


/** 跳转后控制器能拿到的url */
@property(nonatomic, strong) NSURL *originUrl;

/** url路径 */
@property(nonatomic,copy) NSString *path;

/** 跳转后控制器能拿到的参数 */
@property(nonatomic,strong) NSDictionary *params;

/** 回调block */
@property (nonatomic, strong) void(^valueBlock)(id value);

// 根据参数创建控制器
+ (UIViewController *)initFromString:(NSString *)urlString fromConfig:(NSDictionary *)configDict;
// 根据参数创建控制器
+ (UIViewController *)initFromString:(NSString *)urlString withQuery:(NSDictionary *)query fromConfig:(NSDictionary *)configDict;


NS_ASSUME_NONNULL_END

@end
