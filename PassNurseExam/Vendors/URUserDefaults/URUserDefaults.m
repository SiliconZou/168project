//
//  URUserDefaults.m
//  BeiJingHospital
//
//  Created by qc on 2019/5/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URUserDefaults.h"

#define UR_USER_MANAGER @"UR_USER_MANAGER"

@implementation URUserDefaults

static URUserDefaults *userDefaults = nil;

+ (instancetype)standardUserDefaults {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (userDefaults == nil) {
            userDefaults = [[URUserDefaults alloc] initWithIdentifier:UR_USER_MANAGER];
        }
    });
    return userDefaults;
}

#pragma mark - 赋值方法,可根据实际情况自行修改

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
}


@end
