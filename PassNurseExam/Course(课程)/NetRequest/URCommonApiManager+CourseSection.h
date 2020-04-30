//
//  URCommonApiManager+CourseSection.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonApiManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface URCommonApiManager (CourseSection)

/**
 精品课程---课程分类&顶部轮播图

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getCourseClassificationDataWithRequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 精品课程---课程列表

 @param classID 课程id
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getCourseListDataWithClassId:(NSString *)classID
                                    requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 精品课程---阶段列表

 @param classID 课程id
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getCourseStageListDataWithClassID:(NSString *)classID
                                                   userToken:(NSString *)token
                                         requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                         requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 精品课程---章节和课件

 @param stageID 阶段id
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getChapterCurriculumsDataWithStageID:(NSString *)stageID
                                                      userToken:(NSString *)token
                                            requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                            requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 精品课程---套餐课程---阶段
 
 @param setmealID 课程id
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getSetmealStageDataWithSetmealID:(NSString *)setmealID
                                                  userToken:(NSString *)token
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 精品课程----购买

 @param token token
 @param type 套餐：setmeal，阶段：stage，章节：chapter，视频：curriculum
 @param value type对应的id
 @param choice 微信：wx ,支付宝：ali，余额：yue
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)sendPayCoursewareRequestWithUserToken:(NSString *)token
                                                            type:(NSString *)type
                                                           value:(NSString *)value
                                                          choice:(NSString *)choice
                                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 精品课程---老师信息/精品课程---给老师点赞/精品课程---送花给老师

 @param teacherID 教师id
 @param token token
 @param type 1.精品课程---老师信息 2.精品课程---给老师点赞 3.精品课程---送花给老师
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getCourseTeacherInforDataWithTeacherID:(NSString *)teacherID
                                                        userToken:(NSString *)token
                                                             type:(NSInteger)type
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;




@end

NS_ASSUME_NONNULL_END
