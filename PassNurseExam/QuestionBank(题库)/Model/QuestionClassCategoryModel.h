//
//  QuestionClassCategoryModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class QuestionClassCategoryDataModel ;

NS_ASSUME_NONNULL_BEGIN

@interface QuestionClassCategoryModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString *msg;

@property (nonatomic,strong) NSArray <QuestionClassCategoryDataModel *> * data;

@end

@interface QuestionClassCategoryDataModel : URCommonObject

@property (nonatomic,copy) NSString * finished;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * total;

@property (nonatomic,copy) NSString * unit;

@property (nonatomic,copy) NSString * haveNew;
@end

NS_ASSUME_NONNULL_END
