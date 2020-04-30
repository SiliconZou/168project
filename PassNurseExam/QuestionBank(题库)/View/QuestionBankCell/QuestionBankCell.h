//
//  QuestionBankCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionBankCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *iconImg;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UILabel *subLb;
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong) QuestionClassCategoryDataModel *model;

@end

NS_ASSUME_NONNULL_END
