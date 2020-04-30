//
//  CourseDetailMenuCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/19.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailMenuCell : UITableViewCell

@property (nonatomic,strong) UIButton *catalogueBtn;//课程目录
@property (nonatomic,strong) UIButton *assortInfoBtn;//配套资料
@property (nonatomic,strong) UIButton *problemSolvingBtn;//问题解答
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,strong) RACSubject *selectItemSubject;

@end

NS_ASSUME_NONNULL_END
