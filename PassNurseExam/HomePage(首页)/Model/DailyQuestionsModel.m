//
//  DailyQuestionsModel.m
//  PassNurseExam
//
//  Created by qc on 14/9/2019.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "DailyQuestionsModel.h"

@implementation DailyQuestionsModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[DailyQuestionsDataModel  class]
             
             } ;
}

@end

@implementation DailyQuestionsDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
