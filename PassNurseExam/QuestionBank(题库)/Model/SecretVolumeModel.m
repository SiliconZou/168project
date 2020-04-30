//
//  SecretVolumeModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "SecretVolumeModel.h"

@implementation SecretVolumeModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[SecretVolumeDataModel  class]
             
             } ;
}

@end

@implementation SecretVolumeDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
