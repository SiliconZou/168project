//
//  AboutUSViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/30.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "AboutUSViewController.h"

@interface AboutUSViewController ()

@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"关于我们" ;
    
    UIImageView * iconImageView = [[UIImageView  alloc] initWithImage:[UIImage  imageNamed:@"1024"]];
    [self.view  addSubview:iconImageView];
    [iconImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80+URSafeAreaNavHeight());
        make.left.mas_equalTo((URScreenWidth()-120)/2) ;
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    UILabel * titleLabel = [[UILabel  alloc] init];
    titleLabel.text = @"168网校" ;
    titleLabel.font = BoldFont(FontSize22) ;
    titleLabel.textColor = UR_ColorFromValue(0x333333) ;
    titleLabel.textAlignment = NSTextAlignmentCenter ;
    [self.view  addSubview:titleLabel];
    [titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(iconImageView.mas_bottom).mas_offset(20) ;
        make.width.mas_equalTo(URScreenWidth());
    }];
    
    UILabel * contentLabel = [[UILabel  alloc] init];
    contentLabel.text = @"客服电话:029-88662211(周一到周五8:30-18:00)" ;
    contentLabel.numberOfLines = 0 ;
    contentLabel.font = RegularFont(FontSize15);
    contentLabel.textColor = UR_ColorFromValue(0x999999) ;
    contentLabel.textAlignment = NSTextAlignmentCenter ;
    [self.view  addSubview:contentLabel];
    [contentLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(20) ;
        make.width.mas_equalTo(URScreenWidth());
    }];
    
    UILabel * companyLabel = [[UILabel  alloc] init];
    companyLabel.text = @"陕西一六八网络科技有限公司" ;
    companyLabel.numberOfLines = 0 ;
    companyLabel.font = RegularFont(FontSize15);
    companyLabel.textColor = UR_ColorFromValue(0x999999) ;
    companyLabel.textAlignment = NSTextAlignmentCenter ;
    [self.view  addSubview:companyLabel];
    [companyLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.bottom.mas_equalTo(-30) ;
        make.width.mas_equalTo(URScreenWidth());
    }];
    
    UILabel * copyRightLabel = [[UILabel  alloc] init];
    copyRightLabel.text = @"Copyright@2013-2020" ;
    copyRightLabel.numberOfLines = 0 ;
    copyRightLabel.font = RegularFont(FontSize15);
    copyRightLabel.textColor = UR_ColorFromValue(0x666666) ;
    copyRightLabel.textAlignment = NSTextAlignmentCenter ;
    [self.view  addSubview:copyRightLabel];
    [copyRightLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.bottom.mas_equalTo(companyLabel.mas_top).mas_offset(-10) ;
        make.width.mas_equalTo(URScreenWidth());
    }];
    
}



@end
