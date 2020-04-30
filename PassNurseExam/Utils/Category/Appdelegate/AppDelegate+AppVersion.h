//
//  AppDelegate+AppVersion.h
//  PassNurseExam
//
//  Created by qc on 2018/8/29.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "AppDelegate.h"

typedef struct {
    NSInteger majorVersion ;
    NSInteger minorVersion ;
    NSInteger patchVersion ;
} _URAppVersion;

@interface AppDelegate (AppVersion)

@property (nonatomic ,assign ,readonly) _URAppVersion appVersion ;

@property (nonatomic,copy ,readonly) NSString * versionDescription; // eg. 3.2.1

@property (nonatomic,assign ,readonly) NSInteger versionIntVal;

@property (nonatomic,assign ,readonly) NSInteger majorVersion; // 主版本号

@property (nonatomic,assign ,readonly) NSInteger minorVersion; // 子版本号

@property (nonatomic,assign ,readonly) NSInteger patchVersion; //  编译版本号


@end
