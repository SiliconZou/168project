//
//  UnitAlertView.m
//  PassTheNurseExam
//
//  Created by 张旭 on 2017/10/25.
//  Copyright © 2017年 LeFu. All rights reserved.
//

#import "UnitAlertView.h"

@implementation UnitAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(50, URScreenHeight()/2 - 90, URScreenWidth() - 100, 175)];
    backView.backgroundColor = UR_ColorFromRGBA(0, 0, 0, 0.7);
    backView.layer.cornerRadius = 8;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    
    CGFloat vWidth = backView.frame.size.width;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(vWidth / 2 - 75, 40, 150, 20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"请选择出题方式";
    [backView addSubview:titleLabel];
    
    //顺序出题
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.frame = CGRectMake(vWidth/2 - 105, 105, 75, 30);
    [orderButton setTitle:@"顺序出题" forState:UIControlStateNormal];
    orderButton.titleLabel.font = [UIFont systemFontOfSize:14];
    orderButton.layer.cornerRadius = 5;
    orderButton.layer.masksToBounds = YES;
    orderButton.layer.borderWidth = 1;
    orderButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [orderButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    orderButton.tag = 1;
    [backView addSubview:orderButton];
    
    //随机出题
    UIButton *randomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    randomButton.frame = CGRectMake(vWidth/2 + 30, 105, 75, 30);
    [randomButton setTitle:@"随机出题" forState:UIControlStateNormal];
    randomButton.titleLabel.font = [UIFont systemFontOfSize:14];
    randomButton.layer.cornerRadius = 5;
    randomButton.layer.masksToBounds = YES;
    randomButton.layer.borderWidth = 1;
    randomButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [randomButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    randomButton.tag = 2;
    [backView addSubview:randomButton];
}

- (void)selectAction:(UIButton *)button{
    if (self.sSelectTypeBlock) {
        self.sSelectTypeBlock(button.tag);
    }
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

@end
