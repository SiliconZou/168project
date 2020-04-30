//
//  CoursePayViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/18.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoursePayViewController : URBasicViewController

@property (nonatomic,copy) NSString * univalence;
@property (nonatomic,copy) NSString * idStr;
@property (nonatomic,strong) NSArray <BaseCourseModel *> *stage;

//购买类型：    套餐：setmeal，阶段：stage，章节：chapter，视频：curriculum
@property (nonatomic ,copy) NSString *buyType;

@end

NS_ASSUME_NONNULL_END
