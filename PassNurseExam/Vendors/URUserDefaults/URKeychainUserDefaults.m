//
//  URKeychainUserDefaults.m
//  BeiJingHospital
//
//  Created by qc on 2019/5/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URKeychainUserDefaults.h"

#define UR_KEY_CHAIN_USER_MANAGER @"UR_KEY_CHAIN_USER_MANAGER"


@implementation URKeychainUserDefaults

static URKeychainUserDefaults *userDefaults = nil;

+ (instancetype)standardUserDefaults {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (userDefaults == nil) {
            userDefaults = [[URKeychainUserDefaults alloc] initKeychainObjectWithIdentifier:UR_KEY_CHAIN_USER_MANAGER];
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
