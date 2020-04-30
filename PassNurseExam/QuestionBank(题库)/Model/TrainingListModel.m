//
//  TrainingListModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "TrainingListModel.h"

@implementation TrainingListModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[TrainingListDataModel  class]
             
             } ;
}

@end

@implementation TrainingListDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"list":[TrainingListDataListModel  class]
             
             } ;
}

- (id)copyWithZone:(NSZone *)zone{
    TrainingListDataModel* model = [[TrainingListDataModel allocWithZone:zone]init];

    model.isAnswered = self.isAnswered;
    model.name = self.name;
    model.showSheet = self.showSheet;
    
    NSArray <TrainingListDataListModel *> *arr = [[NSArray alloc] initWithArray:self.list copyItems:YES];
    model.list = arr;

//    unsigned int outCount = 0;
//    Ivar* ivars = class_copyIvarList([self class], &outCount);
//    
//    for(int i =0; i < outCount; i++)
//    {
//        Ivar ivar = ivars[i];
//        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        id obj = [self valueForKey:key];
//        [model setValue:obj forKey:key];
//    }
//    free(ivars);
    return model;
}


@end

@implementation TrainingListDataListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id",
             @"publicStr":@"public"
             };
}

- (id)copyWithZone:(NSZone *)zone
{
    TrainingListDataListModel* model = [[TrainingListDataListModel allocWithZone:zone]init];
    
    unsigned int outCount = 0;
    Ivar* ivars = class_copyIvarList([self class], &outCount);
    
    for(int i =0; i < outCount; i++)
    {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id obj = [self valueForKey:key];
        
        if ([key isEqualToString:@"_options"])
        {
            NSArray <OptionsModel *> *arr = [[NSArray alloc] initWithArray:self.options copyItems:YES];
            [model setValue:arr forKey:key];
        }
        else
        {
            [model setValue:obj forKey:key];
        }
    }
    free(ivars);
    return model;
}


@end
