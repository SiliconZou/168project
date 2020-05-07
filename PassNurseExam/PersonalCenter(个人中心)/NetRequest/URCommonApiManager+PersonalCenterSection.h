//
//  URCommonApiManager+PersonalCenterSection.h
//  PassNurseExam
//
//  Created by qc on 2019/9/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonApiManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface URCommonApiManager (PersonalCenterSection)

/**
 用户登录

 @param phone 用户名
 @param password 用户密码
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)sendUserLogInRequestWithPhone:(NSString *)phone
                                                password:(NSString *)password
                                     requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                     requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 注册获取短信验证码/用户找回密码获取验证码

 @param phone 电话号码
 @param type 1.注册获取短信验证码 2.用户找回密码获取验证码
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)sendGetVerificationCodeRequestWithPhone:(NSString *)phone
                                                              type:(NSInteger)type
                                               requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                               requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 用户注册/用户找回密码

 @param phone 电话号码
 @param code 验证码
 @param password 密码
 @param type 1.用户注册 2.用户找回密码
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)sendUserRegisterRequestWithPhone:(NSString *)phone
                                           verificationCode:(NSString *)code
                                                   password:(NSString *)password
                                                       type:(NSInteger)type
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 获取用户信息

 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 */
-(URCommonURLSessionTask *)getUserInformationDataWithToken:(NSString *)token
                   requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                   requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 微信登录接口

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendWXLoginRequestWithCode:(NSString *)code
                                  requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                  requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 绑定微信获取验证码

 @param phone 电话号码
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 */
-(URCommonURLSessionTask *)sendBindWxFindCodeRequestWithPhone:(NSString *)phone
                                          requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;
/**
 绑定微信

 @param phone 电话号码
 @param code 验证码
 @param openid 微信返回的openid
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 */
-(URCommonURLSessionTask *)sendBindWXRequestWithPhone:(NSString *)phone
                                                 code:(NSString *)code
                                               openid:(NSString *)openid
                                  requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                  requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 图片上传

 @param file 图片
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 */
-(URCommonURLSessionTask *)sendUploadImageRequestWithFile:(id)file
                                      requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                      requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 意见反馈

 @param token token
 @param content 反馈的内容
 @param images 上传的图片
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendUserFeedBackRequestWithToken:(NSString *)token
                                                    content:(NSString *)content
                                                     images:(id)images
                                                 imageCount:(NSInteger)imageCount
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 修改用户信息

 @param token token
 @param thumbnail 头像
 @param sex 性别
 @param birthday 出生日期
 @param email 邮箱
 @param username 昵称
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendChangeUserInformationRequestWithToken:(NSString *)token
                                                           thumbnail:(NSString *)thumbnail
                                                                 sex:(NSString *)sex
                                                            birthday:(NSString *)birthday
                                                               email:(NSString *)email
                                                            username:(NSString *)username
                                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 用户签到

 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendUserSignInRequestWithToken:(NSString *)token
                                      requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                      requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;
/**
 用户积分
 
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendUserIntegralRequestWithToken:(NSString *)token
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
考题收藏

 @param token token
 @param subjectID 二级id
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendGetExaminationQuestionsCollectionRequestWithToken:(NSString *)token
                                                                       subjectID:(NSString *)subjectID
                                                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 我的课程

 @param token token
 @param course 课程id
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendMineCourseRequestWithToken:(NSString *)token
                                                   course:(NSString *)course
                                      requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                      requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 获取我的消息数据

 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendRequestGetMineMessageDataWithToken:(NSString *)token
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 消息标记已读

 @param token token
 @param messageID 消息id
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendMineMessageMarkReadRequestWithToken:(NSString *)token
                                                        messgageID:(NSString *)messageID
                                               requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                               requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 获取卡片信息

 @param token token
 @param code code
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendGetCardInformationRequestWithToken:(NSString *)token
                                                             code:(NSString *)code
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 卡片激活

 @param token token
 @param code code
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendActiveCardRequestWithToken:(NSString *)token
                                                     code:(NSString *)code
                                      requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                      requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 获取考试统计数据

 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendGetTestStatisticsDataRequestWithToken:(NSString *)token
                                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;


/**
 获取考试统计详情数据


 @param token token
 @param idStr id
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)sendGetTestStatisticsDetailDataRequestWithToken:(NSString *)token
                                                                     idStr:(NSString *)idStr
                                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/// 购买会员
/// @param token token
/// @param type 支付类型
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)sendBuyMemeberRequestWithToken:(NSString *)token
                                                     type:(NSString *)type
                                      requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                      requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/// 获取用户全部课程及状态
/// @param token token
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)getUserAllCurriculumDataWithToken:(NSString *)token
                                         requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                         requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/// 浏览统计
/// @param token token
/// @param type 课件 curriculum ，直播 live ，做题 question
/// @param type_id 类型id
/// @param time_stamp 应用启动时间戳
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)sendCourseClickStatisticsRquestWithToken:(NSString *)token
                                                               type:(NSString *)type
                                                            type_id:(NSString *)type_id
                                                         time_stamp:(NSString *)time_stamp
                                                requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

-(URCommonURLSessionTask *)getUserBuyLiveCourseDataWithToken:(NSString *)token
                                                      course:(NSString *)course
                                         requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                         requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;
-(URCommonURLSessionTask *)getCustomerServiceNewWithrequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/// 获取用户全部课程及状态
/// @param type_id 当前播放课件Id
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)clickStatisticsWithToken:(NSString *)token
                                            type_id:(NSString *)type_id
                                requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

-(URCommonURLSessionTask *)getCustomerServiceNewWithrequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

@end

NS_ASSUME_NONNULL_END
