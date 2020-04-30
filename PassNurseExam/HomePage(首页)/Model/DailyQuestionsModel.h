//
//  DailyQuestionsModel.h
//  PassNurseExam
//
//  Created by qc on 14/9/2019.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class DailyQuestionsDataModel ;

NS_ASSUME_NONNULL_BEGIN

@interface DailyQuestionsModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString *msg;

@property (nonatomic,strong) NSArray<DailyQuestionsDataModel *> * data;


@end

@interface DailyQuestionsDataModel : URCommonObject

@property (nonatomic,copy) NSString * analysis;//答题解析

@property (nonatomic,copy) NSString * answer;//答案

@property (nonatomic,copy) NSString * collected;//已收藏，0未收藏，1已收藏

@property (nonatomic,copy) NSString * difficulty;//难度系数

@property (nonatomic,copy) NSString * error_count;//错误次数

@property (nonatomic,copy) NSString * finished;

@property (nonatomic,copy) NSString * finished_count;//已做次数

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * my_option;

@property (nonatomic,copy) NSString * option1;

@property (nonatomic,copy) NSString * option2;

@property (nonatomic,copy) NSString * option3;

@property (nonatomic,copy) NSString * option4;

@property (nonatomic,copy) NSString * option5;

@property (nonatomic,copy) NSString * option6;

@property (nonatomic,copy) NSString * picture;

@property (nonatomic,copy) NSString * qs_time;

@property (nonatomic,copy) NSString * question_type;//题型A1...

@property (nonatomic,copy) NSString * score;

@property (nonatomic,copy) NSString * subject;

@property (nonatomic,copy) NSString * subject_name;

@property (nonatomic,copy) NSString * title;//题目

@property (nonatomic,copy) NSString * topic_taxonomy;

@property (nonatomic,copy) NSString * type;//1单选题2多选题3判断题***

@property (nonatomic,copy) NSString * video;

@property (nonatomic,copy) NSString * video_analysis;

@property (nonatomic,copy) NSString * year;

//自定义属性
@property (nonatomic,strong) NSMutableArray *options;//选项数组
@property (nonatomic,assign) BOOL showAnswerKeys;//是否显示答题解析

@end

NS_ASSUME_NONNULL_END
