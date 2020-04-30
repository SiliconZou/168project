//
//  HomePageModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class HomePageCourseModel , HomePageCourseTeacherModel , HomePageInformationModel ,HomePageCourseBannerModel, HomePageCourseTitleBannerModel , CustomerModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomePageModel : URCommonObject

// 精品课程
@property (nonatomic,strong) NSArray <HomePageCourseModel *> * data;

// 最新资讯
@property (nonatomic,strong) NSArray <HomePageInformationModel *> * data1;

// 轮播图
@property (nonatomic,strong) NSArray <HomePageCourseBannerModel *> * data2 ;

// 医护头条
@property (nonatomic,strong) NSArray <HomePageCourseTitleBannerModel *> * data3 ;

// 客服数据
@property (nonatomic,strong) NSArray <CustomerModel *> * data5 ;

@property (nonatomic,copy) NSString * msg;

@end
 
@interface CustomerModel : URCommonObject

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * qq;

@property (nonatomic,copy) NSString * name;
@end

@interface HomePageCourseModel : URCommonObject

@property (nonatomic,copy) NSString * charge;

@property (nonatomic,copy) NSString * class_hour;

@property (nonatomic,copy) NSString * curricular_taxonomy;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * univalence;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,strong) NSArray <HomePageCourseTeacherModel *> * teachers;
 
@end

@interface HomePageCourseTeacherModel : URCommonObject

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * field;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * style;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * updated_at;


@end

@interface HomePageInformationModel : URCommonObject

@property (nonatomic,copy) NSString * category_id;

@property (nonatomic,copy) NSString * click;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * thumb;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * url;

@end

@interface HomePageCourseBannerModel : URCommonObject

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * value;

@end

@interface HomePageCourseTitleBannerModel : URCommonObject

@property (nonatomic,copy) NSString * category_id;

@property (nonatomic,copy) NSString * click;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * thumb;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * url;

@end

NS_ASSUME_NONNULL_END
