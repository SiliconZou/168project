//
//  URURLNavigation.h
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "URSingleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface URURLNavigation : NSObject

URSingletonH(URURLNavigation)

/**
 获取当前的控制器

 @return 返回当前的控制器
 */
-(UIViewController *)currentViewController ;

/**
 获取当前的控制器

 @return 返回当前的控制器
 */
-(UINavigationController *)currentNavigationViewController ;

/**
 跳转到指定的ViewController

 @param viewController viewController
 @param animated 是否需要动画
 @param replace 是否可以重复
 */
+(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated replace:(BOOL)replace ;

/**
 模态跳转到指定的ViewController

 @param viewController viewController
 @param animated 是否需要动画
 @param completion 完成返回的Block
 */
+(void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^__nullable)(void))completion ;

/**
 返回上两层试图控制器

 @param animated 是否需要动画
 */
+(void)popTwiceViewControllerAnimated:(BOOL)animated ;

/**
 返回指定的试图控制器

 @param times 要返回的层数
 @param animated 是否需要动画
 */
+(void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated ;

/**
 返回根试图控制器

 @param animated 是否需要动画
 */
+(void)popToRootViewControllerAnimated:(BOOL)animated ;

/**
 返回到指定的试图控制器

 @param viewController 试图控制器
 @param animated 是否需要动画
 */
+(void)popToAppointViewController:(UIViewController *)viewController animated:(BOOL)animated ;


/**
 返回上两层试图控制器
 
 @param animated 是否需要动画
 */
+(void)dismissTwiceViewControllerAnimated:(BOOL)animated completion:(void (^__nullable)(void))completion ;

/**
 返回指定的试图控制器
 
 @param times 要返回的层数
 @param animated 是否需要动画
 */
+(void)dismissViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated completion:(void(^__nullable)(void))completion ;

/**
 返回根试图控制器
 
 @param animated 是否需要动画
 */
+(void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void(^__nullable)(void))completion ;


NS_ASSUME_NONNULL_END

@end
