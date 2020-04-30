//
//  CourseDetailTopInfoCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailTopInfoCell : UITableViewCell 

@property (nonatomic,strong) UIImageView *videoPlaceHolderImg;//占位图
@property (nonatomic,strong) UIButton *playBtn;//播放按钮

@property (nonatomic,strong) UILabel *courseNameLb;
@property (nonatomic,strong) UILabel *coursePriceLb;
@property (nonatomic,strong) UILabel *studyNumLb;//学习人数
@property (nonatomic,strong) UIButton *downloadBtn;
@property (nonatomic,strong) UIButton *collectBtn;//收藏按钮
@property (nonatomic,strong) UIButton *shareBtn;//分享按钮

@property (nonatomic,strong) BaseCourseModel *model;
@property (nonatomic,strong) CourseCommonDetailDataModel *chapterModel;//章节
@property (nonatomic,strong) CourseCommonDetailDataCurriculumsModel *curriculumsModel;//课件

@end

NS_ASSUME_NONNULL_END
