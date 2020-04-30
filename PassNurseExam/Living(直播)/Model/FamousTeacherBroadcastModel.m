//
//  FamousTeacherBroadcastModel.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "FamousTeacherBroadcastModel.h"
#import "LiveHomeModel.h"

@implementation FamousTeacherBroadcastModel

+ (NSDictionary <NSString *, id> *)modelContainerPropertyGenericClass {
    return  @{
        @"data":[LiveHomeFamousTeacherModel class],
    };
}


@end
