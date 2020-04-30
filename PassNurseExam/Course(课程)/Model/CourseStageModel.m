//
//  CourseStageModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseStageModel.h"

@implementation CourseStageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[BaseCourseModel  class] ,
             @"data1":[CourseStageCombinationModel  class]
             } ;
}


@end


@implementation CourseStageCombinationModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}


@end
