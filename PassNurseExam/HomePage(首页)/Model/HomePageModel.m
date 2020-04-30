//
//  HomePageModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[HomePageCourseModel  class] ,
             @"data1":[HomePageInformationModel  class],
             @"data2":[HomePageCourseBannerModel  class] ,
             @"data3":[HomePageCourseTitleBannerModel  class],
             @"data5":[CustomerModel class]
             } ;
}

@end

@implementation CustomerModel

@end

@implementation HomePageCourseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"teachers":[HomePageCourseTeacherModel  class]
             } ;
}

@end

@implementation HomePageCourseTeacherModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end

@implementation HomePageInformationModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end


@implementation HomePageCourseBannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end


@implementation HomePageCourseTitleBannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
