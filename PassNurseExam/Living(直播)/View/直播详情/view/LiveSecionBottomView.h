//
//  LiveSecionBottomView.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveSecionBottomView : UIView

@property (nonatomic,strong) RACSubject *  subject;

@property (nonatomic,strong) UILabel * priceLabel;

@property (nonatomic,strong) UIButton * shareButton;

@property (nonatomic,strong) UIButton * collectButton;

@property (nonatomic,strong) UIButton * buyButton;



@end

NS_ASSUME_NONNULL_END
