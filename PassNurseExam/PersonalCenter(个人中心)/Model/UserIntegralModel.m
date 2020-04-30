//
//  UserIntegralModel.m
//  PassNurseExam
//
//  Created by qc on 2019/10/1.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserIntegralModel.h"

@implementation UserIntegralModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data1":[UserIntegralData1Model  class]
             } ;
}


@end

@implementation UserIntegralData1Model

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
