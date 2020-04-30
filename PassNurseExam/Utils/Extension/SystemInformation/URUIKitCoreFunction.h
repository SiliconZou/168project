//
//  URUIKitCoreFunction.h
//  MSSpeed
//
//  Created by qc on 2017/11/28.
//  Copyright © 2017年 qc. All rights reserved.
//

/**
 * 获取应用的信息
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    /**
     获取包的唯一标识符

     @return bundle信息
     */
    NSString * URBundleIdentifier (void) ;
    
    /**
     应用名称

     @return 应用显示的名称
     */
    NSString * URAppDisplayName (void) ;
    
    /**
     获取版本表示，一般格式为3.3.1

     @return 版本号
     */
    NSString * URAppVersion (void) ;
    
    
    /**
     获取当前应用版本号码

     @return 返回获取到的值
     */
    NSString * URAppCurVersionNum (void) ;
    
#ifdef __cplusplus
}
#endif

