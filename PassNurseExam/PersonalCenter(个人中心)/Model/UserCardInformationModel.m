//
//  UserCardInformationModel.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/8.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserCardInformationModel.h"

@implementation UserCardInformationModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[UserCardInformationDataModel  class]
             } ;
}

@end

@implementation UserCardInformationDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end


