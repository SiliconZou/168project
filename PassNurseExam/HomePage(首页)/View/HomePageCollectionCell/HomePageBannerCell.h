//
//  HomePageBannerCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMPageControl : UIPageControl

@end

@interface HomePageBannerCell : UICollectionViewCell<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic,strong) HMPageControl *hmPage;

@property (nonatomic,strong) HomePageModel * homePageModel ;

@property (nonatomic,strong) UIViewController * currentViewController;

@end

NS_ASSUME_NONNULL_END
