//
//  LiveSectionAllQuestionsModel.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionAllQuestionsModel.h"

@implementation LiveSectionAllQuestionsModel

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"data":[LiveSectionAllQuestionsDataModel class]
    };
}

@end


@implementation LiveSectionAllQuestionsDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
