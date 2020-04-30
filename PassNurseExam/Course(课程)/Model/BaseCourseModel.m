//
//  BaseCourseModel.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/14.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "BaseCourseModel.h"

@implementation BaseCourseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"teachers":[BaseCourseTeacherModel  class]
             } ;
}

@end

@implementation BaseCourseTeacherModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}


@end

