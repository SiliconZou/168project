//
//  FmousTeacherBroadcastModel.h
//  PassNurseExam
//
//  Created by quchao on 2019/12/3.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"
 
@class FmousTeacherBroadcastDataModel , FmousTeacherBroadcastDataTeacherInfoModel ;

NS_ASSUME_NONNULL_BEGIN

@interface FmousTeacherBroadcastModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) NSArray <FmousTeacherBroadcastDataModel *> * data;

@end

@interface FmousTeacherBroadcastDataModel : URCommonObject

@property (nonatomic,copy) NSString * base;

@property (nonatomic,copy) NSString * charge;

@property (nonatomic,copy) NSString * course;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * details;

@property (nonatomic,copy) NSString * effective;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * kit;

@property (nonatomic,copy) NSString * notice;

@property (nonatomic,copy) NSString * num;

@property (nonatomic,copy) NSString * sort;

@property (nonatomic,copy) NSString * start_date;

@property (nonatomic,copy) NSString * start_time;

@property (nonatomic,copy) NSString * stop_date;

@property (nonatomic,copy) NSString * stop_time;

@property (nonatomic,copy) NSString * subscribe;

@property (nonatomic,copy) NSString * teacher;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * univalence;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * vip;

@property (nonatomic,copy) NSString * week;

@property (nonatomic,strong) NSArray <FmousTeacherBroadcastDataTeacherInfoModel *> * teacher_info;



@end

@interface FmousTeacherBroadcastDataTeacherInfoModel : URCommonObject

@property (nonatomic,copy) NSString * api_token;

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * code_time;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * field;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * number;

@property (nonatomic,copy) NSString * password;

@property (nonatomic,copy) NSString * phone;

@property (nonatomic,copy) NSString * style;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * updated_at;



@end

NS_ASSUME_NONNULL_END
