//
//  ImgVideoQuestionBankVC.h
//  PassNurseExam
//
//  Created by qc on 2019/9/20.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImgVideoQuestionBankVC : URBasicViewController

/**
 1.图片 2.视频
 */
@property (nonatomic,copy) NSString * type ;

@property (nonatomic,copy) NSString * subjectID;


@end

NS_ASSUME_NONNULL_END
