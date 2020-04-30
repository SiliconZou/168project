//
//  URCoreMetrics.h
//  MSSpeed
//
//  Created by qc on 2017/11/28.
//  Copyright © 2017年 qc. All rights reserved.
//

/**
 *  设备尺寸
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#if defined __cplusplus
extern "C"{
#endif
    
    /**
     屏幕的bounds

     @return 屏幕的bounds
     */
    CGRect URScreenBounds(void) ;
    
    /**
     屏幕高度

     @return 屏幕高度
     */
    CGFloat URScreenHeight(void) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
    
    /**
     屏幕宽度

     @return 屏幕宽度
     */
    CGFloat  URScreenWidth(void) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
    
    /**
     屏幕内容尺寸

     @return 屏幕内容尺寸
     */
    CGRect  URContentFrame(void);
    
    /**
     屏幕内容高度

     @return 屏幕内容高度
     */
    CGFloat  URContentHeight(void);
    
    /**
     屏幕内容宽度

     @return 屏幕内容宽度
     */
    CGFloat  URContentWidth (void) ;
    
    /**
     导航栏高度

     @return 导航栏高度
     */
    CGFloat  URNavigationBarHeight(void) ;
    
    /**
     TabBar高度

     @return TabBar高度
     */
    CGFloat  URTabBarHeight (void) ;
    
    /**
     状态栏高度

     @return 状态栏高度
     */
    CGFloat  URStatusBarHeight (void) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
    
    /**
     屏幕缩放比例

     @return 屏幕缩放比例
     */
    CGFloat URScreenScale (void) ;
    
    /**
     根据分辨率返回缩放比例，基于320px
     */
    CGFloat URAdaptiveCofficient (void) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
    
    /**
     根据缩放比，计算出适配所需要的高度宽度

     @param wh 输入长度
     @return 计算后的长度
     */
    CGFloat URAdJustedWidthHeight(CGFloat wh) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
    
    /**
     默认字符串-10.00%宽度

     @param font 字体
     @return 字符串宽度
     */
    CGFloat URDefaultValueWidth (UIFont * font) ;
    
    
    /**
     导航安全区域高度
     */
    CGFloat URSafeAreaNavHeight (void) ;
    
    CGFloat URSafeAreaStateHeight (void) ;
    
    CGFloat URSafeAreaTabBarHeight (void) ;
    
    CGFloat URSafeAreaTabBarIncreaseHeight (void) ;
    
    
#if defined __cplusplus
};
#endif
