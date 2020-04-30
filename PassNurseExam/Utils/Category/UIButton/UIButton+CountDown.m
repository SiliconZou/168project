//
//  UIButton+CountDown.m
//  PassNurseExam
//
//  Created by qc on 2018/11/9.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "UIButton+CountDown.h"
#import <pop/POP.h>
#import "URColorHeader.h"

static NSInteger remainTime;

@implementation UIButton (CountDown)

-(void)countDown:(NSInteger)time button:(UIButton *)button{
    __block NSInteger timeout = time;
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:[NSString stringWithFormat:@"countDown-%ld",(long)time] initializer:^(POPMutableAnimatableProperty *prop) {
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            UIButton *button = (UIButton *)obj;
            remainTime = (NSInteger)values[0];
            NSAttributedString *sString = [[NSAttributedString alloc] initWithString:@"S" attributes:@{NSForegroundColorAttributeName:UR_ContDownTime_Color}];
            if (remainTime > 0) {
                button.enabled = NO;
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%2ld",(long)remainTime] attributes:@{NSForegroundColorAttributeName:UR_ContDownTime_Color}];
                [string appendAttributedString:sString];
                [button setAttributedTitle:string forState:UIControlStateDisabled];
            } else if (remainTime == 0){
                NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"获取验证码" attributes:@{NSForegroundColorAttributeName:UR_ColorFromValue(0xffffff)}];
                [button setAttributedTitle:attributeString forState:UIControlStateNormal];
                button.enabled = YES;
            }
        };
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];
    anBasic.property = prop;
    anBasic.fromValue = @(timeout);
    anBasic.toValue = @(0);
    anBasic.duration = 60;
    anBasic.beginTime = CACurrentMediaTime();
    [button pop_addAnimation:anBasic forKey:[NSString stringWithFormat:@"countDown-%ld",(long)time]];
}

@end
