//
//  CourseDetailSubCatalogueCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailSubCatalogueCell : UITableViewCell

@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UILabel *priceLb;
@property (nonatomic,strong) UIButton *lockBtn;
@property (nonatomic,strong) UIButton *downloadBtn;

@property (nonatomic,strong) CourseCommonDetailDataCurriculumsModel * curriculumsModel;

@end

NS_ASSUME_NONNULL_END
