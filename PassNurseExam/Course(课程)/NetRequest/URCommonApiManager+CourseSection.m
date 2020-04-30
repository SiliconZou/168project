//
//  URCommonApiManager+CourseSection.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonApiManager+CourseSection.h"

@implementation URCommonApiManager (CourseSection)

-(URCommonURLSessionTask *)getCourseClassificationDataWithRequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self   netRequestPOSTWithAPI:CourseClassification parameter:@{} resultModelClass:[CourseClassificationModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getCourseListDataWithClassId:(NSString *)classID
                                    requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                    requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
    return [self   netRequestPOSTWithAPI:CourseList parameter:@{@"curricular_taxonomy":classID} resultModelClass:[HomPageHighQualityCoursesModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getCourseStageListDataWithClassID:(NSString *)classID
                                                   userToken:(NSString *)token
                                         requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                         requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self   netRequestPOSTWithAPI:CourseStageList parameter:@{@"course":classID,@"api_token":token} resultModelClass:[CourseStageModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getSetmealStageDataWithSetmealID:(NSString *)setmealID
                                                  userToken:(NSString *)token
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
    return [self   netRequestPOSTWithAPI:CourseSetmealStage parameter:@{@"setmeal":setmealID,@"api_token":token} resultModelClass:[CourseCombinationDetailModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
    
}

-(URCommonURLSessionTask *)getChapterCurriculumsDataWithStageID:(NSString *)stageID
                                                      userToken:(NSString *)token
                                            requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                            requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
    return [self   netRequestPOSTWithAPI:CourseChapterCurriculums parameter:@{@"stage":stageID,@"api_token":token} resultModelClass:[CourseCommonDetailModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
    
}

-(URCommonURLSessionTask *)sendPayCoursewareRequestWithUserToken:(NSString *)token
                                                            type:(NSString *)type
                                                           value:(NSString *)value
                                                           choice:(NSString *)choice
                                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self   netRequestPOSTWithAPI:CoursePayCourseware parameter:@{@"api_token":token,@"type":type,@"value":value,@"choice":choice} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getCourseTeacherInforDataWithTeacherID:(NSString *)teacherID
                                                        userToken:(NSString *)token
                                                             type:(NSInteger)type
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
    NSString * apiName ;
    
    if (type==1) {
        apiName = [NSString  stringWithFormat:@"%@",CourseTeacherInfo] ;
    } else if (type==2){
        apiName = [NSString  stringWithFormat:@"%@",CourseSendPraise] ;
    } else if (type==3){
        apiName = [NSString  stringWithFormat:@"%@",CourseSendFlowers] ;
    }
    
    return [self   netRequestPOSTWithAPI:apiName parameter:@{@"teacher_id":teacherID,@"api_token":token} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        if (type==1) {
            CourseTeacherInforModel * teacherInforModel = [CourseTeacherInforModel  yy_modelWithDictionary:responseDict] ;
            
            successBlock(teacherInforModel,responseDict) ;

        }else{
            successBlock(response,responseDict) ;
        }
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
    
}

@end
