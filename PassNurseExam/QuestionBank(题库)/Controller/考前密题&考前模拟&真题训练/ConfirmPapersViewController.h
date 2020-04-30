//
//  ConfirmPapersViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmPapersViewController : URBasicViewController

@property (nonatomic,copy) NSString * lbTitleStr;

@property (nonatomic,strong) TrainingListModel * listMdel;

@property (nonatomic,assign) NSInteger  type;

@end

NS_ASSUME_NONNULL_END
