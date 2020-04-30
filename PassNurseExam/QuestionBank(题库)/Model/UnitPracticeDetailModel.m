//
//  UnitPracticeDetailModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeDetailModel.h"

@implementation UnitPracticeDetailModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[UnitPracticeDetailDataModel  class]
             } ;
}

@end


@implementation UnitPracticeDetailDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"options":[OptionsModel class]
             } ;
}
@end

@implementation OptionsModel

- (id)copyWithZone:(NSZone *)zone
{
    OptionsModel* model = [[OptionsModel allocWithZone:zone]init];
    
    unsigned int outCount = 0;
    Ivar* ivars = class_copyIvarList([self class], &outCount);
    
    for(int i =0; i < outCount; i++)
    {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id obj = [self valueForKey:key];
        [model setValue:obj forKey:key];
    }
    free(ivars);
    return model;
}


@end
