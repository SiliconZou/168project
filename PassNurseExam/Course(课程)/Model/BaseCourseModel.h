//
//  BaseCourseModel.h
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/14.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BaseCourseTeacherModel;

@interface BaseCourseModel : URCommonObject

@property (nonatomic,copy) NSString * charge;//是否收费  1收费  0不收费

@property (nonatomic,copy) NSString * class_hour;

@property (nonatomic,copy) NSString * course;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * kit;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * own;//是否已购买

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * univalence;//价格

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * vip;//是否是 会员课程

@property (nonatomic,strong) NSArray <BaseCourseTeacherModel *> *teachers;

@property (nonatomic,copy) NSString * click;//点击量、播放量、学习人数

@end


@interface BaseCourseTeacherModel : URCommonObject

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * field;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * style;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * number;

@end


NS_ASSUME_NONNULL_END
