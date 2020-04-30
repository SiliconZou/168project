//
//  URLoadingIndicator.h
//  Rubik-X-Popular-UI2.0
//
//  Created by qc on 16/3/11.
//  Copyright © 2016年 ucmed —— Rubik-X. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, URLoadingIndicatorStyle) {
    URLoadingIndicatorStyleNone,
    URLoadingIndicatorStyleRocket,
};

typedef void(^URReturnValue)(id returnValue);

@interface URLoadingIndicator : UIView

- (void)startLoading;

- (void)startLoadingWithCancel:(URReturnValue)returnValue;

- (void)stopLoading;

- (void)stopAllLoading;

@end
