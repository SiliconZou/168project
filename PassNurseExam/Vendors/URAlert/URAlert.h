//
//  URAlert.h
//  Test
//
//  Created by qc on 16/1/29.
//  Copyright © 2016年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^buttonIndexBlock)(NSInteger buttonIndex);

typedef NS_ENUM(NSInteger, URAlertStyle) {
    URAlertStyleNone,
    URAlertStyleAlert,
    URAlertStyleCustom,
    URAlertStyleHUB,
};

typedef NS_ENUM(NSInteger, URAlertType) {
    URAlertTypeInfo,
    URAlertTypeSuccess,
    URAlertTypeFailure
};

@interface URAlert : NSObject

+ (void)setThemeColor:(nullable UIColor *)color;

+ (void)alertWithStyle:(URAlertStyle)style
               message:(nullable NSString *)message;

+ (void)alertWithStyle:(URAlertStyle)style
                  type:(URAlertType)type
                 title:(nullable NSString *)title
               message:(nullable NSString *)message;

+ (void)alertWithStyle:(URAlertStyle)style
                  type:(URAlertType)type
                 title:(nullable NSString *)title
               message:(nullable NSString *)message
        viewController:(nullable UIViewController *)viewController;

+ (void)alertViewWithStyle:(URAlertStyle)style
                     title:(nullable NSString *)title
                   message:(nullable NSString *)message
         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
          sureButtonTitles:(nullable NSString *)sureButtonTitles
            viewController:(nonnull UIViewController *)viewController
                   handler:(_Nonnull buttonIndexBlock)buttonIndex;



@end
