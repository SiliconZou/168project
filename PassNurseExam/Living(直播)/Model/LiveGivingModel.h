//
//  LiveGivingModel.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class LiveGivingDataModel ;

NS_ASSUME_NONNULL_BEGIN

@interface LiveGivingModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) NSArray <LiveGivingDataModel *> * data;

@end

@interface LiveGivingDataModel : URCommonObject

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name ;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * univalence ;

@property (nonatomic,copy) NSString * updated_at ;


@end

NS_ASSUME_NONNULL_END
