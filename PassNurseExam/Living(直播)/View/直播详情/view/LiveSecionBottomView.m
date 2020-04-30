//
//  LiveSecionBottomView.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSecionBottomView.h"

@implementation LiveSecionBottomView

-(instancetype)init{
    if (self =[super init]) {
        
        self.subject = [RACSubject  subject] ;
        
        [self  addSubview:self.priceLabel];
        [self  addSubview:self.collectButton];
        [self  addSubview:self.shareButton];
        [self  addSubview:self.buyButton] ;
        
        [self.priceLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16 *AUTO_WIDTH) ;
            make.top.mas_equalTo(18 *AUTO_WIDTH);
            make.height.mas_equalTo(20 *AUTO_WIDTH) ;
        }];
        
        [self.buyButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0) ;
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(98 *AUTO_WIDTH, 49 *AUTO_WIDTH));
        }];
        
        [self.shareButton  mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(self.buyButton.mas_left).mas_offset(-20 *AUTO_WIDTH) ;
           make.top.mas_equalTo(5 *AUTO_WIDTH);
           make.size.mas_equalTo(CGSizeMake(40 *AUTO_WIDTH, 38 *AUTO_WIDTH));
        }];
        
        [self.collectButton  mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(self.shareButton.mas_left).mas_offset(-20 *AUTO_WIDTH) ;
           make.top.mas_equalTo(5 *AUTO_WIDTH);
           make.size.mas_equalTo(CGSizeMake(40 *AUTO_WIDTH, 38 *AUTO_WIDTH));
        }];
        
        [self.shareButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleTop imageTitleSpace:10 *AUTO_WIDTH];
        
        [self.collectButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleTop imageTitleSpace:10 *AUTO_WIDTH];
        
        [[self.collectButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.subject  sendNext:@(1)];
        }];
        
        [[self.shareButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.subject  sendNext:@(2)];
        }];
        
        [[self.buyButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.subject  sendNext:@(3)];
        }];
        
    }
    return self;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel  normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0xFF7A3E) font:RegularFont(FontSize21) textAlignment:NSTextAlignmentLeft numberLines:0] ;
    }
    return _priceLabel ;
}

-(UIButton *)collectButton{
    if (!_collectButton) {
        _collectButton = [UIButton   normalBtnWithTitle:@"收藏" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize14)];
        [_collectButton setImage:[UIImage  imageNamed:@"收藏"] forState:UIControlStateNormal];
    }
    return _collectButton ;
}

-(UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [UIButton   normalBtnWithTitle:@"分享" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize14)];
        [_shareButton setImage:[UIImage  imageNamed:@"分享-1"] forState:UIControlStateNormal];
    }
    return _shareButton ;
}

-(UIButton *)buyButton{
    if (!_buyButton) {
        _buyButton = [UIButton   normalBtnWithTitle:@"立即预约" titleColor:UR_ColorFromValue(0xFFFFFF) titleFont:RegularFont(FontSize14)];
        [_buyButton setBackgroundColor:UR_ColorFromValue(0xFFAF57)];
    }
    return _buyButton ;
}

@end
