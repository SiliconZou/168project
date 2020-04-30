//
//  AppDelegate.m
//  PassNurseExam
//
//  Created by qc on 2019/9/4.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "AppDelegate.h"
#import "DailyQuestionsModel.h"
#import "DailyQuestionsDetailViewController.h"
BOOL  userLoginStatus;

NSInteger version ;

NSInteger is_force ;

NSInteger effective ;

NSInteger is_online ;

NSString * download_address ;

NSString * describe ;

NSString * updated_at ;

NSString * appStartUpTime ;

static NSString *appKey = @"2f0e1c97678191b7cfbfa01e";
static NSString *channel = @"Publish channel";
static BOOL isProduction = YES;


@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate>

@property (nonatomic ,strong) URTabBarController * tabBarController ;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WXApi registerApp:WXAppID universalLink:UNIVERSAL_LINK];
    [self  initializeiUMShare] ;
    
//    [self   getVersionUpdateData] ;
    
    userLoginStatus = [[URUserDefaults  standardUserDefaults].userInforModel.loginStatus boolValue] ;
    
    [self initialzeJGPushWithOptions:launchOptions] ;

    appStartUpTime = [NSString  ur_getNowTimeStamp] ;
    [[URCommonApiManager  sharedInstance] getVersionUpdateDataWithSuccessBlock:^(id response, NSDictionary *responseDict) {

        VersionUpdateModel * model = response ;

        version = model.data.version.integerValue ;

        is_force = model.data.is_force.integerValue ;

        effective = model.data.effective.integerValue ;

        is_online = 1;//model.data.is_online.integerValue ;

        download_address = [NSString  stringWithFormat:@"%@",model.data.download_address?:@""] ;

        describe = [NSString  stringWithFormat:@"%@",model.data.describe?:@""] ;

        updated_at = [NSString  stringWithFormat:@"%@",model.data.updated_at?:@""] ;
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        self.window.backgroundColor = [UIColor whiteColor];
        
        _tabBarController = [[URTabBarController alloc]init];
        
        self.window.rootViewController=_tabBarController;
        
        [[UITabBar appearance] setTranslucent:NO];
        
        [self.window makeKeyAndVisible];

    } requestFailureBlock:^(NSError *error, id response) {
    }] ;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];

    _tabBarController = [[URTabBarController alloc]init];

    self.window.rootViewController=_tabBarController;

    [[UITabBar appearance] setTranslucent:NO];

    [self.window makeKeyAndVisible];
    
    return YES;
}

+ (instancetype)sharedAppDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

-(void)initialzeJGPushWithOptions:(NSDictionary *)launchOptions{
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
     if (@available(iOS 12.0, *)) {
       entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
     } else {
       entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
     }
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
      if(resCode == 0){
        NSLog(@"registrationID获取成功：%@",registrationID);
        
      }
      else{
        NSLog(@"registrationID获取失败，code：%d",resCode);
      }
    }];
    
    if (userLoginStatus==YES) {
        
        NSLog(@"获取用户ID:%@",[URUserDefaults  standardUserDefaults].userInforModel.phone?:@"");
        
        [JPUSHService  setAlias:[URUserDefaults  standardUserDefaults].userInforModel.phone?:@"" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
        } seq:0] ;
    }
}

/**
 初始化友盟分享
 */
-(void)initializeiUMShare{
    
    /* 打开调试日志 */
    [UMCommonLogManager setUpUMCommonLogManager];
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [UMConfigure initWithAppkey:UMAppKey channel:@"App Store"];
    
    [MobClick setScenarioType:E_UM_NORMAL];

    /*
     设置微信的appKey和appSecret
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession   appKey:WXAppID appSecret:WXAppSecret redirectURL:nil];
}

-(void)getVersionUpdateData{
    
    [[URCommonApiManager  sharedInstance] getVersionUpdateDataWithSuccessBlock:^(id response, NSDictionary *responseDict) {

        VersionUpdateModel * model = response ;

        version = model.data.version.integerValue ;

        is_force = model.data.is_force.integerValue ;

        effective = model.data.effective.integerValue ;

        is_online = 1;//model.data.is_online.integerValue ;

        download_address = [NSString  stringWithFormat:@"%@",model.data.download_address?:@""] ;

        describe = [NSString  stringWithFormat:@"%@",model.data.describe?:@""] ;

        updated_at = [NSString  stringWithFormat:@"%@",model.data.updated_at?:@""] ;

    } requestFailureBlock:^(NSError *error, id response) {

    }] ;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    if([url.host isEqualToString:@"safepay"]){ // 处理支付宝回调
//
//        [AlipayManager openURL:url];
//        return YES;
//    } else { // 处理微信回调
//    }
    
    return [WXManager   handleOpenURL:url];
    
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if([url.host isEqualToString:@"safepay"]){ // 处理支付宝回调
        [AlipayManager openURL:url];
    } else { // 处理微信回调
        [WXManager   handleOpenURL:url];
    }
    return YES;

}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}
#pragma clang diagnostic pop

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    
    if([url.host isEqualToString:@"safepay"]){ // 处理支付宝回调
        [AlipayManager openURL:url];
    } else {
        [WXManager  handleOpenURL:url] ;
    }
    return YES;

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [JPUSHService registerDeviceToken:deviceToken];
}
-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSDictionary *userInfo = notification.request.content.userInfo;
    NSLog(@"收到%@",userInfo);
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"收到推送消息 ： %@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"-=-=-=推送%@",userInfo);
    DailyQuestionsDataModel *detailModel = [DailyQuestionsDataModel yy_modelWithJSON:userInfo];
    DailyQuestionsDetailViewController *detailVC = [[DailyQuestionsDetailViewController alloc] init];
    detailModel.options = [NSMutableArray array];
    
    if (detailModel.option1.length > 0) {
        [detailModel.options addObject:detailModel.option1];
    }
    if (detailModel.option2.length > 0) {
        [detailModel.options addObject:detailModel.option2];
    }
    if (detailModel.option3.length > 0) {
        [detailModel.options addObject:detailModel.option3];
    }
    if (detailModel.option4.length > 0) {
        [detailModel.options addObject:detailModel.option4];
    }
    if (detailModel.option5.length > 0) {
        [detailModel.options addObject:detailModel.option5];
    }
    if (detailModel.option6.length > 0) {
        [detailModel.options addObject:detailModel.option6];
    }
    
    for (int i = 0; i < detailModel.options.count; i++)
    {
        OptionsModel *option = [[OptionsModel alloc] init];
        option.optionName = detailModel.options[i];
        option.selected = NO;
        [detailModel.options replaceObjectAtIndex:i withObject:option];
    }
    
    //如果是已经做过的题，默认展示自己的选项 和 答案解析
    detailModel.showAnswerKeys = [detailModel.finished boolValue];
    detailVC.dataModel = detailModel;
    detailVC.isPush = YES;
    [self getCurrentVC].modalPresentationStyle = UIModalPresentationOverFullScreen;
    [[self getCurrentVC] presentViewController:detailVC animated:YES completion:nil];
    completionHandler();
}

-(void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
