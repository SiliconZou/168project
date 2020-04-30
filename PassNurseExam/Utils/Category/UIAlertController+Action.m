//
//  UIAlertController+Action.m
//  HSKBasic
//
//  Created by Best on 2018/10/25.
//  Copyright © 2018 Carl. All rights reserved.
//

#import "UIAlertController+Action.h"
#import <objc/runtime.h>

@interface UIAlertController (Private)

@property (strong,nonatomic) UIWindow *alertWindow;

@end

@implementation UIAlertController (Private)
@dynamic alertWindow;

- (void)setAlertWindow:(UIWindow *)alertWindow {
	objc_setAssociatedObject(self, @selector(alertWindow),alertWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)alertWindow {
	return objc_getAssociatedObject(self, @selector(alertWindow));
}

@end

@implementation UIAlertController (Action)

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	self.alertWindow.hidden = YES;
	self.alertWindow = nil;
}

- (void)show {
	[self show:YES];
}

- (void)show:(BOOL)animated {
	self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.alertWindow.rootViewController = [[UIViewController alloc] init];
	self.alertWindow.windowLevel = UIWindowLevelAlert + 1;
	[self.alertWindow makeKeyAndVisible];
	[self.alertWindow.rootViewController presentViewController:self animated:animated completion:nil];
}

+ (instancetype)alertControllerWithStyle:(UIAlertControllerStyle)style
										 title:(nullable NSString *)title
									   message:(nullable NSString *)message
							 cancelButtonTitle:(nullable NSString *)cancelButtonTitle
							 otherButtonTitles:(nullable NSArray <NSString *>*)otherButtonTitles
									   handler:(nullable void (^)(UIAlertController *alertController, UIAlertAction *action))block {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];

	NSString *cancelTitle = cancelButtonTitle.copy;
	if (!cancelTitle.length && !otherButtonTitles.count) {
		cancelTitle = @"取消";
	}

	__weak typeof(alert) w_alert = alert;
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
		if (block) {
			block(w_alert, action);
		}
	}];
	[alert addAction:cancelAction];

	for (NSString *item in otherButtonTitles) {
		UIAlertAction *action = [UIAlertAction actionWithTitle:item style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
			if (block) {
				block(w_alert, action);
			}
		}];
		[alert addAction:action];
	}

	return alert;
}

+ (instancetype)showAlertControllerWithStyle:(UIAlertControllerStyle)style
											 title:(nullable NSString *)title
										   message:(nullable NSString *)message
								 cancelButtonTitle:(nullable NSString *)cancelButtonTitle
								 otherButtonTitles:(nullable NSArray <NSString *>*)otherButtonTitles
										   handler:(nullable void (^)(UIAlertController *alertController, UIAlertAction *action))block {
	UIAlertController *alert = [UIAlertController alertControllerWithStyle:style title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles handler:block];
	[alert show];
	return alert;
}

+ (instancetype)showAlertControllerWithTitle:(nullable NSString *)title
										   message:(nullable NSString *)message
								 cancelButtonTitle:(nullable NSString *)cancelButtonTitle
								 otherButtonTitles:(nullable NSArray <NSString *>*)otherButtonTitles
										   handler:(nullable void (^)(UIAlertController *alertController, UIAlertAction *action))block {
	return [self showAlertControllerWithStyle:(UIAlertControllerStyleAlert) title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles handler:block];
}

+ (instancetype)showAlertControllerWithMessage:(NSString *)message {
	return [self showAlertControllerWithTitle:nil message:message];
}

+ (instancetype)showAlertControllerWithTitle:(nullable NSString *)title
										   message:(nullable NSString *)message {
	return [self showAlertControllerWithStyle:(UIAlertControllerStyleAlert) title:title message:message cancelButtonTitle:@"确定" otherButtonTitles:nil handler:nil];
}

@end
