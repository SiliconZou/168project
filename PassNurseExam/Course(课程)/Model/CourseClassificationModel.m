//
//  CourseClassificationModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseClassificationModel.h"

@implementation CourseClassificationModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[CourseClassificationDataModel  class] ,
             @"data1":[CourseClassificationBannerModel  class]
             } ;
}

@end

@implementation CourseClassificationDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"courses":[CourseClassificationCoursesModel  class]
             } ;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end

@implementation CourseClassificationCoursesModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end

@implementation CourseClassificationBannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
