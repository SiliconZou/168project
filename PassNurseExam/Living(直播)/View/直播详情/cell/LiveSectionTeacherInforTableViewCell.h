//
//  LiveSectionTeacherInforTableViewCell.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionTeacherInforTableViewCell : UITableViewCell

@property (nonatomic,strong) LiveSectionDetailDataModel * detailModel;

@property (nonatomic,strong) UILabel * teacherNameLabel;

@property (nonatomic,strong) UILabel * teacherIntroLabel;

@property (nonatomic,strong) UIButton * expandContractionButton;



@end

NS_ASSUME_NONNULL_END
