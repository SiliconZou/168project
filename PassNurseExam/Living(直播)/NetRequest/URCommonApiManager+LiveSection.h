//
//  URCommonApiManager+LiveSection.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonApiManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface URCommonApiManager (LiveSection)

/**
 直播---直播分类&顶部轮播图

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getLiveClassificationDataWithRequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;


/// 直播---首页课程列表
/// @param courseIdstr 课程二级分类id
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)getLiveHomeCourseListDataWithCourseId:(NSString *)courseIdstr
                                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;


/// 直播---课程列表-更多（直播预告）
/// @param courseIdstr 课程二级分类id
/// @param type 1专场 2 课程 3 预备
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)getLiveMoreCourseListDataWithCourseId:(NSString *)courseIdstr
                                                            type:(NSString *)type
                                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/// 直播课堂--详情
/// @param curriculum 课程id
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)getLiveSectionDetailDataWithCurriculum:(NSString *)curriculum
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/// 直播课程---直播间---出入直播间
/// @param type 1.进入直播间 2.退出直播间
/// @param api_token token
/// @param tag_name tag_name
/// @param curriculum_id curriculum_id
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)userLogInOutILiveRoomWithType:(NSString *)type
                                               api_token:(NSString *)api_token
                                                tag_name:(NSString *)tag_name
                                           curriculum_id:(NSString *)curriculum_id
                                     requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                     requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/// 直播课程---获取礼物“花”数据
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)sendRequestGetFlowerDataWithRequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                  requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/// 直播间发送消息
/// @param api_token token
/// @param tag_name tagname
/// @param content 聊天信息
/// @param successBlock 请求成功返回
/// @param failureBlock 请求成功返回
-(URCommonURLSessionTask *)sendLivePushGroupChatRequestWithApi_token:(NSString *)api_token
                                                            tag_name:(NSString *)tag_name
                                                             content:(NSString *)content
                                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 赠送礼物

 @param api_token 用户token
 @param tag_name  tag_name
 @param flower 礼物id
 @param number 礼物数量
 @param successBlock 请求成功返回
 @param failureBlock 请求成功返回
 */
-(URCommonURLSessionTask *)sendGiftGivingRequestWithApi_token:(NSString *)api_token
                                                     tag_name:(NSString *)tag_name
                                                       flower:(NSString *)flower
                                                       number:(NSString *)number
                                                   teacher_id:(NSString *)teacher_id
                                          requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/// 提交答案
/// @param api_token 用户token
/// @param question_id 题目id
/// @param answer 答案
/// @param successBlock 请求成功返回
/// @param failureBlock 请求成功返回
-(URCommonURLSessionTask *)sendLiveSectionSubmitAnswerRequestWithApi_token:(NSString *)api_token
                                                               question_id:(NSString *)question_id
                                                                    answer:(NSString *)answer
                                                       requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                       requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;


/**
老师发起签到

@param api_token 用户token
@param section_id 课件id（当前直播课section的id）
@param state_id 发起的签到类型
@param successBlock 请求成功返回
@param failureBlock 请求成功返回
@return 请求返回
*/
-(URCommonURLSessionTask *)teacherLaunchAttendanceWithApi_token:(NSString *)api_token
                                                     section_id:(NSString *)section_id
                                                          state:(NSString *)state_id
                                            requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                            requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
学生进行签到

@param api_token 用户token
@param section_id 课件id（当前直播课section的id）
@param successBlock 请求成功返回
@param failureBlock 请求成功返回
@return 请求返回
*/
-(URCommonURLSessionTask *)studentLaunchAttendanceWithApi_token:(NSString *)api_token
                                                     section_id:(NSString *)section_id
                                            requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                            requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
老师发起提前下课延时下课

@param api_token 用户token
@param type 1延堂2下课
@param time 延时时间(可为空)
@param successBlock 请求成功返回
@param failureBlock 请求成功返回
@return 请求返回
*/
-(URCommonURLSessionTask *)teacherChangeLiveTimeWithApi_token:(NSString *)api_token
                                                     type:(NSString *)type
                                                     time:(NSString *)time
                                                 section_id:(NSString *)section_id
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 直播课程---直播间---禁言/解除禁言/踢出

 @param api_token 用户token
 @param tag_name tag_name
 @param alias alias
 @param type 类型
 @param curriculum curriculum
 @param successBlock 请求成功返回
 @param failureBlock 请求成功返回
 @return  请求返回
 */
-(URCommonURLSessionTask *)sendLiveSectionBannedRequestWithApi_token:(NSString *)api_token
                                                            tag_name:(NSString *)tag_name
                                                               alias:(NSString *)alias
                                                                type:(NSString *)type
                                                          curriculum:(NSString *)curriculum
                                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 直播间管理员切换路线

 @param api_token 用户token
 @param section_id 直播间id
 @param url_type url类型
 @param successBlock 请求成功返回
 @param failureBlock 请求成功返回
 @return 请求返回
 */
-(URCommonURLSessionTask *)liveSectionManagerSendChangeURLRequestWithApi_token:(NSString *)api_token
                                                                    section_id:(NSString *)section_id
                                                                      url_type:(NSString *)url_type
                                                           requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                           requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 直播课程---直播间---老师获取所有题

 @param api_token 用户token
 @param section_id 直播间id
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 请求返回
 */
-(URCommonURLSessionTask *)getLiveSectionAllPushExaminationQuestionsDataWithApi_token:(NSString *)api_token
                                                                           section_id:(NSString *)section_id
                                                                  requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                                  requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 直播课程---直播间---推送答题

 @param api_token 用户token
 @param tag_name tag_name
 @param question_id 问题id
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return  请求返回
 */
-(URCommonURLSessionTask *)sendPushLiveExaminationQuestionsDataWithApi_token:(NSString *)api_token
                                                                    tag_name:(NSString *)tag_name
                                                                 question_id:(NSString *)question_id
                                                         requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                         requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/// 答题统计
/// @param api_token 用户token
/// @param question_id 试题id
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)getLiveAnswerStatisticsDataWithApi_token:(NSString *)api_token
                                                        question_id:(NSString *)question_id
                                                requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

@end

NS_ASSUME_NONNULL_END
