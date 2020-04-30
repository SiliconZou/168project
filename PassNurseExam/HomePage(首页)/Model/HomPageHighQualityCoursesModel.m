//
//  HomPageHighQualityCoursesModel.m
//  PassNurseExam
//
//  Created by 黄彬 on 2019/9/25.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "HomPageHighQualityCoursesModel.h"

@implementation HomPageHighQualityCoursesModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[HomPageHighQualityCoursesDataModel  class]
             } ;
}

@end

@implementation HomPageHighQualityCoursesDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"teachers":[HomPageHighQualityCoursesDataTeacherModel  class]
             } ;
}

@end

@implementation HomPageHighQualityCoursesDataTeacherModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
