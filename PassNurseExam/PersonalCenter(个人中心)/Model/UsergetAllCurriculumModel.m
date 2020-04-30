//
//  UsergetAllCurriculumModel.m
//  PassNurseExam
//
//  Created by helingmin on 2019/10/28.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "UsergetAllCurriculumModel.h"

@implementation UsergetAllCurriculumModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[UsergetAllCurriculumDataModel  class]
             } ;
}

@end

@implementation UsergetAllCurriculumDataModel

@end
