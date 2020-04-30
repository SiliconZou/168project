//
//  URCommonApiManager.h
//  BeiJingHospital
//
//  Created by qc on 2019/5/8.
//  Copyright © 2019 ucmed. All rights reserved.
//  请求管理类

#import "AFHTTPSessionManager.h"


/**
 请求成功回调

 @param response  response
 @param responseDict 请求成功回调的参数
 */
typedef void(^URCommonResponseSuccessBlock)(id response , NSDictionary * responseDict);

/**
 请求失败回调

 @param error 错误信息
 @param response 请求失败回调
 */
typedef void(^URCommonResponseFailureBlock)(NSError * error , id response);

typedef NSURLSessionTask URCommonURLSessionTask;

/**
 上传进度

 @param bytesWritten 写入量
 @param totalBytesWritten 总量
 */
typedef void(^URCommonUploadProgressBlock)(int64_t bytesWritten , int64_t totalBytesWritten);

@interface URCommonApiManager : AFHTTPSessionManager

/**
 单例初始化

 @return 返回初始化对象
 */
+ (instancetype)sharedInstance;

/**
 获取baseurl

 @return 返回获取到的baseurl
 */
+ (NSString *)getApiBaseUrl;

/**
 * 设置登录页类名
 *
 * @param loginVCName - 登录类名
 */
+ (void)setLoginViewControllerName:(NSString *)loginVCName;

/**
 * 开启监测网络状态
 *
 * @param enabled - YES：开启监测；NO：关闭
 */
+ (void)monitoringNetworkReachability:(BOOL)enabled;

/**
 * 是否显示手机状态栏的网络访问标示
 *
 * @param enabled - YES：显示；NO：不显示
 */
+ (void)showNetworkActivityIndication:(BOOL)enabled;

/**
 * 数据请求
 *
 * @param apiName - api 名字
 * @param parameter - 请求参数
 * @param successBlock - 请求成功回调
 * @param failureBlock - 请求失败回调
 */
- (URCommonURLSessionTask *)netRequestPOSTWithAPI:(NSString *)apiName
                                        parameter:(NSDictionary *)parameter
                                 resultModelClass:(Class)resultClass
                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 * 数据请求
 *
 * @param apiName - api 名字
 * @param paramete - 请求参数
 * @param alertStyle - 设置请求异常提示类型
 * @param successBlock - 请求成功回调
 * @param failureBlock - 请求失败回调
 */
- (URCommonURLSessionTask *)netRequestPOSTWithAPI:(NSString *)apiName
                                        parameter:(NSDictionary *)paramete
                                 resultModelClass:(Class)resultClass
                                       alertStyle:(URAlertStyle)alertStyle
                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

- (URCommonURLSessionTask *)netRequestPOSTWithAPI:(NSString *)apiName
                                        parameter:(NSDictionary *)parameter
                                 resultModelClass:(Class)resultClass
                            loadingIndicatorStyle:(URLoadingIndicatorStyle)indicatorStyle
                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

- (URCommonURLSessionTask *)netRequestPOSTWithAPI:(NSString *)apiName
                                        parameter:(NSDictionary *)parameter
                                 resultModelClass:(Class)resultClass
                            loadingIndicatorStyle:(URLoadingIndicatorStyle)indicatorStyle
                                       alertStyle:(URAlertStyle)alertStyle
                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;


/**
 * 数据请求
 *
 * @param apiName - api 名字
 * @param parameter - 请求参数
 * @param alertStyle - 设置请求异常提示类型
 * @param successBlock - 请求成功回调
 * @param failureBlock - 请求失败回调
 */
-(URCommonURLSessionTask *)netRequestPOSTWithAPIName:(NSString *)apiName
                                           parameter:(id)parameter
                                    resultModelClass:(Class)resultClass
                                                file:(id)fileData
                                            fileName:(NSString *)fileName
                                            fileType:(NSString *)mimeType
                               loadingIndicatorStyle:(URLoadingIndicatorStyle)indicatorStyle
                                          alertStyle:(URAlertStyle)alertStyle
                                            progress:(URCommonUploadProgressBlock)progress
                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;


/**
 取消所有请求
 */
- (void)URCommonCancelAllRequest;

@end

