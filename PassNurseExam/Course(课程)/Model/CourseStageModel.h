//
//  CourseStageModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class   CourseStageCombinationModel ;

NS_ASSUME_NONNULL_BEGIN

@interface CourseStageModel : URCommonObject

@property (nonatomic,strong) NSArray <BaseCourseModel * > * data;

@property (nonatomic,strong) NSArray <CourseStageCombinationModel * > * data1;


@end


#pragma mark 优惠套餐 (精品课程) model
@interface CourseStageCombinationModel : URCommonObject

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * own;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * nums;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * univalence;

@property (nonatomic,copy) NSString * updated_describe;

@end

NS_ASSUME_NONNULL_END
 
 
