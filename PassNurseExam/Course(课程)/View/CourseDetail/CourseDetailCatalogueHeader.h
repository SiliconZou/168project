//
//  CourseDetailCatalogueHeader.h
//  PassNurseExam
//
//  Created by qc on 2019/9/19.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailCatalogueHeader : UIView

@property (nonatomic,strong) UILabel *noLb;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UIButton *selectBtn;

@property (nonatomic,strong) CourseCommonDetailDataModel * dataModel;

@end

NS_ASSUME_NONNULL_END
