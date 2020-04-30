//
//  QuestionPhotoVideoModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/20.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class QuestionPhotoVideoDataModel ;

NS_ASSUME_NONNULL_BEGIN

@interface QuestionPhotoVideoModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) QuestionPhotoVideoDataModel * data;

@end

@interface QuestionPhotoVideoDataModel : URCommonObject

@property (nonatomic,copy) NSString * analysis;

@property (nonatomic,copy) NSString * answer;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * option1;

@property (nonatomic,copy) NSString * option2;

@property (nonatomic,copy) NSString * option3;

@property (nonatomic,copy) NSString * option4;

@property (nonatomic,copy) NSString * option5;

@property (nonatomic,copy) NSString * option6;

@property (nonatomic,copy) NSString * picture;

@property (nonatomic,copy) NSString * question_type;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * video;

@property (nonatomic,copy) NSString * video_analysis;//解析视频

@property (nonatomic,copy) NSString * difficulty;


//自定义属性
@property (nonatomic,strong) NSMutableArray *options;//选项数组
@property (nonatomic,assign) BOOL showAnswerKeys;//是否显示答题解析
@property (nonatomic,assign) BOOL isAnswered;//已经做过题了


@end

NS_ASSUME_NONNULL_END
