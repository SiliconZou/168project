//
//  TrainingViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainingViewController : URBasicViewController

/**
 一级分类id
 */
@property (nonatomic,copy) NSString * primaryClassificationID;

/**
 二级分类id
 */
@property (nonatomic,copy) NSString * secondaryClassificationID;

@property (nonatomic,assign) TestType testType;//测试类型


//科目名称
@property (nonatomic,copy) NSString * subjectsStr;
@property (nonatomic,copy) NSString *yearStr;
//考前密题的 idstr
@property (nonatomic,copy) NSString *secretVolume;

//考试名称
@property (nonatomic,copy) NSString *examName;

@property (nonatomic,strong) NSDictionary *keMuDict;

@property (nonatomic,strong) NSArray *subjectArr;

@property (nonatomic,copy) NSString *keMuId;

@property (nonatomic,strong) NSArray *yearArr;
@end

NS_ASSUME_NONNULL_END
