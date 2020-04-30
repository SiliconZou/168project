//
//  FeedBackViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/30.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIImage+Utility.h"
@interface FeedBackViewController ()

@property (nonatomic,strong) EaseTextView * feedTextView;

@property (nonatomic,strong) NSMutableArray * imageArray;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"意见反馈" ;
    
    self.imageArray = [NSMutableArray  arrayWithCapacity:0] ;
    
    self.view.backgroundColor = UR_ColorFromValue(0xffffff);
    
    self.feedTextView = [EaseTextView new];
    self.feedTextView.textColor = UR_ColorFromValue(0x333333);
    self.feedTextView.font = RegularFont(FontSize15);
    self.feedTextView.placeHolder = @"请填写10个字以上的意见内容";
    [self.view  addSubview:self.feedTextView];
    [self.feedTextView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10) ;
        make.top.mas_equalTo(URSafeAreaNavHeight()+10) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-20, 200)) ;
    }];
    
    UIView * middleView = [[UIView  alloc] init];
    middleView.backgroundColor = UR_ColorFromValue(0xEEEEEE);
    [self.view  addSubview:middleView];
    [middleView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(self.feedTextView.mas_bottom).mas_offset(50) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 40));
    }];
    
    UILabel * picLabel = [[UILabel  alloc] init];
    picLabel.text = @"图片(选填)" ;
    picLabel.textColor = UR_ColorFromValue(0x666666) ;
    picLabel.font = RegularFont(FontSize14) ;
    [middleView  addSubview:picLabel];
    [picLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20) ;
        make.height.mas_equalTo(30) ;
        make.centerY.mas_equalTo(middleView) ;
    }];
    
    UILabel * countLabel = [[UILabel  alloc] init];
    countLabel.text = @"最多4张" ;
    countLabel.textColor = UR_ColorFromValue(0x666666) ;
    countLabel.font = RegularFont(FontSize14) ;
    countLabel.textAlignment = NSTextAlignmentRight ;
    [middleView  addSubview:countLabel];
    [countLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20) ;
        make.height.mas_equalTo(30) ;
        make.centerY.mas_equalTo(middleView) ;
    }];
    
    for (NSInteger i=0; i<4; i++) {
        
        UIButton * selectedButton = [UIButton  buttonWithType:UIButtonTypeCustom] ;
        [selectedButton  setImage:[UIImage  imageNamed:@"xiangji"] forState:UIControlStateNormal];
        selectedButton.layer.cornerRadius = 3.0f ;
        selectedButton.layer.masksToBounds = YES ;
        selectedButton.layer.borderWidth = 0.5f ;
        selectedButton.layer.borderColor = UR_ColorFromValue(0x666666).CGColor ;
        selectedButton.tag = i ;
        [[selectedButton  rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton * x) {
            
            [self  selectImageWithAllowsEditing:YES title:@"请选择要上传的图片" completeBlock:^(UIImage * imageName) {
                UIImage *compressImage = [UIImage ur_imageCompression:imageName];
                [selectedButton  setImage:compressImage forState:UIControlStateNormal];
                
                [[URCommonApiManager  sharedInstance] sendUploadImageRequestWithFile:compressImage requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                    
                    [self.imageArray  insertObject:[NSString  stringWithFormat:@"%@",responseDict[@"data"]?:@""] atIndex:x.tag];
                    
                } requestFailureBlock:^(NSError *error, id response) {
                    
                }];
                
            }] ;
            
        }];
        [self.view  addSubview:selectedButton];
        [selectedButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10*(i+1)+(URScreenWidth()-50)/4 *i) ;
            make.top.mas_equalTo(middleView.mas_bottom).mas_equalTo(20) ;
            make.size.mas_equalTo(CGSizeMake((URScreenWidth()-50)/4, (URScreenWidth()-50)/4));
        }];
    }
    
    UIButton * submitButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
    submitButton.titleLabel.font = RegularFont(FontSize15) ;
    [submitButton setBackgroundColor:NORMAL_COLOR];
    submitButton.layer.cornerRadius = 20.0f ;
    submitButton.layer.masksToBounds = YES ;
    [self.view  addSubview:submitButton];
    [submitButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20) ;
        make.top.mas_equalTo(middleView.mas_bottom).mas_offset((URScreenWidth()-50)/4+100) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-40, 40));
    }];

    @weakify(self);
    [[submitButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self) ;
        if (self.feedTextView.text.length<10) {
            [URToastHelper   showErrorWithStatus:@"请输入大于10个字符"] ;
        } else {
            NSData *data ;
            NSString * string ;
            if (self.imageArray.count>0) {
                data =  [NSJSONSerialization dataWithJSONObject:self.imageArray
                                                         options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                           error:nil];
                
                string = [[NSString alloc] initWithData:data
                                                         encoding:NSUTF8StringEncoding];
            }
            
            [[URCommonApiManager  sharedInstance] sendUserFeedBackRequestWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" content:self.feedTextView.text images:string?:@"" imageCount:self.imageArray.count requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                [URToastHelper  showErrorWithStatus:[NSString  stringWithFormat:@"%@",responseDict[@"msg"]]] ;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            } requestFailureBlock:^(NSError *error, id response) {
                
            }] ;
        }
    }];
}



@end
