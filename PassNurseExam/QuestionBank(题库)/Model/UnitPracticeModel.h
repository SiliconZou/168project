//
//  UnitPracticeModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonObject.h"

NS_ASSUME_NONNULL_BEGIN

@class UnitPracticeDataModel ;

@interface UnitPracticeModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString *msg;

@property (nonatomic,strong) NSArray<UnitPracticeDataModel *> * data;

@end

@interface UnitPracticeDataModel : URCommonObject

@property (nonatomic,copy) NSString * count;

@property (nonatomic,copy) NSString * done;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@end

NS_ASSUME_NONNULL_END
