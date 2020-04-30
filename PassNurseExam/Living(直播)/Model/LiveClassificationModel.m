//
//  LiveClassificationModel.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveClassificationModel.h"

@implementation LiveClassificationModel


+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[LiveClassificationDataModel  class] ,
             @"data1":[LiveClassificationBannerModel  class]
             } ;
}

@end

@implementation LiveClassificationDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"courses":[LiveClassificationCoursesModel  class]
             } ;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end

@implementation LiveClassificationCoursesModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end

@implementation LiveClassificationBannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
