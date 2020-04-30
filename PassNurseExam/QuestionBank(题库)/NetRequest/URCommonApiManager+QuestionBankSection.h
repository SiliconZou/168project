//
//  URCommonApiManager+QuestionBankSection.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonApiManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface URCommonApiManager (QuestionBankSection)
/**
 免费题库---考试科目
 @param subjectID 一级分类id
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getExamSubjectDataWithSubjectID:(NSString *)subjectID
                                                     token:(NSString *)token
                                       requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                       requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;
/**
 获取免费题库---题库分类&顶部轮播图

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getQuestionClassificationDataWithRequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                            requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 免费题库---试题类目

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getItemCategoryDataWithSubjectID:(NSString *)subjectID
                                                      token:(NSString *)token
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 免费题库---单元练习列表

 @param subjectID 一级分类id
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getUnitExerciseListDataWithSubjectID:(NSString *)subjectID
                                                          token:(NSString *)token
                                            requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                            requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 免费题库---单元练习---抽题

 @param unitID 单元id
 @param type 类型
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getUnitExerciseDetailDataWithUnitID:(NSString *)unitID
                                                          type:(NSString *)type
                                                         token:(NSString *)token
                                           requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                           requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 免费题库---错题排行列表
 
 @param subjectID 一级分类id
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)getWrongTopicListDataWithSubjectID:(NSString *)subjectID
                                                        token:(NSString *)token
                                          requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 免费题库---收藏题
 
 @param idStr 题目id
 @param type 单元练习题：unit， 每日真题：daily_topic，考前模拟：simulation
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回初始化对象
 */
-(URCommonURLSessionTask *)unitExercisesCollectWithID:(NSString *)idStr
                                                  type:(NSString *)type
                                                 token:(NSString *)token
                                   requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                   requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 免费题库---做题提交
 
 @param record 题目id
 @param type 单元练习题：unit， 每日真题：daily_topic，考前模拟：simulation
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 结果
 */
-(URCommonURLSessionTask *)commitQuestionWithRecord:(NSString *)record
                                                 type:(NSString *)type
                                                token:(NSString *)token
                                                 info:(id)info
                                  requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                  requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;


/**
 免费题库---题目报错

 @param itemid 题目id
 @param describeStr 错误描述
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 结果
 */
-(URCommonURLSessionTask *)reportErrorWithItemid:(NSString *)itemid
                                     describeStr:(NSString *)describeStr
                                           token:(NSString *)token
                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 免费题库---图片--视频题

 @param type 1.图片  2.视频
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 结果
 */
-(URCommonURLSessionTask *)getMediaQuestionDataWithType:(NSString *)type
                                              subjectID:(NSString *)subject_id
                                                  token:(NSString *)token
                                    requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 免费题库---模拟题

 @param type  1.模拟器 2.真题
 @param subjectID 类别id
 @param categoryID 分类id
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 结果
 */
-(URCommonURLSessionTask *)getSimulationQuestionDataWithChooseType:(NSInteger)type
                                                         subjectID:(NSString *)subjectID
                                                        categoryID:(NSString *)categoryID
                                                            token:(NSString *)token
                                                            year:(NSString *)year
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 免费题库---考前密题--卷子

 @param subjectID 类别id
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 结果
 */
-(URCommonURLSessionTask *)getSecretVolumeDataWithSubjectID:(NSString *)subjectID
                                                      token:(NSString *)token
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 免费题库---考前密题--题

 @param volume volume
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 结果
 */
-(URCommonURLSessionTask *)getSecretQuestionDataWithVolume:(NSString *)volume
                                                     token:(NSString *)token
                                       requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                       requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;


@end

NS_ASSUME_NONNULL_END
