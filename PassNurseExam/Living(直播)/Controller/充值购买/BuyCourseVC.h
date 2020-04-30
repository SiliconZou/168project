//
//  BuyCourseVC.h
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BuyCourseVC : URBasicViewController

@property (nonatomic,strong)  id dataModel;

//购买类型：1 购买视频  2 购买课程
@property (nonatomic,assign) NSInteger buyType;

@end

NS_ASSUME_NONNULL_END
