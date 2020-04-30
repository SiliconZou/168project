//
//  LiveSectionCatalogHeader.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionCatalogHeader : UIView

@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UIButton *selectBtn;

@property (nonatomic,strong) LiveSectionDetailData1Model *model;

@end

NS_ASSUME_NONNULL_END
