//
//  VersionUpdateModel.m
//  PassNurseExam
//
//  Created by quchao on 2019/10/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "VersionUpdateModel.h"

@implementation VersionUpdateModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[VersionUpdateDataModel  class]
             } ;
}


@end

@implementation VersionUpdateDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
