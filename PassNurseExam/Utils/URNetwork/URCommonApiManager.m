//
//  URCommonApiManager.m
//  BeiJingHospital
//
//  Created by qc on 2019/5/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonApiManager.h"
#import <AFNetworkActivityIndicatorManager.h>
#import "SDWebImageManager.h"
#import "URCommonObject.h"

static float  const UR_API_DEFAULT_TIMEOUT_SECOND = 60 ;

static AFNetworkReachabilityStatus networkStatus;

static URLoadingIndicator *loadingIndicator = nil;

static NSString *URN_LoginVCName = @"";

@interface URCommonApiManager ()

@property (strong, nonatomic) NSMutableArray *allTasks;

@end

@implementation URCommonApiManager

/**
 * 设置登录页类名
 * @param loginVCName - 登录类名
 */
+ (void)setLoginViewControllerName:(NSString *)loginVCName{
    URN_LoginVCName = loginVCName;
}

+ (void)monitoringNetworkReachability:(BOOL)enabled{
    if (enabled) {
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            networkStatus = status;
            NSString *noteStr = nil;
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:{
                    noteStr = @"当前没有网络";
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    noteStr = @"当前使用手机数据网络";
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    noteStr = @"当前使用 WiFi 网络";
                }
                    break;
                case AFNetworkReachabilityStatusUnknown:
                    
                default:{
                    noteStr = @"未知网络连接";
                }
                    break;
            }
            
            [URAlert alertWithStyle:URAlertStyleHUB
                               type:URAlertTypeInfo
                              title:@"提示"
                            message:noteStr];
        }];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    } else {
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    }
}

+ (void)showNetworkActivityIndication:(BOOL)enabled{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:enabled];
}

/// 单例模式
+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static URCommonApiManager *sharedInstance;
    
    dispatch_once(&once, ^{
        NSURL *URL = [NSURL URLWithString:[self getApiBaseUrl]];
        sharedInstance = [[URCommonApiManager alloc] initWithBaseURL:URL];
        sharedInstance.requestSerializer = [AFHTTPRequestSerializer serializer];
        sharedInstance.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        ///超时时间
        sharedInstance.requestSerializer.timeoutInterval =  UR_API_DEFAULT_TIMEOUT_SECOND;
    });
    return sharedInstance;
}

static NSString * extracted() {
    return HTTPURL;
}

+ (NSString *)getApiBaseUrl {
    return extracted() ;
}

-(URCommonURLSessionTask *)netRequestPOSTWithAPI:(NSString *)apiName
                                       parameter:(NSDictionary *)parameter
                                resultModelClass:(Class)resultClass
                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
//    NSLog(@"-------请求接口名称:%@-------请求入参 : %@",apiName,parameter) ;
    
    return [self   netRequestPOSTWithAPI:apiName
                               parameter:parameter
                        resultModelClass:resultClass
                   loadingIndicatorStyle:URLoadingIndicatorStyleRocket
                              alertStyle:URAlertStyleHUB
                     requestSuccessBlock:^(id  _Nonnull response, NSDictionary * _Nonnull responseDict) {
                         successBlock(response,responseDict) ;
                     }
                     requestFailureBlock:^(NSError * _Nonnull error, id  _Nonnull response) {
                         failureBlock(error,response) ;
                     }] ;
    
}

- (URCommonURLSessionTask *)netRequestPOSTWithAPI:(NSString *)apiName
                                        parameter:(NSDictionary *)paramete
                                 resultModelClass:(Class)resultClass
                                       alertStyle:(URAlertStyle)alertStyle
                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
//    NSLog(@"-------请求接口名称:%@-------请求入参 : %@",apiName,paramete) ;
    
    return [self   netRequestPOSTWithAPI:apiName
                               parameter:paramete
                        resultModelClass:resultClass
                   loadingIndicatorStyle:URLoadingIndicatorStyleRocket
                              alertStyle:alertStyle
                     requestSuccessBlock:^(id  _Nonnull response, NSDictionary * _Nonnull responseDict) {
                         successBlock(response,responseDict) ;
                     }
                     requestFailureBlock:^(NSError * _Nonnull error, id  _Nonnull response) {
                         failureBlock(error,response) ;
                     }] ;
    
}

- (URCommonURLSessionTask *)netRequestPOSTWithAPI:(NSString *)apiName
                                        parameter:(NSDictionary *)parameter
                                 resultModelClass:(Class)resultClass
                            loadingIndicatorStyle:(URLoadingIndicatorStyle)indicatorStyle
                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self   netRequestPOSTWithAPI:apiName
                               parameter:parameter
                        resultModelClass:resultClass
                   loadingIndicatorStyle:indicatorStyle
                              alertStyle:URAlertStyleHUB
                     requestSuccessBlock:^(id  _Nonnull response, NSDictionary * _Nonnull responseDict) {
                         successBlock(response,responseDict) ;
                     }
                     requestFailureBlock:^(NSError * _Nonnull error, id  _Nonnull response) {
                         failureBlock(error,response) ;
                     }] ;
}

- (URCommonURLSessionTask *)netRequestPOSTWithAPI:(NSString *)apiName
                                        parameter:(id)parameter
                                 resultModelClass:(Class)resultClass
                            loadingIndicatorStyle:(URLoadingIndicatorStyle)indicatorStyle
                                       alertStyle:(URAlertStyle)alertStyle
                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    
    URCommonApiManager * apiManager = [[self  class] sharedInstance];
    
    URCommonURLSessionTask * urlSessionTask ;

    apiManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    urlSessionTask = [apiManager  POST:apiName parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([responseObject isKindOfClass:[NSData class]]){
            // 将返回的值直接转化为 json 格式，然后再返回
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//            NSLog(@"------接口名称:%@-----------请求成功返回的参数----------%@",apiName,responseDict) ;
            //从数组中删除任务
            [[self allTasks] removeObject:task];//currentTask
            
            NSString * codeStatus = [[responseDict objectForKey:@"code"] stringValue];
            
            if (codeStatus.integerValue==RequestReturnSuccess) { // 请求成功
                if ([responseDict isKindOfClass:[NSDictionary  class]]) {
                    successBlock([self tryToParseData:responseDict class:resultClass],responseDict) ;
                } else if ([responseDict isKindOfClass:[NSArray  class]]){
                    successBlock(responseDict,responseDict) ;
                } else {
                    successBlock(responseDict,responseDict) ;
                }
            } else if (codeStatus.integerValue==RequestReturnTokenOverdue){// 处理未登录或者token过期，弹出登录页面
                [APP_DELEGATE  prensentLogInViewController] ;
                
            } else { // 请求失败
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if ([[responseDict  allKeys] containsObject:@"msg"]) {
                        
                        NSString * returnMsg = [NSString  stringWithFormat:@"%@",responseDict[@"msg"]] ;
                        
                        if ([NSString  isBlank:returnMsg]==NO) {
                            
                            [URToastHelper  showErrorWithStatus:responseDict[@"msg"]];
                        }
                    }
                    
                    failureBlock(nil,responseDict);
                    
                }) ;
            }
            
        }else{
            
            [URAlert alertWithStyle:alertStyle
                               type:URAlertTypeFailure
                              title:@"提示"
                            message:@"请求失败,请重新尝试"];
            
            failureBlock(responseObject,responseObject);
        }
        
        if (indicatorStyle != URLoadingIndicatorStyleNone) {
            [loadingIndicator stopLoading];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"--------输出错误原因：%@",task.response) ;
        
        if ((error.code != -1001) && (error.code != -1009)) {
            NSError *tempError = error;
            if (networkStatus == AFNetworkReachabilityStatusNotReachable) {
                error = [[NSError alloc] initWithDomain:tempError.domain code:-1009 userInfo:tempError.userInfo];
            } else {
                error = [[NSError alloc] initWithDomain:tempError.domain code:-1001 userInfo:tempError.userInfo];
            }
        }
        failureBlock(error,task.response);
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            networkStatus = status;
            NSString *noteStr = nil;
            if ((status == AFNetworkReachabilityStatusUnknown) || (status == AFNetworkReachabilityStatusNotReachable)) {
                noteStr = @"当前网络不可用，请检查您的网络设置";
            } else {
                noteStr = @"连接服务器失败，请稍后重试";
            }
            [URToastHelper  showErrorWithStatus:noteStr];
        }];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
        
        if (indicatorStyle != URLoadingIndicatorStyleNone) {
            [loadingIndicator stopLoading];
        }
    }] ;
    
    if (indicatorStyle != URLoadingIndicatorStyleNone) {
        loadingIndicator = [[URLoadingIndicator alloc] init];
        [loadingIndicator startLoadingWithCancel:^(id returnValue) {
            [urlSessionTask  cancel] ;
        }];
    }
    
    ///任务开始
    [urlSessionTask resume];
    if (urlSessionTask) {
        [[self allTasks] addObject:urlSessionTask];
    }
    
    return urlSessionTask;
    
}

-(URCommonURLSessionTask *)netRequestPOSTWithAPIName:(NSString *)apiName
                                           parameter:(NSDictionary *)parameter
                                    resultModelClass:(Class)resultClass
                                                file:(id)fileData
                                            fileName:(NSString *)fileName
                                            fileType:(NSString *)mimeType
                               loadingIndicatorStyle:(URLoadingIndicatorStyle)indicatorStyle
                                          alertStyle:(URAlertStyle)alertStyle
                                            progress:(URCommonUploadProgressBlock)progress
                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    URCommonApiManager * apiManager = [[self  class] sharedInstance];
    
    URCommonURLSessionTask * urlSessionTask ;
    
    apiManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    urlSessionTask = [apiManager   POST:apiName parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if ([fileData isKindOfClass:[NSData class]]) {
            [formData appendPartWithFileData:fileData name:@"video" fileName:fileName mimeType:@"video/mp4 "];
        } else if ([fileData isKindOfClass:[UIImage class]]) {
            NSData *data = [UIImagePNGRepresentation(fileData) length]>102400?UIImageJPEGRepresentation(fileData, 0.7):UIImagePNGRepresentation(fileData);
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%@.png",fileName] mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject isKindOfClass:[NSData class]]){
            // 将返回的值直接转化为 json 格式，然后再返回
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//            NSLog(@"------接口名称:%@-----------请求成功返回的参数----------%@",apiName,responseDict) ;
            //从数组中删除任务
            [[self allTasks] removeObject:task];//currentTask
            
            NSString * codeStatus = [[responseDict objectForKey:@"code"] stringValue];
            
            if (codeStatus.integerValue==RequestReturnSuccess) { // 请求成功
                if ([responseDict isKindOfClass:[NSDictionary  class]]) {
                    successBlock([self tryToParseData:responseDict class:resultClass],responseDict) ;
                } else if ([responseDict isKindOfClass:[NSArray  class]]){
                    successBlock(responseDict,responseDict) ;
                } else {
                    successBlock(responseDict,responseDict) ;
                }
            } else if (codeStatus.integerValue==RequestReturnTokenOverdue){// 处理未登录或者token过期，弹出登录页面
                [APP_DELEGATE  prensentLogInViewController] ;
                
            } else { // 请求失败
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if ([[responseDict  allKeys] containsObject:@"msg"]) {
                        
                        NSString * returnMsg = [NSString  stringWithFormat:@"%@",responseDict[@"msg"]] ;
                        
                        if ([NSString  isBlank:returnMsg]==NO) {
                            [URAlert alertWithStyle:alertStyle
                                               type:URAlertTypeFailure
                                              title:@"提示"
                                            message:responseDict[@"msg"]];
                            
                        }
                    }
                    
                    failureBlock(nil,responseDict);
                    
                }) ;
            }
        }else{
            
            [URAlert alertWithStyle:alertStyle
                               type:URAlertTypeFailure
                              title:@"提示"
                            message:@"请求失败,请重新尝试"];
            
            failureBlock(responseObject,responseObject);
        }
        
        if (indicatorStyle != URLoadingIndicatorStyleNone) {
            [loadingIndicator stopLoading];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ((error.code != -1001) && (error.code != -1009)) {
            NSError *tempError = error;
            if (networkStatus == AFNetworkReachabilityStatusNotReachable) {
                error = [[NSError alloc] initWithDomain:tempError.domain code:-1009 userInfo:tempError.userInfo];
            } else {
                error = [[NSError alloc] initWithDomain:tempError.domain code:-1001 userInfo:tempError.userInfo];
            }
        }
        failureBlock(error,task.response);
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            networkStatus = status;
            NSString *noteStr = nil;
            if ((status == AFNetworkReachabilityStatusUnknown) || (status == AFNetworkReachabilityStatusNotReachable)) {
                noteStr = @"当前网络不可用，请检查您的网络设置";
            } else {
                noteStr = @"连接服务器失败，请稍后重试";
            }
            
            [URAlert alertWithStyle:alertStyle
                               type:URAlertTypeFailure
                              title:@"提示"
                            message:noteStr];
        }];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
        
        if (indicatorStyle != URLoadingIndicatorStyleNone) {
            [loadingIndicator stopLoading];
        }
    }];
    
    if (indicatorStyle != URLoadingIndicatorStyleNone) {
        loadingIndicator = [[URLoadingIndicator alloc] init];
        [loadingIndicator startLoadingWithCancel:^(id returnValue) {
            [urlSessionTask  cancel] ;
        }];
    }
    
    ///任务开始
    [urlSessionTask resume];
    if (urlSessionTask) {
        [[self allTasks] addObject:urlSessionTask];
    }
    
    return urlSessionTask;
}


/**
 取消所有请求
 */
- (void)URCommonCancelAllRequest{
    @synchronized(self){
        [[self allTasks] enumerateObjectsUsingBlock:^(URCommonURLSessionTask *  _Nonnull requestTask, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([requestTask isKindOfClass:[URCommonURLSessionTask class]]) {
                [requestTask cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    }
}

/**
 解析返回数据
 
 @param responseData 请求结果
 @param resultClass 返回的对象
 @return 返回
 */
- (id)tryToParseData:(id)responseData class:(Class)resultClass{
    id resultObject;
    if ([responseData isKindOfClass:[NSDictionary class]] && resultClass) {
        resultObject = [resultClass yy_modelWithJSON:responseData];
    } else if ([responseData isKindOfClass:[NSArray class]] && resultClass) {
        resultObject = [NSArray yy_modelArrayWithClass:resultClass json:responseData];
    }
    return resultObject;
}

#pragma mark- setAndget
- (NSMutableArray *)allTasks{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_allTasks == nil) {
            _allTasks = [[NSMutableArray alloc] init];
        }
    });
    return _allTasks;
}

@end
