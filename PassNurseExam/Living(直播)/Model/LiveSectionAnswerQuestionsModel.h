//
//  LiveSectionAnswerQuestionsModel.h
//  PassNurseExam
//
//  Created by quchao on 2019/11/19.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class LiveSectionAnswerQuestionsFromModel ;

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionAnswerQuestionsModel : URCommonObject

@property (nonatomic,copy) NSString * from_type;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * thumbnail ;

@property (nonatomic,copy) NSString * username;

@property (nonatomic,copy) NSString * content;

@property (nonatomic,copy) NSString * time;

@property (nonatomic,strong) LiveSectionAnswerQuestionsFromModel * from;

@end

@interface LiveSectionAnswerQuestionsFromModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * section;

@property (nonatomic,copy) NSString * title ;

@property (nonatomic,copy) NSString * type ;

@property (nonatomic,copy) NSString * picture;

@property (nonatomic,copy) NSString * option1;

@property (nonatomic,copy) NSString * option2;

@property (nonatomic,copy) NSString * option3;

@property (nonatomic,copy) NSString * option4;

@property (nonatomic,copy) NSString * option5;

@property (nonatomic,copy) NSString * option6 ;

@property (nonatomic,copy) NSString * answer ;

@property (nonatomic,copy) NSString * is_sel;

@property (nonatomic,copy) NSString * sel_time;

@property (nonatomic,copy) NSString * sel1;

@property (nonatomic,copy) NSString * sel2;

@property (nonatomic,copy) NSString * sel3 ;

@property (nonatomic,copy) NSString * sel4;

@property (nonatomic,copy) NSString * sel5;

@property (nonatomic,copy) NSString * sel6;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * updated_at;

//自定义属性
@property (nonatomic,strong) NSMutableArray *options;//选项数组 


@end

NS_ASSUME_NONNULL_END
