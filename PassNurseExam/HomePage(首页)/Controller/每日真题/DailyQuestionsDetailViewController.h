//
//  DailyQuestionsDetailViewController.h
//  PassNurseExam
//
//  Created by qc on 15/9/2019.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DailyQuestionsDetailViewController : URBasicViewController

@property (nonatomic ,strong) DailyQuestionsDataModel * dataModel ;
@property (assign) BOOL isPush;
@end

NS_ASSUME_NONNULL_END
