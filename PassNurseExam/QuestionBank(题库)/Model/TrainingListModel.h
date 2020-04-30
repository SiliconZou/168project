//
//  TrainingListModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class TrainingListDataModel , TrainingListDataListModel ;

NS_ASSUME_NONNULL_BEGIN

@interface TrainingListModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) NSMutableArray <TrainingListDataModel *> * data;

@property (nonatomic,copy) NSString * data1;

//自定义属性
@property (nonatomic,assign) NSInteger correctCount;//正确题数
@property (nonatomic,assign) NSInteger allCount;//总题数
@property (nonatomic,assign) NSInteger finishCount;//已答题数
@property (nonatomic,copy) NSString *allTime;//总时间
@property (nonatomic,copy) NSString *useTime;//做题花费时间

@property (nonatomic,copy) NSString * from;
@property (nonatomic,copy) NSString * notdone_num;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString * subject;
@property (nonatomic,copy) NSString * correct_num;
@property (nonatomic,copy) NSString * all_num;

@end

@interface TrainingListDataModel : URCommonObject<NSCopying>

@property (nonatomic,copy) NSString * name;

@property (nonatomic,assign) BOOL isAnswered;//是否已经作答过

@property (nonatomic,strong) NSArray <TrainingListDataListModel *> * list;

//自定义属性
@property (nonatomic,assign) BOOL showSheet;//是否展开答题卡

@end

@interface TrainingListDataListModel : URCommonObject<NSCopying>

@property (nonatomic,copy) NSString * analysis;

@property (nonatomic,copy) NSString * answer;

@property (nonatomic,copy) NSString * collected;

@property (nonatomic,copy) NSString * difficulty;

@property (nonatomic,copy) NSString * error_count;

@property (nonatomic,copy) NSString * finished_count;

@property (nonatomic,copy) NSString * from;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * option1;

@property (nonatomic,copy) NSString * option2;

@property (nonatomic,copy) NSString * option3;

@property (nonatomic,copy) NSString * option4;

@property (nonatomic,copy) NSString * option5;

@property (nonatomic,copy) NSString * option6;

@property (nonatomic,copy) NSString * picture;

@property (nonatomic,copy) NSString * publicStr;

@property (nonatomic,copy) NSString * question_type;

@property (nonatomic,copy) NSString * score;

@property (nonatomic,copy) NSString * stem;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * video;

@property (nonatomic,copy) NSString * year;

//自定义属性
@property (nonatomic,strong) NSMutableArray *options;//选项数组
@property (nonatomic,assign) BOOL showAnswerKeys;//是否显示答题解析
@property (nonatomic,assign) BOOL isAnswered;//是否已经作答过
@property (nonatomic,assign) NSString *wrong;//1正确 2错误
@property (nonatomic,copy) NSString *my_option;//我选择的答案

@end

NS_ASSUME_NONNULL_END
