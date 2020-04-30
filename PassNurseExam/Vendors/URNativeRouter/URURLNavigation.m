//
//  URURLNavigation.m
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "URURLNavigation.h"

@implementation URURLNavigation

URSingletonM(URURLNavigation) ;

-(UIViewController *)currentViewController {
    
    UIViewController * rootViewController = self.applicationDelegate.window.rootViewController;
    
    return [self   currentViewControllerFrom:rootViewController] ;
}

-(UINavigationController *)currentNavigationViewController {
    
    UIViewController * currentViewController = self.currentViewController ;
    
    return currentViewController.navigationController ;
}

#pragma mark --- PUSH METHOD

+(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated replace:(BOOL)replace {
    if (!viewController) {
        NSLog(@"请添加与url相匹配的控制器到plist文件中,或者协议头可能写错了!") ;
    } else {
        
        if ([viewController  isKindOfClass:[UINavigationController  class]]) {
            // 如果是导航控制器直接设置为根控制器
            [URURLNavigation   setRootViewController:viewController] ;
        } else {
            
            UINavigationController * navigationViewController = [URURLNavigation   sharedURURLNavigation].currentNavigationViewController ;
            
            if (navigationViewController) { // 导航控制器存在
                
                if (replace && [navigationViewController.viewControllers.lastObject  isKindOfClass:[viewController  class]]) {
                    // 切换当前导航控制器 需要把原来的子控制器都取出来重新添加
                    NSArray * viewControllers = [navigationViewController.viewControllers  subarrayWithRange:NSMakeRange(0, navigationViewController.viewControllers.count-1)] ;
                    
                    [navigationViewController  setViewControllers:[viewControllers arrayByAddingObject:viewController] animated:animated] ;
                }  else {// 进行push
                    
                     [navigationViewController pushViewController:viewController animated:animated];
                }
                
            } else {
                // 如果导航控制器不存在,就会创建一个新的,设置为根控制器
                navigationViewController = [[UINavigationController  alloc] initWithRootViewController:viewController];
                
                [URURLNavigation  sharedURURLNavigation].applicationDelegate.window.rootViewController = navigationViewController;
            }
        }
    }
}

#pragma mark --- PRESENT METHOD

+(void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion {
    
    if (!viewController) {
        NSLog(@"请添加与url相匹配的控制器到plist文件中,或者协议头可能写错了!") ;
    } else {
        
        UIViewController * currentViewController = [[URURLNavigation  sharedURURLNavigation]  currentViewController];
        
        if (currentViewController) { // 当前控制器存在
            
            [currentViewController  presentViewController:viewController animated:animated completion:completion] ;
            
        } else {  // 将控制器设置为根控制器
            
            [URURLNavigation  sharedURURLNavigation].applicationDelegate.window.rootViewController = viewController ;
            
        }
    }
}

#pragma mark ----- POP METHOD

+(void)popTwiceViewControllerAnimated:(BOOL)animated {
    
    [URURLNavigation  popViewControllerWithTimes:2 animated:animated] ;
}

+(void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated {
    
    UIViewController * currentViewController = [[URURLNavigation  sharedURURLNavigation]  currentViewController];
    
    NSUInteger count = currentViewController.navigationController.viewControllers.count ;
    
    if (currentViewController) {
        if (currentViewController.navigationController) {
            if (count>times) {// 如果times大于控制器的数量
                [currentViewController.navigationController popToViewController:[currentViewController.navigationController.viewControllers  objectAtIndex:count-1-times] animated:animated] ;
            } else {
                NSLog(@"确定可以pop掉那么多控制器?") ;
            }
        }
    }
}

+(void)popToRootViewControllerAnimated:(BOOL)animated {
    
    UIViewController * currentViewConroller = [URURLNavigation  sharedURURLNavigation].currentViewController ;
    
    NSUInteger  count = currentViewConroller.navigationController.viewControllers.count ;
    
    [URURLNavigation  popViewControllerWithTimes:count-1 animated:YES] ;
}

+(void)popToAppointViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    UIViewController * appointViewController = nil ;
    
    UIViewController * currentViewController = [[URURLNavigation  sharedURURLNavigation]  currentViewController];
    
    for (NSInteger i=0; i<currentViewController.navigationController.viewControllers.count; i++) {
        
        UIViewController * customViewController = currentViewController.navigationController.viewControllers[i] ;
        
        if ([customViewController  isKindOfClass:[UIViewController class]]) {
            appointViewController = customViewController ;
            break ;
        }
        
    }
    
    [currentViewController.navigationController popToViewController:appointViewController animated:animated] ;
    
}

#pragma mark ---- PRESENT METHOD

+(void)dismissTwiceViewControllerAnimated:(BOOL)animated completion:(void (^)())completion {
    
    [URURLNavigation  dismissViewControllerWithTimes:2 animated:animated completion:completion] ;

}

+(void)dismissViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated completion:(void (^)())completion {
    
    UIViewController * rootViewController = [URURLNavigation  sharedURURLNavigation].currentViewController ;
    
    if (rootViewController) {
        while (times>0) {
            rootViewController = rootViewController.presentingViewController ;
            times = -1 ;
        }
        [rootViewController  dismissViewControllerAnimated:animated completion:completion] ;
    }
    
    if (!rootViewController.presentedViewController) {
        
        NSLog(@"确定能dismiss掉这么多控制器?") ;
    }
}

+(void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void (^)())completion {
    
    UIViewController * currentViewContrller = [URURLNavigation  sharedURURLNavigation].currentViewController ;
    
    UIViewController * rootViewController = currentViewContrller ;
    
    while (rootViewController.presentingViewController) {
        rootViewController = rootViewController.presentingViewController ;
    }
    
    [rootViewController  dismissViewControllerAnimated:animated completion:completion] ;
}

#pragma mark  Private METHOD
- (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

// 通过递归拿到当前控制器
- (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    } // 如果传入的控制器是导航控制器,则返回最后一个
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    } // 如果传入的控制器是tabBar控制器,则返回选中的那个
    else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    } // 如果传入的控制器发生了modal,则就可以拿到modal的那个控制器
    else {
        return viewController;
    }
}

// 设置为根控制器
+ (void)setRootViewController:(UIViewController *)viewController{
    
    [URURLNavigation sharedURURLNavigation].applicationDelegate.window.rootViewController = viewController;
}

@end
