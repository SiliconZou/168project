//
//  UnitPracticeDetailModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class UnitPracticeDetailDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface UnitPracticeDetailModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString *msg;

@property (nonatomic,strong) NSArray<UnitPracticeDetailDataModel *> * data;

@end

@interface UnitPracticeDetailDataModel : URCommonObject

@property (nonatomic,copy) NSString * analysis;//答题解析

@property (nonatomic,copy) NSString * answer;//答案

@property (nonatomic,copy) NSString * collected;//已收藏，0未收藏，1已收藏

@property (nonatomic,copy) NSString * difficulty;//难度系数

@property (nonatomic,copy) NSString * error_count;//错误次数

@property (nonatomic,copy) NSString * finished_count;//已做次数

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * option1;

@property (nonatomic,copy) NSString * option2;

@property (nonatomic,copy) NSString * option3;

@property (nonatomic,copy) NSString * option4;

@property (nonatomic,copy) NSString * option5;

@property (nonatomic,copy) NSString * option6;

@property (nonatomic,copy) NSString * picture;

@property (nonatomic,copy) NSString * question_type;//题型A1...

@property (nonatomic,copy) NSString * score;

@property (nonatomic,copy) NSString * title;//题目

@property (nonatomic,copy) NSString * type;//1单选题2多选题3判断题***

@property (nonatomic,copy) NSString * video;

//自定义属性

@property (nonatomic,assign) BOOL showAnswerKeys;//是否显示答题解析
@property (nonatomic,assign) BOOL isAnswered;//是否已经作答过
@property (nonatomic,assign) NSString *wrong;//1正确 2错误
@property (nonatomic,strong) NSMutableArray *options;//选项数组

@end

@interface OptionsModel : NSObject<NSCopying>

@property (nonatomic,copy) NSString *optionName;
@property (nonatomic,assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
