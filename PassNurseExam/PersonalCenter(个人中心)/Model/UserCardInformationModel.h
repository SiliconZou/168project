//
//  UserCardInformationModel.h
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/8.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class UserCardInformationDataModel  ;

NS_ASSUME_NONNULL_BEGIN

@interface UserCardInformationModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) UserCardInformationDataModel * data;

@end

@interface UserCardInformationDataModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * deadline;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * number;

@property (nonatomic,copy) NSString * state;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,strong) NSArray * imgs;


@end


NS_ASSUME_NONNULL_END
