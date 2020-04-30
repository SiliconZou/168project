//
//  MineMessageModel.h
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/7.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class MineMessageDataModel , MineMessageData1Model ;

NS_ASSUME_NONNULL_BEGIN

@interface MineMessageModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) NSArray <MineMessageDataModel *> * data;

@property (nonatomic,strong) NSArray <MineMessageData1Model *> * data1;


@end

@interface MineMessageDataModel : URCommonObject

@property (nonatomic,copy) NSString * accept_name;

@property (nonatomic,copy) NSString * accept_uuid;

@property (nonatomic,copy) NSString * content;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * flag;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * read;

@property (nonatomic,copy) NSString * send_name;

@property (nonatomic,copy) NSString * send_uuid;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * updated_at;

@end

@interface MineMessageData1Model : URCommonObject

@property (nonatomic,copy) NSString * accept_name;

@property (nonatomic,copy) NSString * accept_uuid;

@property (nonatomic,copy) NSString * content;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * flag;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * read;

@property (nonatomic,copy) NSString * send_name;

@property (nonatomic,copy) NSString * send_uuid;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * updated_at;

@end

NS_ASSUME_NONNULL_END
