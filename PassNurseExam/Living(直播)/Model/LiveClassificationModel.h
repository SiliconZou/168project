//
//  LiveClassificationModel.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LiveClassificationDataModel,LiveClassificationBannerModel,LiveClassificationCoursesModel;

@interface LiveClassificationModel : NSObject

@property (nonatomic,strong) NSArray <LiveClassificationDataModel *> *data;

@property (nonatomic,strong) NSArray <LiveClassificationBannerModel *> *data1;

@end

@interface LiveClassificationDataModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,strong) NSArray <LiveClassificationCoursesModel *> *courses;

@end

@interface LiveClassificationCoursesModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;//二级id

@property (nonatomic,copy) NSString * charge;

@property (nonatomic,copy) NSString * class_hour;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * curricular_taxonomy;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * effective;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * sort;

@property (nonatomic,copy) NSString * synopsis;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * univalence;

@property (nonatomic,copy) NSString * updated_at;

@end


@interface LiveClassificationBannerModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * value;

@end

NS_ASSUME_NONNULL_END
