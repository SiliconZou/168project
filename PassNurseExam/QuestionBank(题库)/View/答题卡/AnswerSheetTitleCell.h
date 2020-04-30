//
//  AnswerSheetTitleCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/29.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnswerSheetTitleCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *iconImg;
@property (nonatomic,strong) UILabel *titleLb;

@property (nonatomic,strong) UIView *trueTag;
@property (nonatomic,strong) UILabel *trueTagLb;

@property (nonatomic,strong) UIView *errorTag;
@property (nonatomic,strong) UILabel *errorTagLb;

@property (nonatomic,strong) UIView *unAnswerdTag;
@property (nonatomic,strong) UILabel *unAnswerdTagLb;


@end

NS_ASSUME_NONNULL_END
