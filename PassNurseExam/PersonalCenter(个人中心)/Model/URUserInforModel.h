//
//  URUserInforModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCodingObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface URUserInforModel : URCodingObject

@property (nonatomic,copy) NSString * api_token;

@property (nonatomic,copy) NSString * phone;

/**
 登录状态
 */
@property (nonatomic,copy) NSString *loginStatus;

@property (nonatomic,copy) NSString * address;

@property (nonatomic,copy) NSString * balance;

@property (nonatomic,copy) NSString * birthday;

@property (nonatomic,copy) NSString * collection_topic;

@property (nonatomic,copy) NSString * email;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * integral;

@property (nonatomic,copy) NSString * is_sing;

@property (nonatomic,copy) NSString * is_vip;

@property (nonatomic,copy) NSString * sex;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * username;

@property (nonatomic,copy) NSString * invite_code;
@end

NS_ASSUME_NONNULL_END
