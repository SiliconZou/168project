//
//  HomePageNavView.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomePageNavView.h"

@interface HomePageNavView ()

@end

@implementation HomePageNavView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self addSubview:self.channelBtn];
    [self addSubview:self.searchBtn];
    [self addSubview:self.scanBtn];
    [self addSubview:self.addBtn];
    
//    self.scanBtn.hidden = YES;
    self.scanBtn.hidden = is_online == 0 ? YES : NO;
    [self.channelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15 * AUTO_WIDTH);
        make.top.mas_offset(URSafeAreaStateHeight());
        make.width.mas_equalTo(70 * AUTO_WIDTH);
    }];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(90 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.channelBtn);
        make.size.mas_equalTo(CGSizeMake(190 * AUTO_WIDTH, 32 * AUTO_WIDTH));
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.channelBtn);
        make.size.mas_equalTo(CGSizeMake(24 * AUTO_WIDTH, 24 * AUTO_WIDTH));
    }];
    [self.scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.addBtn.mas_left).offset(-15 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.channelBtn);
        make.size.mas_equalTo(CGSizeMake(24 * AUTO_WIDTH, 24 * AUTO_WIDTH));
    }];
}

- (UIButton *)channelBtn
{
    if (!_channelBtn) {
        _channelBtn = [UIButton ImgBtnWithImageName:@"logo"];
//        _channelBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _channelBtn.tag = 1 ;
        [[_channelBtn   rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            if (self.selectedButtonBlock) {
                self.selectedButtonBlock(x.tag) ;
            }
        }];
    }
    return _channelBtn;
}

- (UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton normalBtnWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) titleFont:Font(FontSize14)];
        _searchBtn.layer.cornerRadius = 16 * AUTO_WIDTH;
        _searchBtn.layer.masksToBounds = YES;
        [_searchBtn setBackgroundImage:[UIImage  imageNamed:@"searchBj"] forState:UIControlStateNormal];
        _searchBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        _searchBtn.tag = 2 ;
        [[_searchBtn   rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            if (self.selectedButtonBlock) {
                self.selectedButtonBlock(x.tag) ;
            }
        }];
    }
    return _searchBtn;
}

- (UIButton *)scanBtn
{
    if (!_scanBtn) {
        _scanBtn = [UIButton ImgBtnWithImageName:@"二维码"];
        _scanBtn.tag = 3 ;
        [[_scanBtn   rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            if (self.selectedButtonBlock) {
                self.selectedButtonBlock(x.tag) ;
            }
        }];
    }
    return _scanBtn;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton ImgBtnWithImageName:@"support"];
        _addBtn.tag = 4 ;
        [[_addBtn   rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            if (self.selectedButtonBlock) {
                self.selectedButtonBlock(x.tag) ;
            }
        }];
    }
    return _addBtn;
}

@end
