//
//  UsergetAllCurriculumModel.h
//  PassNurseExam
//
//  Created by helingmin on 2019/10/28.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class UsergetAllCurriculumDataModel ;

NS_ASSUME_NONNULL_BEGIN

@interface UsergetAllCurriculumModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) NSArray <UsergetAllCurriculumDataModel *> * data;

@end

@interface UsergetAllCurriculumDataModel : URCommonObject

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * md5;

@property (nonatomic,copy) NSString * charge;

@property (nonatomic,copy) NSString * vip;

@property (nonatomic,copy) NSString * stage;

@property (nonatomic,copy) NSString * chapter;

@property (nonatomic,copy) NSString * own;


@end

NS_ASSUME_NONNULL_END
