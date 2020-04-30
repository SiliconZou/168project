//
//  HomePageNewsInforModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "HomePageNewsInforModel.h"

@implementation HomePageNewsInforModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"classList":[HomePageNewsInforClassListModel  class] ,
             @"firstClassArticleList":[HomePageNewsInforFirstClassArticleListModel  class],
             @"nav":[HomePageNewsInforNavModel class]
             } ;
}


@end

@implementation HomePageNewsInforClassListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end

@implementation HomePageNewsInforFirstClassArticleListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end

@implementation HomePageNewsInforNavModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
