//
//  URCommonApiManager+QuestionBankSection.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonApiManager+QuestionBankSection.h"

@implementation URCommonApiManager (QuestionBankSection)

-(URCommonURLSessionTask *)getExamSubjectDataWithSubjectID:(NSString *)subjectID token:(NSString *)token requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    return [self netRequestPOSTWithAPI:ExamSubject parameter:@{@"subject_id":subjectID,@"api_token":token} resultModelClass:[QuestionClassificationModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response);
    }];
}

-(URCommonURLSessionTask *)getQuestionClassificationDataWithRequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                            requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self   netRequestPOSTWithAPI:QuestionClassification parameter:@{} resultModelClass:[QuestionClassificationModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getItemCategoryDataWithSubjectID:(NSString *)subjectID
                                                      token:(NSString *)token
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
    
    return [self  netRequestPOSTWithAPI:QuestionCategory parameter:@{@"subject_id":subjectID,@"api_token":token} resultModelClass:[QuestionClassCategoryModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        successBlock(response,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getUnitExerciseListDataWithSubjectID:(NSString *)subjectID
                                                          token:(NSString *)token
                                            requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                            requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UnitExerciseList parameter:@{@"subject_id":subjectID,@"api_token":token} resultModelClass:[UnitPracticeModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        successBlock(response,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getUnitExerciseDetailDataWithUnitID:(NSString *)unitID
                                                          type:(NSString *)type
                                                         token:(NSString *)token
                                           requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                           requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UnitExercise parameter:@{@"unit_id":unitID,@"type":type,@"api_token":token} resultModelClass:[UnitPracticeDetailModel   class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        UnitPracticeDetailModel *model = [UnitPracticeDetailModel yy_modelWithDictionary:responseDict];
        
        for (UnitPracticeDetailDataModel *detailModel in model.data)
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
        }
    
        successBlock(model,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getWrongTopicListDataWithSubjectID:(NSString *)subjectID
                                                        token:(NSString *)token
                                          requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    return [self  netRequestPOSTWithAPI:WrongRankingList parameter:@{@"subject_id":subjectID,@"api_token":token} resultModelClass:[WrongRankingModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        WrongRankingModel * model = [WrongRankingModel  yy_modelWithDictionary:responseDict] ;
        
        for (WrongRankingDataModel *detailModel in model.data)
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
        }
        
        successBlock(model,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}


-(URCommonURLSessionTask *)unitExercisesCollectWithID:(NSString *)idStr
                                                  type:(NSString *)type
                                                 token:(NSString *)token
                                   requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                   requestFailureBlock:(URCommonResponseFailureBlock)failureBlock
{
    return [self netRequestPOSTWithAPI:UnitExercisesCollect parameter:@{@"api_token":token,@"id":idStr,@"type":type} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }];
}

-(URCommonURLSessionTask *)commitQuestionWithRecord:(NSString *)record
                                               type:(NSString *)type
                                              token:(NSString *)token
                                               info:(id)info
                                requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                requestFailureBlock:(URCommonResponseFailureBlock)failureBlock
{
    return [self netRequestPOSTWithAPI:CommitQuestion parameter:@{@"api_token":token,@"record":record,@"type":type,@"info":info} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }];
}

-(URCommonURLSessionTask *)reportErrorWithItemid:(NSString *)itemid
                                     describeStr:(NSString *)describeStr
                                           token:(NSString *)token
                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock
{
    return [self netRequestPOSTWithAPI:TitleError parameter:@{@"api_token":token,@"item_id":itemid,@"describe":describeStr} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }];
}

-(URCommonURLSessionTask *)getMediaQuestionDataWithType:(NSString *)type
                                              subjectID:(NSString *)subject_id
                                                  token:(NSString *)token
                                    requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self netRequestPOSTWithAPI:MediaQuestion parameter:@{@"api_token":token,@"type":type,@"subject_id":subject_id} resultModelClass:[QuestionPhotoVideoModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        QuestionPhotoVideoModel * model = [QuestionPhotoVideoModel  yy_modelWithDictionary:responseDict] ;

        QuestionPhotoVideoDataModel *detailModel = model.data;
        
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
        successBlock(detailModel,responseDict);
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }];
}

-(URCommonURLSessionTask *)getSimulationQuestionDataWithChooseType:(NSInteger)type
                                                         subjectID:(NSString *)subjectID
                                                        categoryID:(NSString *)categoryID
                                                             token:(NSString *)token
                                                              year:(NSString *)year
                                               requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                               requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:type==7?SimulationQuestion:OriginalQuestion parameter:@{@"subject_id":subjectID,@"category":categoryID,@"api_token":token,@"year":year} resultModelClass:[TrainingListModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        TrainingListModel * listModel = [TrainingListModel yy_modelWithDictionary:responseDict] ;
        
        for (TrainingListDataModel * listDataModel in listModel.data) {
            
            for (TrainingListDataListModel * dataListModel in listDataModel.list) {
                
                dataListModel.options = [NSMutableArray array];
                
                if (dataListModel.option1.length > 0) {
                    [dataListModel.options addObject:dataListModel.option1];
                }
                if (dataListModel.option2.length > 0) {
                    [dataListModel.options addObject:dataListModel.option2];
                }
                if (dataListModel.option3.length > 0) {
                    [dataListModel.options addObject:dataListModel.option3];
                }
                if (dataListModel.option4.length > 0) {
                    [dataListModel.options addObject:dataListModel.option4];
                }
                if (dataListModel.option5.length > 0) {
                    [dataListModel.options addObject:dataListModel.option5];
                }
                if (dataListModel.option6.length > 0) {
                    [dataListModel.options addObject:dataListModel.option6];
                }
                
                for (int i = 0; i < dataListModel.options.count; i++)
                {
                    OptionsModel *option = [[OptionsModel alloc] init];
                    option.optionName = dataListModel.options[i];
                    option.selected = NO;
                    [dataListModel.options replaceObjectAtIndex:i withObject:option];
                }                
            }
        }
        
        successBlock(listModel ,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}

-(URCommonURLSessionTask *)getSecretVolumeDataWithSubjectID:(NSString *)subjectID
                                                      token:(NSString *)token
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:SecretVolume parameter:@{@"subject_id":subjectID?:@"",@"api_token":token?:@""} resultModelClass:[SecretVolumeModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response ,responseDict) ;

    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
    
}

-(URCommonURLSessionTask *)getSecretQuestionDataWithVolume:(NSString *)volume
                                                     token:(NSString *)token
                                       requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                       requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:SecretQuestion parameter:@{@"volume":volume?:@"",@"api_token":token?:@""} resultModelClass:[TrainingListModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        TrainingListModel * listModel = [TrainingListModel yy_modelWithDictionary:responseDict] ;
        
        for (TrainingListDataModel * listDataModel in listModel.data) {
            
            for (TrainingListDataListModel * dataListModel in listDataModel.list) {
                
                dataListModel.options = [NSMutableArray array];
                
                if (dataListModel.option1.length > 0) {
                    [dataListModel.options addObject:dataListModel.option1];
                }
                if (dataListModel.option2.length > 0) {
                    [dataListModel.options addObject:dataListModel.option2];
                }
                if (dataListModel.option3.length > 0) {
                    [dataListModel.options addObject:dataListModel.option3];
                }
                if (dataListModel.option4.length > 0) {
                    [dataListModel.options addObject:dataListModel.option4];
                }
                if (dataListModel.option5.length > 0) {
                    [dataListModel.options addObject:dataListModel.option5];
                }
                if (dataListModel.option6.length > 0) {
                    [dataListModel.options addObject:dataListModel.option6];
                }
                
                for (int i = 0; i < dataListModel.options.count; i++)
                {
                    OptionsModel *option = [[OptionsModel alloc] init];
                    option.optionName = dataListModel.options[i];
                    option.selected = NO;
                    [dataListModel.options replaceObjectAtIndex:i withObject:option];
                }
            }
        }
        
        successBlock(listModel ,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
        
    }] ;
    
}

@end
