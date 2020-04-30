//
//  LiveHomeModel.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveHomeModel.h"

@implementation LiveHomeModel


+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"data":[LiveHomeFamousTeacherModel class],
        @"data1":[LiveHomeRecommedCourseModel class],
        @"data2":[LiveHomeBroadcastNoticeListModel  class]
    };
}

@end

@implementation LiveHomeFamousTeacherModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end

@implementation LiveHomeRecommedCourseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"teacher_info":[BaseCourseTeacherModel class],
    };
}

@end

@implementation LiveHomeBroadcastNoticeListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"teacher_info":[BaseCourseTeacherModel class],
    };
}

@end
