//
//  AnswerSheetSingleQuestionDetailVC.h
//  PassNurseExam
//
//  Created by qc on 2019/9/30.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnswerSheetSingleQuestionDetailVC : URBasicViewController

@property (nonatomic,assign) NSInteger questionType;
@property (nonatomic,strong) UnitPracticeDetailDataModel * unitQuestionModel;

- (void)show;

@end

NS_ASSUME_NONNULL_END
