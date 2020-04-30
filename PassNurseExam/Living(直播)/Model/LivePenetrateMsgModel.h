//
//  LivePenetrateMsgModel.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/17.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class  LivePenetrateMsgFromModel ;

NS_ASSUME_NONNULL_BEGIN

@interface LivePenetrateMsgModel : URCommonObject

@property (nonatomic,copy) NSString * from_type;

@property (nonatomic,copy) NSString * from;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * username;

@property (nonatomic,copy) NSString * content;

@property (nonatomic,copy) NSString * time;

@end

@interface LivePenetrateMsgFromModel : URCommonObject

@property (nonatomic,copy) NSString * num;

@property (nonatomic,copy) NSString * false_num;

@end

NS_ASSUME_NONNULL_END
