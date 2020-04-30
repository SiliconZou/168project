//
//  LiveSectionAnswerQuestionsModel.m
//  PassNurseExam
//
//  Created by quchao on 2019/11/19.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionAnswerQuestionsModel.h"

@implementation LiveSectionAnswerQuestionsModel

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
              @"from":[LiveSectionAnswerQuestionsFromModel class]
              };
}

@end

@implementation LiveSectionAnswerQuestionsFromModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
