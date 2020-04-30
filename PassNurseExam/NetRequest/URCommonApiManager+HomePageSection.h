//
//  URCommonApiManager+HomePageSection.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonApiManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface URCommonApiManager (HomePageSection)

/**
 版本更新

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)getVersionUpdateDataWithSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                            requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 获取首页数据

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 首页数据
 */
-(URCommonURLSessionTask *)getHomePageDataSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                   requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 首页精品课堂

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 精品课堂
 */
-(URCommonURLSessionTask *)sendExcellentClassroomSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;


/**
 首页新闻资讯分类

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 新闻资讯
 */
-(URCommonURLSessionTask *)sendArticleSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                               requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 新闻资讯列表

 @param page 页码
 @param categoryID 类别id
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 新闻资讯列表
 */
-(URCommonURLSessionTask *)getNewsInforListDataWithPage:(NSString *)page
                                             categoryID:(NSString *)categoryID
                                    requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 每日真题列表数据

 @param subjectID 类别id
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 每日真题列表
 */
-(URCommonURLSessionTask *)getDailyQuestionlListDataWithSubjectID:(NSString *)subjectID
                                                            token:(NSString *)token
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 首页资讯搜索

 @param keyword 搜索关键字
 @param page 页码
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 返回
 */
-(URCommonURLSessionTask *)getArticleSearchDataWithKeyWord:(NSString *)keyword
                                                      page:(NSString *)page
                                       requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                       requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/// 获取App配置信息
/// @param successBlock 请求成功返回
/// @param failureBlock 请求失败返回
-(URCommonURLSessionTask *)getAppConfigDataSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;

/**
 获取收藏列表
 
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 收藏资讯列表
 */
-(URCommonURLSessionTask *)getCollectArcitleListWithToken:(NSString *)token
                                    requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 收藏某个文章
 @param articleId articleId 文章ID
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 */
-(URCommonURLSessionTask *)collectArticleWithArticleId:(NSString *)articleId
                                                 token:(NSString *)token
                                    requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;

/**
 是否已收藏某个资讯
 @param articleId articleId 文章ID
 @param token token
 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 */
-(URCommonURLSessionTask *)isCollectArticleWithArticleId:(NSString *)articleId
                                                   token:(NSString *)token
                                    requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock ;
@end

NS_ASSUME_NONNULL_END
