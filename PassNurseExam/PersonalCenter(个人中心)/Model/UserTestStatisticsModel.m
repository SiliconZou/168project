//
//  UserTestStatisticsModel.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/9.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserTestStatisticsModel.h"

@implementation UserTestStatisticsModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[UserTestStatisticsDataModel  class]
             } ;
}

@end

@implementation UserTestStatisticsDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
