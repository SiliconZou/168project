//
//  FmousTeacherBroadcastViewController.h
//  PassNurseExam
//
//  Created by quchao on 2019/10/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FmousTeacherBroadcastViewController : URBasicViewController

@property (nonatomic,strong) LiveClassificationModel * menuModel;
@property (nonatomic ,strong) NSString * courseID ;
@property (nonatomic ,strong) NSString * typeStr ;


@end

NS_ASSUME_NONNULL_END
