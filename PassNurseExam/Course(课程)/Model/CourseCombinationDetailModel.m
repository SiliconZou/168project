//
//  CourseCombinationDetailModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseCombinationDetailModel.h"

@implementation CourseCombinationDetailModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[CourseCombinationDetailDataModel  class]
             } ;
}

@end

@implementation CourseCombinationDetailDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"stage":[BaseCourseModel  class]
             } ;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
