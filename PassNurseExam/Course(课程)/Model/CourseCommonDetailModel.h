//
//  CourseCommonDetailModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"
//#import "BaseCourseModel.h"

@class CourseCommonDetailDataModel,CourseCommonDetailDataCurriculumsModel,BaseCourseModel;

NS_ASSUME_NONNULL_BEGIN

@interface CourseCommonDetailModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) NSArray <CourseCommonDetailDataModel *> * data;

@property (nonatomic,strong) BaseCourseModel * data1;//课程信息 model


@end

#pragma mark 课程--章节目录 model
@interface CourseCommonDetailDataModel : URCommonObject

@property (nonatomic,copy) NSString * charge;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * own;

@property (nonatomic,copy) NSString * stage;

@property (nonatomic,copy) NSString * teacher_describe;

@property (nonatomic,copy) NSString * teacher_id;

@property (nonatomic,copy) NSString * teacher_name;

@property (nonatomic,copy) NSString * teacher_thumbnail;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * univalence;

@property (nonatomic,copy) NSString * vip;

@property (nonatomic,strong) NSArray <CourseCommonDetailDataCurriculumsModel *> *curriculums;

//自定义属性
@property (nonatomic,assign) BOOL selected;

@end

#pragma mark 课程--课件列表目录 model
@interface CourseCommonDetailDataCurriculumsModel : URCommonObject

@property (nonatomic,copy) NSString * chapter;

@property (nonatomic,copy) NSString * charge;

@property (nonatomic,copy) NSString * click;

@property (nonatomic,copy) NSString * course;

@property (nonatomic,copy) NSString * curricular_taxonomy;

@property (nonatomic,copy) NSString * download_address;

@property (nonatomic,copy) NSString * duration;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * maturity_time;

@property (nonatomic,copy) NSString * md5;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * number;

@property (nonatomic,copy) NSString * own;

@property (nonatomic,copy) NSString * play_address;

@property (nonatomic,copy) NSString * recording_time;

@property (nonatomic,copy) NSString * stage;

@property (nonatomic,copy) NSString * univalence;

@property (nonatomic,copy) NSString * vip;

@property (nonatomic,copy) NSString * year;

/** 下载状态 */
@property (nonatomic, assign) TaskDownloadStatus downloadStatus;

@end


NS_ASSUME_NONNULL_END
