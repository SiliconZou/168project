//
//  UnitPracticeModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeModel.h"


@implementation UnitPracticeModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[UnitPracticeDataModel  class]
             
             } ;
}

@end

@implementation UnitPracticeDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
