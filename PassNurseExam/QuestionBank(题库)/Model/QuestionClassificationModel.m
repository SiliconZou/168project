//
//  QuestionClassificationModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "QuestionClassificationModel.h"

@implementation QuestionClassificationModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[QuestionClassificationTitleModel  class] ,
             @"data1":[QuestionClassificationBannerModel  class]
             } ;
}

@end

@implementation QuestionClassificationTitleModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"subjects":[QuestionClassificationSubTitleModel  class] ,
             } ;
}

@end

@implementation QuestionClassificationSubTitleModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}


@end


@implementation QuestionClassificationBannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}


@end
