//
//  WrongRankingModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "WrongRankingModel.h"

@implementation WrongRankingModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[WrongRankingDataModel  class]
             
             } ;
}

@end

@implementation WrongRankingDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id",
             @"publicStr":@"public"
             };
}

@end
