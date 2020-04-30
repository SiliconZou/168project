//
//  URCommonApiManager+LiveSection.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonApiManager+LiveSection.h"

@implementation URCommonApiManager (LiveSection)

-(URCommonURLSessionTask *)getLiveClassificationDataWithRequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self netRequestPOSTWithAPI:LiveHomeClassification parameter:@{@"api_token":[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@""} resultModelClass:[LiveClassificationModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getLiveHomeCourseListDataWithCourseId:(NSString *)courseIdstr
                                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    //原接口 LiveHomeCourseList
    return [self netRequestPOSTWithAPI:LiveHomeCourseListNew parameter:@{@"course":courseIdstr,@"api_token":[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@""} resultModelClass:[LiveHomeModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getLiveMoreCourseListDataWithCourseId:(NSString *)courseIdstr
                                                            type:(NSString *)type
                                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock

                                                        {
    
    return [self netRequestPOSTWithAPI:LiveHomeMoreCourseList parameter:@{@"course":courseIdstr,@"type":type} resultModelClass:[FmousTeacherBroadcastModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getLiveSectionDetailDataWithCurriculum:(NSString *)curriculum
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self netRequestPOSTWithAPI:LiveSectionDetailNew parameter:@{@"curriculum":curriculum ?: @"",@"api_token":[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@""} resultModelClass:[LiveSectionDetailModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
           successBlock(response,responseDict) ;
       } requestFailureBlock:^(NSError *error, id response) {
           failureBlock(error,response) ;
       }] ;
    
}

-(URCommonURLSessionTask *)userLogInOutILiveRoomWithType:(NSString *)type
                                               api_token:(NSString *)api_token
                                                tag_name:(NSString *)tag_name
                                           curriculum_id:(NSString *)curriculum_id
                                     requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                     requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:LiveInOut parameter:@{@"type":type?:@"",@"api_token":api_token?:@"",@"tag_name":tag_name?:@"",@"curriculum_id":curriculum_id?:@""} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;

    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }];
}

-(URCommonURLSessionTask *)sendRequestGetFlowerDataWithRequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                       requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:LiveFlower parameter:@{} resultModelClass:[LiveGivingModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }];
}

-(URCommonURLSessionTask *)sendLivePushGroupChatRequestWithApi_token:(NSString *)api_token
                                                            tag_name:(NSString *)tag_name
                                                             content:(NSString *)content
                                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:LivePushGroupChat parameter:@{@"api_token":api_token?:@"",@"tag_name":tag_name?:@"",@"content":content?:@""} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }];
}

-(URCommonURLSessionTask *)sendGiftGivingRequestWithApi_token:(NSString *)api_token
                                                     tag_name:(NSString *)tag_name
                                                       flower:(NSString *)flower
                                                       number:(NSString *)number
                                                   teacher_id:(NSString *)teacher_id
                                          requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:LivePushFlower parameter:@{@"api_token":api_token?:@"",@"tag_name":tag_name?:@"",@"flower":flower?:@"",@"number":number?:@"",@"teacher_id":teacher_id?:@""} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)sendLiveSectionSubmitAnswerRequestWithApi_token:(NSString *)api_token
                                                               question_id:(NSString *)question_id
                                                                    answer:(NSString *)answer
                                                       requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                       requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:LiveSubmitAnswer parameter:@{@"api_token":api_token?:@"",@"question_id":question_id?:@"",@"answer":answer?:@""} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
           successBlock(response,responseDict) ;
       } requestFailureBlock:^(NSError *error, id response) {
           failureBlock(error,response) ;
       }] ;
}

-(URCommonURLSessionTask *)sendLiveSectionBannedRequestWithApi_token:(NSString *)api_token
                                                            tag_name:(NSString *)tag_name
                                                               alias:(NSString *)alias
                                                                type:(NSString *)type
                                                          curriculum:(NSString *)curriculum
                                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:LiveForbiddenWords parameter:@{@"api_token":api_token?:@"",@"tag_name":tag_name?:@"",@"alias":alias?:@"",@"type":type?:@"",@"curriculum":curriculum?:@""} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
         successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)teacherLaunchAttendanceWithApi_token:(NSString *)api_token section_id:(NSString *)section_id state:(NSString *)state_id requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    return [self netRequestPOSTWithAPI:LiveLaunchAttendance parameter:@{@"api_token":api_token?:@"",@"id":section_id?:@"",@"state":state_id?:@""} resultModelClass:[URCommonObject class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response);
    }];
}

-(URCommonURLSessionTask *)studentLaunchAttendanceWithApi_token:(NSString *)api_token section_id:(NSString *)section_id requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    return [self netRequestPOSTWithAPI:StudentLaunchAttendance parameter:@{@"api_token":api_token?:@"",@"id":section_id?:@""} resultModelClass:[URCommonObject class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response);
    }];
}

-(URCommonURLSessionTask *)teacherChangeLiveTimeWithApi_token:(NSString *)api_token type:(NSString *)type time:(NSString *)time section_id:(nonnull NSString *)section_id requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    NSDictionary *dict = [NSDictionary new];
    if ([NSString isEmpty:time]) {
        dict = @{@"api_token":api_token?:@"",@"type":type?:@"",@"id":section_id?:@""};
    } else {
        dict = @{@"api_token":api_token?:@"",@"type":type?:@"",@"time":time?:@"",@"id":section_id?:@""};
    }
    return [self netRequestPOSTWithAPI:ChangeLiveTime parameter:dict resultModelClass:[URCommonObject class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response);
    }];
}

-(URCommonURLSessionTask *)liveSectionManagerSendChangeURLRequestWithApi_token:(NSString *)api_token
                                                                    section_id:(NSString *)section_id
                                                                      url_type:(NSString *)url_type
                                                           requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                           requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:LiveChangeLiveUrl parameter:@{@"api_token":api_token?:@"",@"section_id":section_id?:@"",@"url_type":url_type?:@""} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getLiveSectionAllPushExaminationQuestionsDataWithApi_token:(NSString *)api_token
                                                                           section_id:(NSString *)section_id
                                                                  requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                                  requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:LiveGetAllExaminationQuestions parameter:@{@"api_token":api_token?:@"",@"section_id":section_id?:@""} resultModelClass:[LiveSectionAllQuestionsModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;

    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}

-(URCommonURLSessionTask *)sendPushLiveExaminationQuestionsDataWithApi_token:(NSString *)api_token
                                                                    tag_name:(NSString *)tag_name
                                                                 question_id:(NSString *)question_id
                                                         requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                         requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:LivePushExaminationQuestions parameter:@{@"api_token":api_token?:@"",@"tag_name":tag_name?:@"",@"question_id":question_id?:@""} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
        
    }] ;
}


-(URCommonURLSessionTask *)getLiveAnswerStatisticsDataWithApi_token:(NSString *)api_token
                                                        question_id:(NSString *)question_id
                                                requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:LiveAnswerStatistics parameter:@{@"api_token":api_token?:@"",@"question_id":question_id?:@""} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
        
    }] ;
}

@end
