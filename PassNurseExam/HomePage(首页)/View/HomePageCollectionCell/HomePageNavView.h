//
//  HomePageNavView.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageNavView : UIView

@property (nonatomic,copy) void(^selectedButtonBlock)(NSInteger  tag);

@property (nonatomic,strong) UIButton *channelBtn;//频道切换按钮
@property (nonatomic,strong) UIButton *searchBtn;
@property (nonatomic,strong) UIButton *scanBtn;
@property (nonatomic,strong) UIButton *addBtn;

@end

NS_ASSUME_NONNULL_END
