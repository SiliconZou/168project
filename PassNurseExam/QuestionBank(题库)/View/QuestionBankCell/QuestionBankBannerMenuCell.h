//
//  QuestionBankBannerMenuCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionBankBannerMenuCell : UICollectionViewCell<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic,strong) CourseHomeMenuView *menu;
@property (nonatomic,strong) NSArray * bannerArray;

@end

NS_ASSUME_NONNULL_END
