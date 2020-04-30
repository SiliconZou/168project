//
//  CourseTeacherInfoCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseTeacherInfoCell : UITableViewCell

@property (nonatomic,strong) UIImageView *bgImg;
@property (nonatomic,strong) UIImageView *header;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UIButton *flowersBtn;// 花
@property (nonatomic,strong) UIButton *praiseBtn;//赞

@property (nonatomic,strong) UILabel *introTitleLb;//讲师简介
@property (nonatomic,strong) UILabel *introLb;//简介内容

@property (nonatomic,strong) UILabel *courseTitleLb;//讲师课程

@property (nonatomic,copy) void(^selectedButtonBlock)(NSInteger tag);

@property (nonatomic,strong) CourseTeacherInforDataModel * dataModel;

@end

NS_ASSUME_NONNULL_END
