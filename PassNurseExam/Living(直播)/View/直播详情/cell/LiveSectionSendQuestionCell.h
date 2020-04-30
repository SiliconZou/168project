//
//  LiveSectionSendQuestionCell.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/23.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionSendQuestionCell : UITableViewCell

@property (nonatomic,strong) UIImageView *imgV;
@property (nonatomic,strong) UILabel *questionLb;//题目
@property (nonatomic,strong) NSMutableArray *answerArr;//答案数组
@property (nonatomic,strong) UILabel *tipLb;//状态提示
@property (nonatomic,strong) UIButton *sendBtn;//发送按钮

-(void)setAllQuestionsDataModel:(LiveSectionAllQuestionsDataModel *)dataModel  index:(NSString *)index ;


@end

NS_ASSUME_NONNULL_END
