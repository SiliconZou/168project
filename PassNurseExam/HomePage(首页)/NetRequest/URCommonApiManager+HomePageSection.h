//
//  URCommonApiManager+HomePageSection.h
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonApiManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface URCommonApiManager (HomePageSection)

/**
 首页精品课堂

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 精品课堂
 */
-(URCommonURLSessionTask *)sendExcellentClassroomSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;


/**
 首页新闻资讯

 @param successBlock 请求成功返回
 @param failureBlock 请求失败返回
 @return 新闻资讯
 */
-(URCommonURLSessionTask *)sendArticleSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                               requestFailureBlock:(URCommonResponseFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
