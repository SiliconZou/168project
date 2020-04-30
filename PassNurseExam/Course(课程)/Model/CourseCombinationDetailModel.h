//
//  CourseCombinationDetailModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class CourseCombinationDetailDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface CourseCombinationDetailModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) CourseCombinationDetailDataModel * data;

@end

@interface CourseCombinationDetailDataModel : URCommonObject

@property (nonatomic,copy) NSString * advert;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * explain;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * nums;

@property (nonatomic,copy) NSString * original_price;

@property (nonatomic,copy) NSString * own;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * univalence;

@property (nonatomic,copy) NSString * updated_describe;

@property (nonatomic,strong) NSArray <BaseCourseModel *> *stage;

@end


NS_ASSUME_NONNULL_END
