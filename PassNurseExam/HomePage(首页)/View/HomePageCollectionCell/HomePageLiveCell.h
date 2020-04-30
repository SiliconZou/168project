//
//  HomePageLiveCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageLiveCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *header;
@property (nonatomic,strong) UIButton *time;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *liveNameLb;
@property (nonatomic,strong) UILabel *orderNumLb;//预约人数
@property (nonatomic,strong) UIButton *orderBtn;//预约按钮

@end

NS_ASSUME_NONNULL_END
