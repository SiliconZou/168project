//
//  SecretVolumeModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class SecretVolumeDataModel ;

NS_ASSUME_NONNULL_BEGIN

@interface SecretVolumeModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) NSArray <SecretVolumeDataModel *> * data;

@end

@interface SecretVolumeDataModel : URCommonObject

@property (nonatomic,copy) NSString * category;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * duration;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * quantity;

@property (nonatomic,copy) NSString * subject;

@property (nonatomic,copy) NSString * updated_at;

@end

NS_ASSUME_NONNULL_END
