//
//  VersionUpdateModel.h
//  PassNurseExam
//
//  Created by quchao on 2019/10/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class VersionUpdateDataModel ;

NS_ASSUME_NONNULL_BEGIN

@interface VersionUpdateModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) VersionUpdateDataModel * data;

@end

@interface VersionUpdateDataModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * version;

@property (nonatomic,copy) NSString * is_force;

@property (nonatomic,copy) NSString * effective;

@property (nonatomic,copy) NSString * is_online;

@property (nonatomic,copy) NSString * download_address;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * updated_at;

@end

NS_ASSUME_NONNULL_END
