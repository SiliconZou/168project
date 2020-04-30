//
//  AppDelegate+AppVersion.m
//  PassNurseExam
//
//  Created by qc on 2018/8/29.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "AppDelegate+AppVersion.h"

static _URAppVersion kAppVersion ;

static inline void loadAppVersionStruct () {
    
    NSInteger majorVersion = 0 ;
    NSInteger minorVersion = 0 ;
    NSInteger buildNumber = 0 ;
    
    NSString * versionText = URAppVersion() ;
    NSArray * versionArray = [versionText   componentsSeparatedByString:@"."] ;
    
    if (versionArray.count>0) {
        majorVersion = [versionArray[0] integerValue] ;
        minorVersion = [versionArray[1] integerValue] ;
        buildNumber = [versionArray[2] integerValue] ;
        
    } else if (versionArray.count>1) {
        majorVersion = [versionArray[0] intValue];
        minorVersion = [versionArray[1] intValue];
        buildNumber = 0;
    } else if (versionArray.count==1) {
        majorVersion = [versionArray[0] intValue];
        minorVersion = 0;
        buildNumber = 0;
    }
    
    kAppVersion.majorVersion = majorVersion ;
    kAppVersion.minorVersion = minorVersion ;
    kAppVersion.patchVersion = buildNumber ;
    
}

@implementation AppDelegate (AppVersion)

+ (void)load {
    loadAppVersionStruct();
}

- (_URAppVersion)appVersion {
    return kAppVersion;
}

- (NSInteger)majorVersion {
    return kAppVersion.majorVersion;
}


- (NSInteger)minorVersion {
    return kAppVersion.minorVersion;
}

- (NSInteger)patchVersion {
    return kAppVersion.patchVersion;
}

- (NSString *)versionDescription {
    return [NSString stringWithFormat:@"%zd.%zd.%zd", kAppVersion.majorVersion, kAppVersion.minorVersion, kAppVersion.patchVersion];
}

- (NSInteger)versionIntVal {
    return kAppVersion.majorVersion * 10000 + kAppVersion.minorVersion * 100 + kAppVersion.patchVersion;
}

@end
