//
//  CourseTeacherInforModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/16.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "CourseTeacherInforModel.h"

@implementation CourseTeacherInforModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[CourseTeacherInforDataModel  class],
             @"data1":[BaseCourseModel class]
             } ;
}

@end

@implementation CourseTeacherInforDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"teacher":[CourseTeacherInforDataTeacherModel  class]
             } ;
}

@end

@implementation CourseTeacherInforDataTeacherModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end

 
