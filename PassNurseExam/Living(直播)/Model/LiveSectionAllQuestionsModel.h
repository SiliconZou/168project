//
//  LiveSectionAllQuestionsModel.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class LiveSectionAllQuestionsDataModel ;

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionAllQuestionsModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) NSArray <LiveSectionAllQuestionsDataModel *> * data;

@end


@interface LiveSectionAllQuestionsDataModel : URCommonObject

@property (nonatomic,copy) NSString * answer;

@property (nonatomic,copy) NSString * created_at;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * is_sel;

@property (nonatomic,copy) NSString * option1;

@property (nonatomic,copy) NSString * option2;

@property (nonatomic,copy) NSString * option3;

@property (nonatomic,copy) NSString * option4;

@property (nonatomic,copy) NSString * option5;

@property (nonatomic,copy) NSString * option6;

@property (nonatomic,copy) NSString * picture;

@property (nonatomic,copy) NSString * section;

@property (nonatomic,copy) NSString * sel1;

@property (nonatomic,copy) NSString * sel2;

@property (nonatomic,copy) NSString * sel3;

@property (nonatomic,copy) NSString * sel4;

@property (nonatomic,copy) NSString * sel5;

@property (nonatomic,copy) NSString * sel6;

@property (nonatomic,copy) NSString * sel_time;

@property (nonatomic,copy) NSString * title ;

@property (nonatomic,copy) NSString * updated_at ;

 
@end

NS_ASSUME_NONNULL_END
