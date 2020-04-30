//
//  URUIKitCoreFunction.m
//  MSSpeed
//
//  Created by qc on 2017/11/28.
//  Copyright © 2017年 qc. All rights reserved.
//

#import "URUIKitCoreFunction.h"



NSString * URBundleIdentifier (){
    return [NSBundle   mainBundle].bundleIdentifier ;
}

NSString * URAppDisplayName (){
    NSDictionary * infoDictionary = [NSBundle   mainBundle].infoDictionary ;
    NSString * displayName = infoDictionary[@"CFBundleDisplayName"] ;
    return displayName ;
}

NSString * URAppVersion (){
    NSDictionary * infoDictionary = [NSBundle   mainBundle].infoDictionary ;
    NSString * versionValue = [NSString  stringWithFormat:@"%@",infoDictionary[@"CFBundleShortVersionString"]] ;
    
    return versionValue ? (NSString *)versionValue  : @"1.0.0" ;
}


NSString * URAppCurVersionNum (){
    NSDictionary * infoDictionary = [NSBundle   mainBundle].infoDictionary ;
    NSString * versionValue = [NSString  stringWithFormat:@"%@",infoDictionary[@"CFBundleVersion"]] ;
    
    return versionValue ? (NSString *)versionValue  : @"1.0.0" ;
}


