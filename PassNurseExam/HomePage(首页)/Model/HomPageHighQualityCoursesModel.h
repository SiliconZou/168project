//
//  HomPageHighQualityCoursesModel.h
//  PassNurseExam
//
//  Created by 黄彬 on 2019/9/25.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class HomPageHighQualityCoursesDataModel , HomPageHighQualityCoursesDataTeacherModel ;

NS_ASSUME_NONNULL_BEGIN

@interface HomPageHighQualityCoursesModel : URCommonObject

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,copy) NSString * code;

@property (nonatomic,strong) NSArray <HomPageHighQualityCoursesDataModel *> * data ;

@end

@interface HomPageHighQualityCoursesDataModel : URCommonObject

@property (nonatomic,copy) NSString * charge;

@property (nonatomic,copy) NSString * class_hour;

@property (nonatomic,copy) NSString * curricular_taxonomy;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * univalence;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,strong) NSArray <HomPageHighQualityCoursesDataTeacherModel *> *  teachers ;

@end

@interface HomPageHighQualityCoursesDataTeacherModel : URCommonObject

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
