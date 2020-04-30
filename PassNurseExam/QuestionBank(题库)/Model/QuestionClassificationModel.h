//
//  QuestionClassificationModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class QuestionClassificationBannerModel,QuestionClassificationTitleModel,QuestionClassificationSubTitleModel ;

NS_ASSUME_NONNULL_BEGIN


@interface QuestionClassificationModel : URCommonObject

@property (nonatomic,strong) NSArray <QuestionClassificationTitleModel *> *data;

@property (nonatomic,strong) NSArray <QuestionClassificationBannerModel *> *data1;

@property (nonatomic,copy) NSString * msg;

@end


@interface QuestionClassificationTitleModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,strong) NSArray <QuestionClassificationSubTitleModel *> * subjects;

@end

@interface QuestionClassificationSubTitleModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,strong) NSString * effective;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,strong) NSString * topic_taxonomy;

@property (nonatomic,copy) NSString * updated_at;

@end


@interface QuestionClassificationBannerModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * value;

@end

NS_ASSUME_NONNULL_END
