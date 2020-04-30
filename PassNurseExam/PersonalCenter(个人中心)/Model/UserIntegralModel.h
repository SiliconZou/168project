//
//  UserIntegralModel.h
//  PassNurseExam
//
//  Created by qc on 2019/10/1.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class UserIntegralData1Model ;

NS_ASSUME_NONNULL_BEGIN

@interface UserIntegralModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * data;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) NSArray <UserIntegralData1Model *> * data1;


@end

@interface UserIntegralData1Model : URCommonObject

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * number;

@property (nonatomic,copy) NSString * student;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * updated_at ;


@end

NS_ASSUME_NONNULL_END
