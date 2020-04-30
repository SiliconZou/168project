//
//  URCommonApiManager+HomePageSection.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonApiManager+HomePageSection.h"

@implementation URCommonApiManager (HomePageSection)

-(URCommonURLSessionTask *)sendExcellentClassroomSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                     requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:HomeExcellentClassroom parameter:nil resultModelClass:[URCommonObject  class] alertStyle:URAlertStyleHUB requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
        
    }] ;
    
}


-(URCommonURLSessionTask *)sendArticleSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:HomeArticle parameter:nil resultModelClass:[URCommonObject  class] alertStyle:URAlertStyleHUB requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
        
    }] ;
    
}

@end
