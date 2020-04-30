//
//  URURLRouter.m
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "URURLRouter.h"
#import "URURLNavigation.h"

@interface URURLRouter ()

@property (nonatomic ,strong) NSDictionary * configDict ;

@end

@implementation URURLRouter

URSingletonM(URURLRouter)

+ (void)loadConfigDictFromPlist:(NSString *)pistName {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:pistName ofType:nil];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (configDict) {
        [URURLRouter sharedURURLRouter].configDict = configDict;
    }else {
        NSLog(@"请按照说明添加对应的plist文件");
    }
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES ;
    [URURLNavigation pushViewController:viewController animated:animated replace:NO];
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated replace:(BOOL)replace {
    viewController.hidesBottomBarWhenPushed = YES ;
    [URURLNavigation pushViewController:viewController animated:animated replace:replace];
}

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated {
    
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[URURLRouter sharedURURLRouter].configDict];
    viewController.hidesBottomBarWhenPushed = YES ;
    [URURLNavigation pushViewController:viewController animated:animated replace:NO];
}

+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[URURLRouter sharedURURLRouter].configDict];
    viewController.hidesBottomBarWhenPushed = YES ;
    [URURLNavigation pushViewController:viewController animated:animated replace:NO];
}

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated replace:(BOOL)replace{
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[URURLRouter sharedURURLRouter].configDict];
    viewController.hidesBottomBarWhenPushed = YES ;
    [URURLNavigation pushViewController:viewController animated:YES replace:replace];
}


+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    [URURLNavigation presentViewController:viewControllerToPresent animated:animated completion:completion];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated withNavigationClass:(Class)classType completion:(void (^ __nullable)(void))completion {
    
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[classType alloc]initWithRootViewController:viewControllerToPresent];
        [URURLNavigation presentViewController:nav animated:animated completion:completion];
    }
}


+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[URURLRouter sharedURURLRouter].configDict];
    [URURLNavigation presentViewController:viewController animated:animated completion:completion];
}


+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[URURLRouter sharedURURLRouter].configDict];
    [URURLNavigation presentViewController:viewController animated:animated completion:completion];
}


+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated replace:(BOOL)replace{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[URURLRouter sharedURURLRouter].configDict];
    [URURLNavigation pushViewController:viewController animated:animated replace:replace];
}


+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated withNavigationClass:(Class)classType completion:(void (^ __nullable)(void))completion{
    
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[URURLRouter sharedURURLRouter].configDict];
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[classType alloc]initWithRootViewController:viewController];
        [URURLNavigation presentViewController:nav animated:animated completion:completion];
    }
}

+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated withNavigationClass:(Class)clazz completion:(void (^ __nullable)(void))completion{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[URURLRouter sharedURURLRouter].configDict];
    if ([clazz isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[clazz alloc]initWithRootViewController:viewController];
        [URURLNavigation presentViewController:nav animated:animated completion:completion];
    }
}

+ (void)popViewControllerAnimated:(BOOL)animated {
    [URURLNavigation popViewControllerWithTimes:1 animated:animated];
}

+ (void)popTwiceViewControllerAnimated:(BOOL)animated {
    [URURLNavigation popTwiceViewControllerAnimated:animated];
}
+ (void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated {
    [URURLNavigation popViewControllerWithTimes:times animated:animated];
}
+ (void)popToRootViewControllerAnimated:(BOOL)animated {
    [URURLNavigation popToRootViewControllerAnimated:animated];
}

+(void)popToAppointViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [URURLNavigation popToAppointViewController:viewController animated:animated] ;  
}


+ (void)dismissViewControllerAnimated:(BOOL)animated completion: (void (^ __nullable)(void))completion {
    [URURLNavigation dismissViewControllerWithTimes:1 animated:animated completion:completion];
}
+ (void)dismissTwiceViewControllerAnimated:(BOOL)animated completion: (void (^ __nullable)(void))completion {
    [URURLNavigation dismissTwiceViewControllerAnimated:animated completion:completion];
}

+ (void)dismissViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated completion: (void (^ __nullable)(void))completion {
    [URURLNavigation dismissViewControllerWithTimes:times animated:animated completion:completion];
}

+ (void)dismissToRootViewControllerAnimated:(BOOL)animated completion: (void (^ __nullable)(void))completion {
    [URURLNavigation dismissToRootViewControllerAnimated:animated completion:completion];
}

- (UIViewController*)currentViewController {
    return [URURLNavigation sharedURURLNavigation].currentViewController;
}

- (UINavigationController*)currentNavigationViewController {
    return [URURLNavigation sharedURURLNavigation].currentNavigationViewController;
}

@end
