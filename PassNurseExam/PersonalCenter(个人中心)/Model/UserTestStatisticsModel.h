//
//  UserTestStatisticsModel.h
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/9.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class UserTestStatisticsDataModel ;

NS_ASSUME_NONNULL_BEGIN

@interface UserTestStatisticsModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) NSArray <UserTestStatisticsDataModel *> * data;

@end

@interface UserTestStatisticsDataModel : URCommonObject

@property (nonatomic,copy) NSString * all_num;

@property (nonatomic,copy) NSString * correct_num;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * from;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * subject;

@property (nonatomic,copy) NSString * title;


@end

NS_ASSUME_NONNULL_END
