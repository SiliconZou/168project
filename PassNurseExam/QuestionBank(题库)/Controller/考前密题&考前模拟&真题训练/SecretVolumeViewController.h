//
//  SecretVolumeViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecretVolumeViewController : URBasicViewController

@property (nonatomic,copy) NSString * subjectID;
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
