//
//  QuestionPhotoVideoModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/20.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "QuestionPhotoVideoModel.h"

@implementation QuestionPhotoVideoModel

//+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
//    
//    return @{
//             @"data":[QuestionPhotoVideoDataModel  class]
//             
//             } ;
//}

@end

@implementation QuestionPhotoVideoDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}

@end
