//
//  URCommonApiManager+HomePageSection.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonApiManager+HomePageSection.h"

@implementation URCommonApiManager (HomePageSection)

-(URCommonURLSessionTask *)getVersionUpdateDataWithSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                            requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    return [self netRequestPOSTWithAPI:VersionUpdate parameter:@{@"type":@"ios",@"versionValue":URAppVersion()} resultModelClass:[VersionUpdateModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {

        successBlock(response,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
    
}

-(URCommonURLSessionTask *)getHomePageDataSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                   requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:HomePageData parameter:nil resultModelClass:[HomePageModel  class] alertStyle:URAlertStyleHUB requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
        
    }] ;
}

-(URCommonURLSessionTask *)sendExcellentClassroomSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                     requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:HomeExcellentClassroom parameter:nil resultModelClass:[URCommonObject  class] alertStyle:URAlertStyleHUB requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
        
    }] ;
    
}


-(URCommonURLSessionTask *)sendArticleSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:HomeArticleClass parameter:nil resultModelClass:[URCommonObject  class] alertStyle:URAlertStyleHUB requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        HomePageNewsInforModel * newsInfroModel = [HomePageNewsInforModel  yy_modelWithDictionary:responseDict[@"data"]] ;
        
        successBlock(newsInfroModel,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
    
}


-(URCommonURLSessionTask *)getNewsInforListDataWithPage:(NSString *)page
                                             categoryID:(NSString *)categoryID
                                    requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
    return [self  netRequestPOSTWithAPI:HomeArticleList parameter:@{@"page":page,@"category_id":categoryID} resultModelClass:[URCommonObject  class] alertStyle:URAlertStyleHUB requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        HomePageNewsInforMoreModel * moreModel = [HomePageNewsInforMoreModel  yy_modelWithDictionary:responseDict[@"data"]] ;
        
        successBlock(moreModel ,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getDailyQuestionlListDataWithSubjectID:(NSString *)subjectID
                                                            token:(NSString *)token
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:DailyQuestionlList parameter:@{@"subject_id":subjectID,@"api_token":token} resultModelClass:[DailyQuestionsModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        DailyQuestionsModel *model = response;
        
        for (DailyQuestionsDataModel *detailModel in model.data)
        {
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
            
            if ([detailModel.finished boolValue])
            {
                for (int i = 0; i < detailModel.my_option.length; i++)
                {
                    //答案是从 1/2/3/4/5/6 开始编号，对应 A/B/C/D/E/F
                    NSInteger index = [[detailModel.my_option substringWithRange:NSMakeRange(i, 1)] integerValue]-1;
                    OptionsModel *option = detailModel.options[index];
                    option.selected = YES;
                }
            }
        }
        successBlock(model,responseDict) ;

    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getArticleSearchDataWithKeyWord:(NSString *)keyword
                                                      page:(NSString *)page
                                       requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                       requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self   netRequestPOSTWithAPI:HomeArticleSearch parameter:@{@"keyword":keyword,@"page":page} resultModelClass:[HomeArticleSearchModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }];
    
}

-(URCommonURLSessionTask *)getAppConfigDataSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self   netRequestPOSTWithAPI:AppConfig parameter:@{} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }];
}

-(URCommonURLSessionTask *)getCollectArcitleListWithToken:(NSString *)token requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    return [self netRequestPOSTWithAPI:CollectList parameter:@{@"api_token":token} resultModelClass:[URCommonObject class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        HomePageNewsInforModel * newsInfroModel = [HomePageNewsInforModel  yy_modelWithDictionary:responseDict[@"data"]] ;
        successBlock(newsInfroModel,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response);
    }];
}

-(URCommonURLSessionTask *)collectArticleWithArticleId:(NSString *)articleId token:(NSString *)token requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    return [self netRequestPOSTWithAPI:CollectArticle parameter:@{@"api_token":token,@"id":articleId} resultModelClass:[URCommonObject class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response);
    }];
}

-(URCommonURLSessionTask *)isCollectArticleWithArticleId:(NSString *)articleId token:(NSString *)token requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    return [self netRequestPOSTWithAPI:IsCollect parameter:@{@"api_token":token,@"id":articleId} resultModelClass:[URCommonObject class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response);
    }];
}
@end
