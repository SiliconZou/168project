//
//  UnitPracticeDetailProgressCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionProgressView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UnitPracticeDetailProgressCell : UITableViewCell


@property (nonatomic,strong) UIView *progressBgView;
@property (nonatomic,strong) UILabel *questionBankTitleLb;
@property (nonatomic,strong) QuestionProgressView *progressView;
@property (nonatomic,strong) UILabel *progressLb;

@end

NS_ASSUME_NONNULL_END
