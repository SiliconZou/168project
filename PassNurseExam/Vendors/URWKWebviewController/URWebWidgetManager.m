//
//  URWebWidgetManager.m
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/18.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import "URWebWidgetManager.h"

@implementation URWebWidgetManager

+ (instancetype)shareInstance {
    static URWebWidgetManager *widget = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        widget = [[URWebWidgetManager alloc] init];
    });
    return widget;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.widgets = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Public
- (void)registerWidgetWithTarget:(id)target interactNames:(NSArray *)interactNames {
    for (NSString *name in interactNames) {
        [self.widgets setObject:target forKey:name];
    }
}

- (void)unregisterWidgetWithTarget:(id)target interactNames:(NSArray *)interactNames {
    for (NSString *name in interactNames) {
        [self.widgets removeObjectForKey:name];
    }
}

+ (id)ur_performSelectorWithTargetName:(NSString *)targetName selector:(SEL)aSelector withObjects:(NSArray *)objects {
    URWebWidgetManager *manager = [URWebWidgetManager shareInstance];
    id realInstance = [manager.widgets objectForKey:targetName];
    if ([realInstance respondsToSelector:aSelector]) {
        NSMethodSignature *signature = [realInstance methodSignatureForSelector:aSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:realInstance];
        [invocation setSelector:aSelector];
        
        NSUInteger i = 1;
        
        for (id object in objects) {
            id tempObject = object;
            [invocation setArgument:&tempObject atIndex:++i];
        }
        [invocation invoke];
        
        if ([signature methodReturnLength]) {
            id data;
            [invocation getReturnValue:&data];
            return data;
        }
    }
    return nil;
}

+ (void)doCallBackWithDict:(NSDictionary *)dict callBackData:(id)data {
    if ([dict objectForKey:@"callBack"] != nil) {
        void (^callBack)(id response) = [dict objectForKey:@"callBack"];
        callBack(data);
    }
}

@end
