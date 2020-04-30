//
//  CourseBottomView.m
//  PassNurseExam
//
//  Created by qc on 2019/9/18.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseBottomView.h"

@implementation CourseBottomView

-(instancetype)init{
    if (self=[super init]) {
       
        self.backgroundColor = UR_ColorFromValue(0xffffff) ;
        
        [self  addSubview:self.priceLabel];
        [self.priceLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10) ;
            make.centerY.mas_equalTo(self) ;
            make.height.mas_equalTo(20) ;
        }];
         
        [self  addSubview:self.payButton];
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(100 * AUTO_WIDTH) ;
        }];
        
        [self  addSubview:self.courseCardButton];
        [self.courseCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(self.payButton.mas_left);
            make.width.mas_equalTo(100 * AUTO_WIDTH) ;
        }];
    }
    return self ;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel  alloc] init];
        _priceLabel.textColor = UR_ColorFromValue(0xFF773A);
        _priceLabel.font = BoldFont(16.0f) ;
    }
    return _priceLabel ;
}

-(UIButton *)courseCardButton{
    if (!_courseCardButton) {
        _courseCardButton = [[UIButton  alloc] init];
        [_courseCardButton  setTitle:@"课程卡激活" forState:UIControlStateNormal];
        _courseCardButton.backgroundColor = UR_ColorFromValue(0x9b87ff);
        _courseCardButton.tag =2 ;
        [_courseCardButton setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
        _courseCardButton.titleLabel.font = RegularFont(FontSize14);
        [[_courseCardButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            if (self.selectedButtonBlock) {
                self.selectedButtonBlock(x.tag) ;
            }
        }];
    }
    return _courseCardButton ;
}

-(UIButton *)payButton{
    if (!_payButton) {
        _payButton = [[UIButton  alloc] init];
        [_payButton  setTitle:@"在线支付" forState:UIControlStateNormal];
        _payButton.tag = 1 ;
        _payButton.backgroundColor = UR_ColorFromValue(0xffaf57);
        [_payButton setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
        _payButton.titleLabel.font = RegularFont(FontSize14);
        [[_payButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            if (self.selectedButtonBlock) {
                self.selectedButtonBlock(x.tag) ;
            }
        }];
    }
    return _payButton ;
}


@end
