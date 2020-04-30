//
//  LiveSectionDetailModel.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionDetailModel.h"

@implementation LiveSectionDetailModel

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"data":[LiveSectionDetailDataModel class],
        @"data1":[LiveSectionDetailData1Model class]
    };
}

@end


@implementation LiveSectionDetailDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"teacher_info":[LiveSectionDetailTeacherModel class]
    };
}

@end


@implementation LiveSectionDetailData1Model

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"live_section":[LiveSectionDetailData1SectionModel class],
    };
}

@end



@implementation LiveSectionDetailData1SectionModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"teacher_info":[LiveSectionDetailTeacherModel class]
    };
}

@end


@implementation LiveSectionDetailTeacherModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
