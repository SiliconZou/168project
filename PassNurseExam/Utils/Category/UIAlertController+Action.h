//
//  UIAlertController+Action.h
//  HSKBasic
//
//  Created by Best on 2018/10/25.
//  Copyright © 2018 Carl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Action)

///显示在一个更高层级的新建UIWindow上面
- (void)show;

/**
 构造器，不自动弹出，需调用showg方法
 */
+ (instancetype)alertControllerWithStyle:(UIAlertControllerStyle)style
										 title:(nullable NSString *)title
									   message:(nullable NSString *)message
							 cancelButtonTitle:(nullable NSString *)cancelButtonTitle
							 otherButtonTitles:(nullable NSArray <NSString *>*)otherButtonTitles
									   handler:(nullable void (^)(UIAlertController *alertController, UIAlertAction *action))block;


/**
 自动弹出视图
 */
+ (instancetype)showAlertControllerWithStyle:(UIAlertControllerStyle)style
											 title:(nullable NSString *)title
										   message:(nullable NSString *)message
								 cancelButtonTitle:(nullable NSString *)cancelButtonTitle
								 otherButtonTitles:(nullable NSArray <NSString *>*)otherButtonTitles
										   handler:(nullable void (^)(UIAlertController *alertController, UIAlertAction *action))block;

+ (instancetype)showAlertControllerWithTitle:(nullable NSString *)title
										   message:(nullable NSString *)message
								 cancelButtonTitle:(nullable NSString *)cancelButtonTitle
								 otherButtonTitles:(nullable NSArray <NSString *>*)otherButtonTitles
										   handler:(nullable void (^)(UIAlertController *alertController, UIAlertAction *action))block;

+ (instancetype)showAlertControllerWithMessage:(NSString *)message;
+ (instancetype)showAlertControllerWithTitle:(nullable NSString *)title
									 message:(nullable NSString *)message;

@end

NS_ASSUME_NONNULL_END
