//
//  HomePageHeadlineCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageHeadlineCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *logo;
@property (nonatomic,strong) UIImageView *dian1;
@property (nonatomic,strong) UIImageView *dian2;

/**
 数据数组
 */
@property (nonatomic,strong) NSArray<HomePageCourseTitleBannerModel *> * dataArray;

@property (nonatomic,strong) UIViewController * currentViewController;

@end

NS_ASSUME_NONNULL_END
