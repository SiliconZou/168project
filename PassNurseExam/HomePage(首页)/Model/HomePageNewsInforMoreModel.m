//
//  HomePageNewsInforMoreModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomePageNewsInforMoreModel.h"

@implementation HomePageNewsInforMoreModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[HomePageNewsInforMoreListModel  class]
             } ;
}

@end

@implementation HomePageNewsInforMoreListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
