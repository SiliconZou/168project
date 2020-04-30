//
//  AppDelegate+LogIn.m
//  BeiJingHospital
//
//  Created by qc on 2019/5/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "AppDelegate+LogIn.h"
#import "UserLogInViewController.h"

@implementation AppDelegate (LogIn)

-(void)prensentLogInViewController{
    
    NSLog(@"------弹出登录页面-------") ;
    
    UIViewController * viewController = [self  getCurrentViewController] ;
    
    UserLogInViewController * logInViewController = [[UserLogInViewController  alloc] init];
    
    [viewController  presentViewController:[[UINavigationController  alloc]initWithRootViewController:logInViewController] animated:YES completion:nil];
    
}

// 获取当前视图的视图控制器
- (id)getCurrentViewController{
    if ([self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
        id vc = tab.selectedViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)vc;
            return [nav.viewControllers lastObject];
        } else if ([vc isKindOfClass:[UIViewController class]]) {
            return vc;
        }
    } else if ([self.window.rootViewController isKindOfClass:[UIViewController class]]) {
        return self.window.rootViewController;
    } else if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        return [nav.viewControllers lastObject];
    }
    return nil;
}

@end
