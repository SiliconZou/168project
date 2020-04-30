//
//  QuestionClassCategoryModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "QuestionClassCategoryModel.h"

@implementation QuestionClassCategoryModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[QuestionClassCategoryDataModel  class]
             } ;
}

@end

@implementation QuestionClassCategoryDataModel

@end
