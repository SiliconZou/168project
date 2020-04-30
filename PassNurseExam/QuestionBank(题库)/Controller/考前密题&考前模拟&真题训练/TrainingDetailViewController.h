//
//  TrainingDetailViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainingDetailViewController : URBasicViewController

//用来在这个页面展示和操作的数据
@property (nonatomic,strong) TrainingListDataModel *dataModel;

@property (nonatomic,copy) NSString * titleStr;

@property (nonatomic,copy) NSString * lbTitleStr;

@property (nonatomic,assign) TestType testType;//测试类型

@property (nonatomic,copy) NSString * endtimeStr;

@property (nonatomic,copy) void (^commitBlock) (TrainingListDataModel *model);

@end

NS_ASSUME_NONNULL_END
