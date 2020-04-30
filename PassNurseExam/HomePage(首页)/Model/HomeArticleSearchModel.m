//
//  HomeArticleSearchModel.m
//  PassNurseExam
//
//  Created by quchao on 2019/10/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "HomeArticleSearchModel.h"

@implementation HomeArticleSearchModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[HomeArticleSearchDataModel  class]
             } ;
}

@end

@implementation HomeArticleSearchDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[HomeArticleSearchDataDataModel  class]
             } ;
}

@end

@implementation HomeArticleSearchDataDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
