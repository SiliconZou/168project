//
//  LiveGivingModel.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveGivingModel.h"

@implementation LiveGivingModel

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"data":[LiveGivingDataModel class]
    };
}

@end


@implementation LiveGivingDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}


@end
