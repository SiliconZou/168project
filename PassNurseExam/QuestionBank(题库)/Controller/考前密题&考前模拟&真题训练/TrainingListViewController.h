//
//  TrainingListViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainingListViewController : URBasicViewController

@property (nonatomic,copy) NSString * subjectID;//二级分类

@property (nonatomic,copy) NSString * categoryID;//科目id

@property (nonatomic,copy) NSString * subTitleStr;//测试名称

@property (nonatomic,copy) NSString * secondTitleStr;

@property (nonatomic,copy) NSString * examTime;

@property (nonatomic,copy) NSString * yearStr;
/**
 1.真题训练 2.考前密题 7.考前模拟
 */
@property (nonatomic,assign) TestType testType;//测试类型

@property (nonatomic,copy) NSString *secretVolume;//考前密题的 idstr

@end

NS_ASSUME_NONNULL_END
