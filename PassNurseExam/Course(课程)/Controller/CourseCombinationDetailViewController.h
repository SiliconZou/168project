//
//  CourseCombinationDetailViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseCombinationDetailViewController : URBasicViewController

@property (nonatomic,copy) NSString *  stageID;

@property (nonatomic,strong) CourseStageCombinationModel * commonModel ;


@end

NS_ASSUME_NONNULL_END
