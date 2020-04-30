//
//  CourseBottomView.h
//  PassNurseExam
//
//  Created by qc on 2019/9/18.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseBottomView : UIView

@property (nonatomic,strong) UILabel * priceLabel;

@property (nonatomic,strong) UIButton * courseCardButton;

@property (nonatomic,strong) UIButton * payButton;

@property (nonatomic,copy) void (^selectedButtonBlock)(NSInteger  tag);

@end

NS_ASSUME_NONNULL_END
