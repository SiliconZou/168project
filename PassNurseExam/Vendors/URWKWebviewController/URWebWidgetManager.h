//
//  URWebWidgetManager.h
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/18.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URWebWidgetManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *widgets;

+ (instancetype)shareInstance;
- (void)registerWidgetWithTarget:(id)target interactNames:(NSArray *)interactNames;
- (void)unregisterWidgetWithTarget:(id)target interactNames:(NSString *)interactNames;
+ (id)ur_performSelectorWithTargetName:(NSString *)targetName selector:(SEL)aSelector withObjects:(NSArray *)objects;
+ (void)doCallBackWithDict:(NSDictionary *)dict callBackData:(id)data;

@end
