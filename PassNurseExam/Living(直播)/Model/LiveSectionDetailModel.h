//
//  LiveSectionDetailModel.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class LiveSectionDetailDataModel , LiveSectionDetailData1Model , LiveSectionDetailData1SectionModel ,LiveSectionDetailTeacherModel;

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionDetailModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) LiveSectionDetailDataModel * data;

@property (nonatomic,strong) NSArray <LiveSectionDetailData1Model *> * data1;


@end

@interface LiveSectionDetailDataModel : URCommonObject

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * details;

@property (nonatomic,copy) NSString * effective;

@property (nonatomic,copy) NSString * false_num;

@property (nonatomic,copy) NSString * idStr;

/// 0 是普通用户 1是管理员
@property (nonatomic,copy) NSString * is_admin;

@property (nonatomic,copy) NSString * kit;

@property (nonatomic,copy) NSString * num;

@property (nonatomic,copy) NSString * own;

@property (nonatomic,copy) NSString * sort;

@property (nonatomic,copy) NSString * start_date;

@property (nonatomic,copy) NSString * start_time;

@property (nonatomic,copy) NSString * state;

@property (nonatomic,copy) NSString * stop_time;

@property (nonatomic,copy) NSString * teacher;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * univalence;//价格

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * week;

@property (nonatomic,strong)LiveSectionDetailTeacherModel *teacher_info;

@property (nonatomic,assign) BOOL open;//自定义展开


@end

@interface LiveSectionDetailData1Model : URCommonObject

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * curriculum;

@property (nonatomic,copy) NSString * effective;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * sort;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,strong) NSArray <LiveSectionDetailData1SectionModel *> * live_section;

@property (nonatomic,assign) BOOL open;//自定义属性；是否展开


@end


@interface LiveSectionDetailData1SectionModel : URCommonObject

@property (nonatomic,copy) NSString * VideoId;

/// 播流
@property (nonatomic,copy) NSString * bl;

/// 播流url
@property (nonatomic,copy) NSString * bl_url;

@property (nonatomic,copy) NSString * chapter;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * details;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * kit;

/// 录播
@property (nonatomic,copy) NSString * lb;

/// pc端播流
@property (nonatomic,copy) NSString * pcbl;

/// pc端推流
@property (nonatomic,copy) NSString * pctl;

@property (nonatomic,copy) NSString * pdf;

/// 1.手机端  2.PC端
@property (nonatomic,copy) NSString * sel_bl;

@property (nonatomic,copy) NSString * sort;

@property (nonatomic,copy) NSString * state;

@property (nonatomic,copy) NSString * teacher;

@property (nonatomic,copy) NSString * time_describe;

@property (nonatomic,copy) NSString * title;

/// 推流
@property (nonatomic,copy) NSString * tl;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,strong) NSArray <LiveSectionDetailTeacherModel *> *teacher_info;


@end


@interface LiveSectionDetailTeacherModel : URCommonObject

@property (nonatomic,copy) NSString * api_token;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * describe;

@property (nonatomic,copy) NSString * field;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * number;

@property (nonatomic,copy) NSString * password;

@property (nonatomic,copy) NSString * style;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,copy) NSString * updated_at;


@end


NS_ASSUME_NONNULL_END
