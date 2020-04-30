//
//  CourseListTableViewCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface CourseListTableViewCell : UITableViewCell

@property (nonatomic,strong) BaseCourseModel *courseModel;

@property (nonatomic,strong) UIViewController * currentViewController;

@end

NS_ASSUME_NONNULL_END
