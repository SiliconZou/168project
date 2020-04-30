//
//  CourseClassificationModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class CourseClassificationDataModel , CourseClassificationCoursesModel , CourseClassificationBannerModel ;

NS_ASSUME_NONNULL_BEGIN

@interface CourseClassificationModel : URCommonObject

@property (nonatomic,strong) NSArray <CourseClassificationDataModel *> *data;

@property (nonatomic,strong) NSArray <CourseClassificationBannerModel *> *data1;

@end

@interface CourseClassificationDataModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,strong) NSArray <CourseClassificationCoursesModel *> *courses;

@end

@interface CourseClassificationCoursesModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;//二级id

@property (nonatomic,copy) NSString * charge;

@property (nonatomic,copy) NSString * class_hour;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * curricular_taxonomy;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * effective;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * univalence;

@property (nonatomic,copy) NSString * updated_at;

@end


@interface CourseClassificationBannerModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * value;

@end

NS_ASSUME_NONNULL_END
