//
//  MineMessageModel.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/7.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "MineMessageModel.h"

@implementation MineMessageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[MineMessageDataModel  class],
             @"data1":[MineMessageData1Model class]
             } ;
}

@end

@implementation MineMessageDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end

@implementation MineMessageData1Model

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
