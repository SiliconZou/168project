//
//  WrongTopicVC.h
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WrongTopicVC : URBasicViewController

/**
 一级分类id
 */
@property (nonatomic,copy) NSString * primaryClassificationID;

/**
 二级分类id
 */
@property (nonatomic,copy) NSString * secondaryClassificationID;

@end

NS_ASSUME_NONNULL_END
