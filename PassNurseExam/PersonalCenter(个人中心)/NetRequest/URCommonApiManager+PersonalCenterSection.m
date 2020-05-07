//
//  URCommonApiManager+PersonalCenterSection.m
//  PassNurseExam
//
//  Created by qc on 2019/9/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonApiManager+PersonalCenterSection.h"

@implementation URCommonApiManager (PersonalCenterSection)

-(URCommonURLSessionTask *)sendUserLogInRequestWithPhone:(NSString *)phone
                                                password:(NSString *)password
                                     requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                     requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UserLogIn parameter:@{@"phone":phone?:@"",@"password":password?:@""} resultModelClass:[URCommonObject  class] alertStyle:URAlertStyleHUB requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        // 处理登录成功逻辑
        
        URUserInforModel * inforModel = [[URUserInforModel alloc] init] ;
        inforModel.api_token = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"api_token"]?:@""] ;
        inforModel.phone = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"phone"]?:@""] ;
        inforModel.address = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"address"]?:@""] ;
        inforModel.balance = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"balance"]?:@""] ;
        inforModel.birthday = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"birthday"]?:@""] ;
        inforModel.collection_topic = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"collection_topic"]?:@""] ;
        inforModel.email = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"email"]?:@""] ;
        inforModel.idStr = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"id"]?:@""] ;
        inforModel.integral = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"integral"]?:@""] ;
        inforModel.is_sing = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"is_sing"]?:@""] ;
        inforModel.is_vip = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"is_vip"]?:@""] ;
        inforModel.sex = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"sex"]?:@""] ;
        inforModel.thumbnail = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"thumbnail"]?:@""] ;
        inforModel.username = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"username"]?:@""] ;
        inforModel.invite_code = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"invite_code"]?:@""] ;
        inforModel.loginStatus = @"YES" ;
        
        [URUserDefaults  standardUserDefaults].userInforModel = inforModel ;
        
        [[URUserDefaults  standardUserDefaults] saveAllPropertyAction];
        
        userLoginStatus = YES ;
        
        [JPUSHService  setAlias:inforModel.phone?:@"" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                   
        } seq:0] ;
        
        successBlock(response,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
    
}

-(URCommonURLSessionTask *)sendGetVerificationCodeRequestWithPhone:(NSString *)phone
                                                              type:(NSInteger)type
                                               requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                               requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    NSDictionary * paramsDict = @{
                                  @"phone":[NSString  stringWithFormat:@"%@",phone?:@""]
                                  };
    
    return [self  netRequestPOSTWithAPI:type==1?RegistrationVerificationCode:UserFindCode parameter:paramsDict resultModelClass:[URCommonObject  class] alertStyle:URAlertStyleHUB requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
    
}

-(URCommonURLSessionTask *)sendUserRegisterRequestWithPhone:(NSString *)phone
                                           verificationCode:(NSString *)code
                                                   password:(NSString *)password
                                                       type:(NSInteger)type
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
    return [self  netRequestPOSTWithAPI:type==1?UserRegister:UserFindPassword parameter:@{@"phone":phone?:@"",@"password":password?:@"",@"code":code?:@""} resultModelClass:[URCommonObject  class] alertStyle:URAlertStyleHUB requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        // 处理注册成功之后的逻辑
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
    
}

-(URCommonURLSessionTask *)getUserInformationDataWithToken:(NSString *)token
                   requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                   requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return  [self  netRequestPOSTWithAPI:UserInformation parameter:@{@"api_token":token} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}





-(URCommonURLSessionTask *)sendWXLoginRequestWithCode:(NSString *)code
                                  requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                  requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
    return [self netRequestPOSTWithAPI:UserWXLogin parameter:@{@"code":code} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}

-(URCommonURLSessionTask *)sendBindWxFindCodeRequestWithPhone:(NSString *)phone
                                          requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                          requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UserBindWXFindCode parameter:@{@"phone":phone} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;

    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}

-(URCommonURLSessionTask *)sendBindWXRequestWithPhone:(NSString *)phone
                                                 code:(NSString *)code
                                               openid:(NSString *)openid
                                  requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                  requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UserBindWX parameter:@{@"phone":phone,@"code":code,@"openid":openid} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        URUserInforModel * inforModel = [[URUserInforModel alloc] init] ;
        inforModel.api_token = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"api_token"]?:@""] ;
        inforModel.phone = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"phone"]?:@""] ;
        inforModel.address = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"address"]?:@""] ;
        inforModel.balance = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"balance"]?:@""] ;
        inforModel.birthday = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"birthday"]?:@""] ;
        inforModel.collection_topic = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"collection_topic"]?:@""] ;
        inforModel.email = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"email"]?:@""] ;
        inforModel.idStr = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"id"]?:@""] ;
        inforModel.integral = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"integral"]?:@""] ;
        inforModel.is_sing = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"is_sing"]?:@""] ;
        inforModel.is_vip = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"is_vip"]?:@""] ;
        inforModel.sex = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"sex"]?:@""] ;
        inforModel.thumbnail = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"thumbnail"]?:@""] ;
        inforModel.username = [NSString  stringWithFormat:@"%@",responseDict[@"data"][@"username"]?:@""] ;
        
        inforModel.loginStatus = @"YES" ;
        
        [URUserDefaults  standardUserDefaults].userInforModel = inforModel ;
        
        [[URUserDefaults  standardUserDefaults] saveAllPropertyAction];
        
        userLoginStatus = YES ;
        
        [JPUSHService  setAlias:inforModel.phone?:@"" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
        } seq:0] ;
        
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)sendUploadImageRequestWithFile:(id)file
                                      requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                      requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
    return [self  netRequestPOSTWithAPIName:UserUploadImage parameter:@{@"file":file} resultModelClass:[URCommonObject  class] file:file fileName:@"" fileType:@"image/png" loadingIndicatorStyle:URLoadingIndicatorStyleRocket alertStyle:URAlertStyleHUB progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
        
    } requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        successBlock(response,responseDict) ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}

-(URCommonURLSessionTask *)sendUserFeedBackRequestWithToken:(NSString *)token
                                                    content:(NSString *)content
                                                     images:(id)images
                                                 imageCount:(NSInteger)imageCount
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    NSDictionary * paramsDict ;
    
    if (imageCount>0) {
        paramsDict = @{@"api_token":token,@"content":content,@"imgs":images};
    } else {
        paramsDict = @{@"api_token":token,@"content":content};
    }
        
    
    return [self  netRequestPOSTWithAPI:UserFeedBack parameter:paramsDict resultModelClass:[URCommonObject class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;

    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}

-(URCommonURLSessionTask *)sendChangeUserInformationRequestWithToken:(NSString *)token
                                                           thumbnail:(NSString *)thumbnail
                                                                 sex:(NSString *)sex
                                                            birthday:(NSString *)birthday
                                                               email:(NSString *)email
                                                            username:(NSString *)username
                                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UserChangeInformation parameter:@{@"api_token":token,@"thumbnail":thumbnail,@"sex":sex,@"birthday":birthday,@"email":email,@"username":username} resultModelClass:[URCommonObject class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)sendUserSignInRequestWithToken:(NSString *)token
                                      requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                      requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UserSignIn parameter:@{@"api_token":token} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;

    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}

-(URCommonURLSessionTask *)sendUserIntegralRequestWithToken:(NSString *)token
                                        requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                        requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UserIntegral parameter:@{@"api_token":token} resultModelClass:[UserIntegralModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)sendGetExaminationQuestionsCollectionRequestWithToken:(NSString *)token
                                                                       subjectID:(NSString *)subjectID
                                                             requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                             requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self   netRequestPOSTWithAPI:UserExaminationQuestionsCollection parameter:@{@"api_token":token,@"subject_id":subjectID} resultModelClass:[WrongRankingModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        WrongRankingModel * model = [WrongRankingModel  yy_modelWithDictionary:responseDict] ;
        
        for (WrongRankingDataModel *detailModel in model.data){
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

-(URCommonURLSessionTask *)sendMineCourseRequestWithToken:(NSString *)token
                                                   course:(NSString *)course
                                      requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                      requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:MineCourse parameter:@{@"api_token":token,@"course":course} resultModelClass:[CourseStageModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)sendRequestGetMineMessageDataWithToken:(NSString *)token
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:MineMessages parameter:@{@"api_token":token} resultModelClass:[MineMessageModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}

-(URCommonURLSessionTask *)sendMineMessageMarkReadRequestWithToken:(NSString *)token
                                                        messgageID:(NSString *)messageID
                                               requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                               requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    return [self  netRequestPOSTWithAPI:MineMessageMarkRead parameter:@{@"api_token":token,@"id":messageID} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;

    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
        
    }] ;
}

-(URCommonURLSessionTask *)sendGetCardInformationRequestWithToken:(NSString *)token
                                                             code:(NSString *)code
                                              requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                              requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    
    return [self  netRequestPOSTWithAPI:UserGetCardInformation parameter:@{@"api_token":token,@"code":code} resultModelClass:[UserCardInformationModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;

    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}

-(URCommonURLSessionTask *)sendActiveCardRequestWithToken:(NSString *)token code:(NSString *)code requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UserActivateCard parameter:@{@"api_token":token,@"code":code} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
        
    }] ;
    
}

-(URCommonURLSessionTask *)sendGetTestStatisticsDataRequestWithToken:(NSString *)token
                                                 requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                 requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UserTestStatistics parameter:@{@"api_token":token,@"from":@"ios"} resultModelClass:[UserTestStatisticsModel class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;

    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;

    }] ;
}

-(URCommonURLSessionTask *)sendGetTestStatisticsDetailDataRequestWithToken:(NSString *)token
                                                                     idStr:(NSString *)idStr
                                                       requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                       requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UserTestStatisticsDetail parameter:@{@"api_token":token,@"id":idStr} resultModelClass:[TrainingListModel class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        NSString * dataStr = [NSString  stringWithFormat:@"%@",responseDict[@"data"]] ;
        
        NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        TrainingListModel * dataModel = [TrainingListModel   yy_modelWithDictionary:dic] ;
        
        successBlock(dataModel,responseDict) ;

      } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
     }] ;
}

-(URCommonURLSessionTask *)sendBuyMemeberRequestWithToken:(NSString *)token
                                                     type:(NSString *)type
                                      requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                      requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:BuyMemeber parameter:@{@"api_token":token,@"type":type} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getUserAllCurriculumDataWithToken:(NSString *)token
                                         requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                         requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UsergetAllCurriculum parameter:@{@"api_token":token} resultModelClass:[UsergetAllCurriculumModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)getCustomerServiceNewWithrequestSuccessBlock:(URCommonResponseSuccessBlock)successBlock requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    return [self netRequestPOSTWithAPI:CustomerServiceNew parameter:@{} resultModelClass:[URCodingObject class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response);
    }];
}



-(URCommonURLSessionTask *)sendCourseClickStatisticsRquestWithToken:(NSString *)token
                                                               type:(NSString *)type
                                                            type_id:(NSString *)type_id
                                                         time_stamp:(NSString *)time_stamp
                                                requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                                requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:CourseBrowseStatistics parameter:@{@"api_token":token?:@"",@"type":type?:@"",@"type_id":type_id?:@"",@"time_stamp":time_stamp?:@""} resultModelClass:[URCommonObject  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
           successBlock(response,responseDict) ;
       } requestFailureBlock:^(NSError *error, id response) {
           failureBlock(error,response) ;
       }] ;
    
}

-(URCommonURLSessionTask *)getUserBuyLiveCourseDataWithToken:(NSString *)token
                                                      course:(NSString *)course
                                         requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock
                                         requestFailureBlock:(URCommonResponseFailureBlock)failureBlock{
    
    return [self  netRequestPOSTWithAPI:UserBuyLiveCourse parameter:@{@"api_token":token?:@"",@"course":course?:@""} resultModelClass:[LiveHomeModel  class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict) ;
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response) ;
    }] ;
}

-(URCommonURLSessionTask *)clickStatisticsWithToken:(NSString *)token type_id:(NSString *)type_id requestSuccessBlock:(URCommonResponseSuccessBlock)successBlock requestFailureBlock:(URCommonResponseFailureBlock)failureBlock {
    return [self netRequestPOSTWithAPI:ClickStatistics parameter:@{@"api_token":token,@"type_id":type_id} resultModelClass:[URCommonObject class] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        successBlock(response,responseDict);
    } requestFailureBlock:^(NSError *error, id response) {
        failureBlock(error,response);
    }];
}

@end
