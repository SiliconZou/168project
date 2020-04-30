//
//  UserCardActiveViewController.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/8.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserCardActiveViewController.h"

@interface UserCardActiveViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView * cycleScrollView;

@end

@implementation UserCardActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cViewNav.hidden = YES ;
        
    UIButton * backButton = [UIButton  buttonWithType:UIButtonTypeCustom] ;
    [backButton setImage:[UIImage  imageNamed:@"返回"] forState:UIControlStateNormal];
    @weakify(self) ;
    [[backButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self) ;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view  addSubview:backButton];
    [backButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20) ;
        make.top.mas_equalTo(40 *AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake(61, 28));
    }];
    
    [self.view  addSubview:self.cycleScrollView];
    if (self.model.data.imgs.count>0) {
        self.cycleScrollView.imageURLStringsGroup = self.model.data.imgs ;
    }
    [self.cycleScrollView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AUTO_WIDTH);
        make.top.mas_equalTo(100*AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-30*AUTO_WIDTH, 180*AUTO_WIDTH));
    }];
    
    UIImageView *resultImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanResult"]];
    [self.view addSubview:resultImgView];
    [resultImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-40, 160 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(60 * AUTO_WIDTH);
    }];
    
    NSArray *textArr1 = @[@"类型：",@"状态：",@"名称：",@"有效期："];
    for (int i = 0; i < 4; i++)
    {
        UILabel *lb1 = [UILabel normalLabelWithTitle:textArr1[i] titleColor:[UIColor whiteColor] font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
        
        UILabel *lb2 = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];

        [self.view addSubview:lb1];
        [self.view addSubview:lb2];
        
        [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(resultImgView).offset(15 * AUTO_WIDTH);
            make.height.mas_equalTo(40 * AUTO_WIDTH);
            make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(60 * AUTO_WIDTH + 40 * AUTO_WIDTH * i);
        }];
        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(resultImgView).offset(100 * AUTO_WIDTH);
            make.height.mas_equalTo(lb1);
            make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(60 * AUTO_WIDTH + 40 * AUTO_WIDTH * i);
        }];
        
        if (i==0) {
            lb2.text = [NSString  stringWithFormat:@"%@",self.model.data.type?:@""] ;
        } else if (i==1){
            lb2.text = [NSString  stringWithFormat:@"%@",self.model.data.state?:@""] ;
        } else if (i==2){
            lb2.text = [NSString  stringWithFormat:@"%@",self.model.data.name?:@""] ;
        } else if (i==3){
            lb2.text = [NSString  stringWithFormat:@"%@",self.model.data.deadline?:@""] ;
        }
    }
    
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"scanBg"].CGImage;
    
    
    UIButton * activationButton = [[UIButton  alloc] init];
    [activationButton setImage:[UIImage  imageNamed:@"立即激活"] forState:UIControlStateNormal];
    [[activationButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [URAlert  alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"是否确认激活" cancelButtonTitle:@"取消" sureButtonTitles:@"确定" viewController:self handler:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                [[URCommonApiManager  sharedInstance] sendActiveCardRequestWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" code:[NSString  stringWithFormat:@"%@",self.model.data.code?:@""] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
                } requestFailureBlock:^(NSError *error, id response) {
            
                }];

            }
        }];
        
    }];
    [self.view  addSubview:activationButton];
    [activationButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(530 *AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-30 *AUTO_WIDTH, 44));
        make.left.mas_equalTo(15 *AUTO_WIDTH) ;
    }];
    

}


-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _cycleScrollView.autoScrollTimeInterval = 4;
        _cycleScrollView.layer.cornerRadius = 6;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.showPageControl = YES;
        
    }
    return _cycleScrollView;
}


@end
