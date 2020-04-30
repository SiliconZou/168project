//
//  URPassNurseExamConfig.h
//  PassNurseExam
//
//  Created by qc on 2019/9/6.
//  Copyright © 2019 ucmed. All rights reserved.
//

#ifndef URPassNurseExamConfig_h
#define URPassNurseExamConfig_h

// 记录用户是否登录
extern BOOL userLoginStatus;

// 版本号
extern NSInteger version ;

//是否强制
extern NSInteger is_force ;

// 是否有效
extern NSInteger effective ;

// 是否上线
extern NSInteger is_online ;

// 下载地址
extern NSString * download_address ;

// 更新描述
extern NSString * describe ;

// 更新时间
extern NSString * updated_at ;

// App启动时间
extern NSString * appStartUpTime ;

// 1.真题训练 2.考前密题 7.考前模拟
typedef NS_ENUM(NSInteger,TestType) {
    TestType_Simulation = 7,      //考前模拟题
    TestType_Original = 1,        //真题训练
    TestType_Secret = 2,          //考前密题
} ;

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \

//微信AppID
#define WXAppID @"wxb8b4de88e25c90d0"

#define WXAppSecret @"4f4036bfae2f048b0f3763c343cd7288"
#define UNIVERSAL_LINK @"https://edu.168wangxiao.cn/apple-app-site-association/"
//QQKEY
#define QQKey @"1106133585"

#define QQ @"1220290000"

#define Ease_Appkey @"z547658579#hkt"

#define ShareSDK_AppKey @"18df20a621398"

#define UMAppKey  @"570b6ccb67e58e1025001161"

#define URShareURL @"https://edu.168wangxiao.cn"//@"https://www.baidu.com"

#define WEAKSELF(A) __weak typeof(A) weakSelf = A;

#define APP_DELEGATE    (AppDelegate*)[[UIApplication sharedApplication] delegate]

#define WXManager [WXCallBackManager sharedInstance]


#endif /* URPassNurseExamConfig_h */
