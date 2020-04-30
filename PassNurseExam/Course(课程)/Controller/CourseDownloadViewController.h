//
//  CourseDownloadViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/19.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseDownloadViewController : URBasicViewController

@property (nonatomic,strong) CourseCommonDetailModel * detailModel ;
@property (nonatomic,copy) void (^backVideoPathBlock) (NSString *str);

@end

NS_ASSUME_NONNULL_END
