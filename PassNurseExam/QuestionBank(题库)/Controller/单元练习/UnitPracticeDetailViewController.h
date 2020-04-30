//
//  UnitPracticeDetailViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URBasicViewController.h"
#import "UnitPracticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UnitPracticeDetailViewController : URBasicViewController

/**
 1.顺序 2.随机
 */
@property (nonatomic,copy) NSString * type ;

@property (nonatomic,strong) UnitPracticeDataModel *questionBankModel;

@end

NS_ASSUME_NONNULL_END
