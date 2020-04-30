//
//  LiveHomeModel.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LiveHomeFamousTeacherModel,LiveHomeRecommedCourseModel ,LiveHomeBroadcastNoticeListModel;

@interface LiveHomeModel : URCommonObject

//名师专场
@property (nonatomic,strong) NSArray <LiveHomeFamousTeacherModel * > * data;
//今日直播课程推荐
@property (nonatomic,strong) NSArray <LiveHomeRecommedCourseModel * > * data1;

/// 直播预告推荐
@property (nonatomic,strong) NSArray <LiveHomeBroadcastNoticeListModel * > * data2;


@end
 
@interface LiveHomeFamousTeacherModel : URCommonObject

@property (nonatomic,copy) NSString * course;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * details;

@property (nonatomic,copy) NSString * effective;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * kit;

@property (nonatomic,copy) NSString * num;

@property (nonatomic,copy) NSString * own;

@property (nonatomic,copy) NSString * sort;

@property (nonatomic,copy) NSString * start_date;

@property (nonatomic,copy) NSString * start_time;

@property (nonatomic,copy) NSString * stop_time;

@property (nonatomic,copy) NSString * subscribe;

@property (nonatomic,copy) NSString * teacher;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * univalence;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * week;

@property (nonatomic,strong) BaseCourseTeacherModel *teacher_info;


@end
 
 
@interface LiveHomeRecommedCourseModel : URCommonObject

@property (nonatomic,copy) NSString * course;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * details;

@property (nonatomic,copy) NSString * effective;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * kit;

@property (nonatomic,copy) NSString * num;

@property (nonatomic,copy) NSString * own;

@property (nonatomic,copy) NSString * sort;

@property (nonatomic,copy) NSString * start_date;

@property (nonatomic,copy) NSString * start_time;

@property (nonatomic,copy) NSString * stop_time;

@property (nonatomic,copy) NSString * subscribe;

@property (nonatomic,copy) NSString * teacher;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * univalence;//价格

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * week;

@property (nonatomic,strong) NSArray <BaseCourseTeacherModel *> *teacher_info;


@end


@interface LiveHomeBroadcastNoticeListModel : URCommonObject

@property (nonatomic,copy) NSString * course;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * details;

@property (nonatomic,copy) NSString * effective;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * kit;

@property (nonatomic,copy) NSString * num;

@property (nonatomic,copy) NSString * own;

@property (nonatomic,copy) NSString * sort;

@property (nonatomic,copy) NSString * start_date;

@property (nonatomic,copy) NSString * start_time;

@property (nonatomic,copy) NSString * stop_time;

@property (nonatomic,copy) NSString * subscribe;

@property (nonatomic,copy) NSString * teacher;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * univalence;//价格

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * week;

@property (nonatomic,strong) NSArray <BaseCourseTeacherModel *> *teacher_info;


@end


NS_ASSUME_NONNULL_END
