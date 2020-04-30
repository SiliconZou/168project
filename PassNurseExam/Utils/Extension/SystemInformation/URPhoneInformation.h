//
//  URPhoneInformation.h
//  PassNurseExam
//
//  Created by qc on 2018/8/29.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    /**
     当前iOS版本号
     
     @return 当前iOS版本号
     */
    float UROSVersion (void) ;
    
    /**
     获取当前设备型号
     
     @return 返回获取到的设备型号
     */
    NSString * URGetCurrentIphoneType (void) ;
    
    /**
     获取手机序列号
     
     @return 手机序列号
     */
    NSString * URGetPhoneSerialNO (void) ;
    
    /**
     获取手机用户自定义的名称
     
     @return 返回获取到的数据
     */
    NSString * URGetUserName (void) ;
    
    /**
     获取手机设备名称
     
     @return 返回获取到的数据
     */
    NSString * URGetDeviceName (void) ;
    
    /**
     获取手机系统版本
     
     @return 返回获取到的数据
     */
    NSString * URGetPhoneVersion (void) ;
    
    /**
     手机型号
     
     @return 返回获取到的数据
     */
    NSString * URGetPhoneModel (void) ;
    
    /**
     判断是否是iPhone X
     
     @return 返回结果
     */
    BOOL  iPhoneX (void) ;
    
    /**
     地方型号  （国际化区域名称）
     
     @return 返回获取到的数据
     */
    NSString * URLocalPhoneModel (void) ;
    
    /**
     当前是否是竖屏
     
     @return 当前是否是竖屏
     */
    BOOL  URIsPortrait (void) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
    
    /**
     当前是否是横屏
     
     @return 当前是否是横屏
     */
    BOOL URIsLandscape (void)  NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
    
    /**
     获取设备IP
     
     @return 返回获取的设备IP
     */
    NSString * URGetIpAddress (void) ;
    
    
    /**
     当前手机连接的WIFI名称(SSID)
     */
    NSString * URGetWifiName(void) ;
    
    /**
     *  是否是iPad用户界面显示
     *
     *  @return 是否是iPad用户界面显示
     */
    BOOL URIsPadUserInterface(void);
    
    
    /**
     *  是否是iPad设备
     *
     *  @return 是否是iPad设备
     */
    BOOL URIsPadDevice(void);
    
    /**
     *  是否是iPhone设备
     *
     *  @return 是否是iPhone设备
     */
    BOOL URIsPhone(void);
    
    
    /**
     *  是否是retina屏
     *
     *  @return 是否是retina屏
     */
    BOOL URIsRetina(void);
    
    
    /**
     *  是否是iPhone5
     *
     *  @return 是否是iPhone5
     */
    BOOL URIsIphone5(void);
    
    
    /**
     *  是否是iPhone6
     *
     *  @return 是否是iPhone6
     */
    BOOL URIsIphone6(void);
    
    
    /**
     *  是否是iPhone6P
     *
     *  @return 是否是iPhone6P
     */
    BOOL URIsIphone6P(void);
    
    
    /**
     *  是否是iPhone5及以上设备
     *
     *  @return 是否是iphone5及以上设备
     */
    BOOL URIsIphone5Above(void);
    
    /**
     获取缓存大小

     @return 获取缓存大小
     */
    float URGetCachSize(void) ;
    
    /**
     *  是否支持打电话
     *
     *  @return 是否支持打电话
     */
    BOOL URIsPhoneCallSupported(void) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
    
    
    /**
     *  拨号
     *
     *  @param phoneNumber 电话号码
     *
     *  @return 是否成功
     */
    BOOL URMakePhoneCall(NSString *phoneNumber) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
    
#ifdef __cplusplus
}
#endif

