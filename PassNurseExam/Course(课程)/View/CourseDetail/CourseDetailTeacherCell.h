//
//  CourseDetailTeacherCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailTeacherCell : UITableViewCell

@property (nonatomic,strong) UILabel *teacherNameLb;
@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UILabel *teacherContentLb; 
@property (nonatomic,strong) UIImageView *teacherLogo;

@property (nonatomic,strong) CourseCommonDetailDataModel * dataModel ;
@property (nonatomic,strong) BaseCourseModel * dataModel1 ;

@end

NS_ASSUME_NONNULL_END
