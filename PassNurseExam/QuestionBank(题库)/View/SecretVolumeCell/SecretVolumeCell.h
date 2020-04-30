//
//  SecretVolumeCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/29.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecretVolumeCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UILabel *typeLb;
@property (nonatomic,strong) UILabel *countLb;
@property (nonatomic,strong) UILabel *timeLb;

@end

NS_ASSUME_NONNULL_END
