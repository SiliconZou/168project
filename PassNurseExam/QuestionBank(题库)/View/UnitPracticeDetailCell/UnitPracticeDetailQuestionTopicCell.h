//
//  UnitPracticeDetailQuestionTopicCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/20.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnitPracticeDetailQuestionTopicCell : UITableViewCell

@property (nonatomic,strong) UILabel *topicLb;//题型
@property (nonatomic,strong) UILabel *answerRateLb;//ID，答题次数、效率

@end

NS_ASSUME_NONNULL_END
