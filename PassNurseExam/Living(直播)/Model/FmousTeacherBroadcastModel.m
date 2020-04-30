//
//  FmousTeacherBroadcastModel.m
//  PassNurseExam
//
//  Created by quchao on 2019/12/3.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "FmousTeacherBroadcastModel.h"

@implementation FmousTeacherBroadcastModel

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"data":[FmousTeacherBroadcastDataModel class]
    };
}

@end


@implementation FmousTeacherBroadcastDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"teacher_info":[FmousTeacherBroadcastDataTeacherInfoModel class]
    };
}

@end


@implementation FmousTeacherBroadcastDataTeacherInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}


@end
