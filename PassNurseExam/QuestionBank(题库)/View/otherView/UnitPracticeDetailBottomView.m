//
//  UnitPracticeDetailBottomView.m
//  PassNurseExam
//
//  Created by qc on 2019/9/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeDetailBottomView.h"
#import "UIButton+EdgeInsets.h"


@implementation UnitPracticeDetailBottomView

-(instancetype)init{
    if (self=[super init]) {
        
        self.backgroundColor = UR_ColorFromValue(0x59A2FF) ;
        
        [self  setupUI] ;
    }
    
    return self;
}

-(void)setupUI{
    
    NSArray * array = @[
                        @[@"left",@"上一题"],
                        @[@"datiqia",@"答题卡"],
                        @[@"shoucang",@"收藏"],
                        @[@"fenxiang",@"分享"],
                        @[@"rightt",@"下一题"]
                        ];
    
    for (NSInteger i=0; i<array.count; i++) {
        
        UIButton * selectedButton = [UIButton  buttonWithType:UIButtonTypeCustom] ;
        [selectedButton  setImage:[UIImage  imageNamed:array[i][0]] forState:UIControlStateNormal];
        [selectedButton  setTitle:[NSString  stringWithFormat:@"%@",array[i][1]] forState:UIControlStateNormal];
        [selectedButton setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
        selectedButton.titleLabel.font = RegularFont(FontSize14) ;
       
        if (i==1) {
            self.sheetButton = selectedButton;
        }else if (i==2) {
            self.collectButton = selectedButton;
        }
        
        selectedButton.tag = i ;
        [self  addSubview:selectedButton];
        [selectedButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(URScreenWidth()/array.count *i) ;
            make.top.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(URScreenWidth()/array.count, 64 * AUTO_WIDTH));
        }];
        
        [[selectedButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            if (self.selectedButtonBlock) {
                self.selectedButtonBlock(x.tag) ;
            }
        }] ;
        
        [selectedButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleTop imageTitleSpace:10] ;
    }
}

@end
