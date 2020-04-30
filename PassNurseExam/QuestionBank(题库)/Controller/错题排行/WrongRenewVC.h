//
//  WrongRenewVC.h
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WrongRenewVC : URBasicViewController


/**
 1.错题排行  2.收藏题目
 */
@property (nonatomic,assign) NSInteger  type;

@property (nonatomic,strong) WrongRankingDataModel * dataModel;

@end

NS_ASSUME_NONNULL_END
