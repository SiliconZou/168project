//
//  URPhoneInformation.m
//  PassNurseExam
//
//  Created by qc on 2018/8/29.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "URPhoneInformation.h"
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/mount.h>
#import <sys/sysctl.h>// get Mac
#include <net/if.h>
#include <net/if_dl.h>
#import "URCoreMetrics.h"


float UROSVersion (void){
    return [UIDevice  currentDevice].systemVersion.floatValue ;
}

NSString * URGetCurrentIphoneType (){
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString  isEqualToString:@"iPhone8,4"]) {
        return @"iPhone SE";
    }
    if ([deviceString  isEqualToString:@"iPhone9,1"]) {
        return @"iPhone 7";
    }
    if ([deviceString  isEqualToString:@"iPhone9,2"]) {
        return @"iPhone 7 Plus";
    }
    
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    
    
    //iPod
    
    if ([deviceString isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]||[deviceString isEqualToString:@"iPad4,5"]||[deviceString isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]||[deviceString isEqualToString:@"iPad4,8"]||[deviceString isEqualToString:@"iPad4,9"])  return @"iPad mini 3";
    
    return deviceString;
}


NSString * URGetUserName (){
    return [[UIDevice currentDevice] name];
}

NSString * URGetDeviceName (){
    
    return [[UIDevice   currentDevice]systemName];
}

NSString * URGetPhoneVersion (){
    
    return [[UIDevice  currentDevice] systemVersion];
    
}

NSString * URGetPhoneModel (){
    
    return [[UIDevice   currentDevice] model];
}

NSString * URLocalPhoneModel (){
    
    return [[UIDevice   currentDevice] localizedModel];
}

//BOOL  iPhoneX () {
//    
////    if (UIScreen.mainScreen.bounds.size.width == 375.f && UIScreen.mainScreen.bounds.size.height == 812.f) {
////        return YES ;
////    } else {
////        return NO ;
////    }
//    
//    BOOL iPhoneXSeries = NO;
//    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
//        return iPhoneXSeries;
//    }
//    
//    if (@available(iOS 11.0, *)) {
//        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
//        if (mainWindow.safeAreaInsets.bottom > 0.0) {
//            iPhoneXSeries = YES;
//        }
//    }
//    
//    return iPhoneXSeries;
//}

BOOL  URIsPortrait (){
    return UIInterfaceOrientationIsPortrait([UIApplication  sharedApplication].statusBarOrientation) ;
}

BOOL URIsLandscape () {
    return !URIsPortrait() ;
}

NSString * URGetIpAddress (){
    //#import <ifaddrs.h> #import <arpa/inet.h> 需要导入
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0){
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL){
            if(temp_addr->ifa_addr->sa_family == AF_INET){
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]){
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    return address ;
}

/**
 当前手机连接的WIFI名称(SSID)
 */
NSString * URGetWifiName() {
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

BOOL URIsPadUserInterface(void){
    static NSInteger isPad = -1;
    if (isPad < 0) {
        isPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 1 : 0;
    }
    return isPad > 0;
}

BOOL URIsPadDevice(void){
    return [[UIDevice currentDevice].model rangeOfString:@"Pad"].location != NSNotFound;
}

BOOL URIsPhone(void){
    static NSInteger isPhone = -1;
    if (isPhone < 0) {
        isPhone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 1 : 0;
    }
    return isPhone > 0;
}


BOOL URIsRetina(void){
    return URScreenScale() >= 2.f;
}


BOOL URIsIphone5(){
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO;
}


BOOL URIsIphone5Above(){
    return URIsIphone5() || URIsIphone6() || URIsIphone6P();
}


BOOL URIsIphone6(){
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        return (MAX([[UIScreen mainScreen] currentMode].size.width, [[UIScreen mainScreen] currentMode].size.height) < 2208) && (MAX([[UIScreen mainScreen] currentMode].size.width, [[UIScreen mainScreen] currentMode].size.height)>1136);
    }
    
    return NO;
}


BOOL URIsIphone6P(){
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        return  MAX([[UIScreen mainScreen] currentMode].size.width, [[UIScreen mainScreen] currentMode].size.height) >= 2208;
    }
    
    return NO;
}

float URGetCachSize(void){
    NSUInteger imageCacheSize = [[SDImageCache sharedImageCache] totalDiskSize];
    
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    
    NSDirectoryEnumerator*enumerator = [[NSFileManager defaultManager]enumeratorAtPath:myCachePath];
    
    __block NSUInteger count =0;
    
    //2.遍历
    for(NSString*fileName in enumerator) {
        
        NSString*path = [myCachePath stringByAppendingPathComponent:fileName];
        
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        count += fileDict.fileSize;//自定义所有缓存大小
    }
    
    // 得到是字节  转化为M
    CGFloat totalSize = ((CGFloat)imageCacheSize+count)/1024/1024;
    
    return totalSize;
}

BOOL URIsPhoneCallSupported(){
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}


BOOL URMakePhoneCall(NSString *phoneNumber){
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        return [[UIApplication sharedApplication] openURL:url];
    }
    else{
        return NO;
    }
}
