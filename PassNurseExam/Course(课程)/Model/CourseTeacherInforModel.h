//
//  CourseTeacherInforModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/16.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class CourseTeacherInforDataModel , CourseTeacherInforDataTeacherModel ;

NS_ASSUME_NONNULL_BEGIN

@interface CourseTeacherInforModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) CourseTeacherInforDataModel * data;

@property (nonatomic,strong) NSArray <BaseCourseModel *> * data1;


@end

@interface CourseTeacherInforDataModel : URCommonObject

@property (nonatomic,copy) NSString * isPraised;//是否已经点赞

@property (nonatomic,copy) NSString * teachersFlowerCount;//花

@property (nonatomic,copy) NSString * teachersPraiseCount;//赞

@property (nonatomic,strong) CourseTeacherInforDataTeacherModel *teacher;

@end

@interface CourseTeacherInforDataTeacherModel : URCommonObject

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * field;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * style;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * updated_at;

@end



NS_ASSUME_NONNULL_END
