//
//  URToastHelper.h
//  BeiJingHospital
//
//  Created by qc on 2019/4/30.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

enum {
    URToastMaskTypeNone = 1, // allow user interactions while HUD is displayed
    URToastMaskTypeClear, // don't allow
    URToastMaskTypeBlack, // don't allow and dim the UI in the back of the HUD
    URToastMaskTypeGradient // don't allow and dim the UI with a a-la-alert-view bg gradient
};

typedef NSUInteger URToastMaskType;

@interface URToastHelper : UIView

+ (void)show;
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(URToastMaskType)maskType;
+ (void)showWithMaskType:(URToastMaskType)maskType;
+ (void)showErrorWithStatus:(NSString *)string;
+ (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing

+ (void)dismiss; // simply dismiss the HUD with a fade+scale out animation
+ (void)dismissWithSuccess:(NSString*)successString; // also displays the success icon image
+ (void)dismissWithSuccess:(NSString*)successString afterDelay:(NSTimeInterval)seconds;
+ (void)dismissWithError:(NSString*)errorString; // also displays the error icon image
+ (void)dismissWithError:(NSString*)errorString afterDelay:(NSTimeInterval)seconds;
+ (void)dismissWithError:(NSString *)successString title:(NSString *)titleString andImage:(UIImage *)image afterDelay:(NSTimeInterval)duration;

+ (BOOL)isVisible;

@end

NS_ASSUME_NONNULL_END
