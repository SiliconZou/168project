//
//  FamousTeacherBroadcastModel.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LiveHomeModel;

@interface FamousTeacherBroadcastModel : NSObject

//名师专场
@property (nonatomic,strong) NSArray <LiveHomeFamousTeacherModel * > * data;

@end

NS_ASSUME_NONNULL_END
