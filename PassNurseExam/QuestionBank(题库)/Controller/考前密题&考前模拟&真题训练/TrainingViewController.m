//
//  TrainingViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "TrainingViewController.h"
#import "TrainingListViewController.h"
#import "SecretVolumeViewController.h"
#import "PopoverView.h"

@interface TrainingViewController ()

@property (nonatomic ,strong) UIView * bgView ;
@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UILabel *examInfoLb;
@property (nonatomic,strong) UIImageView *barCodeImg;
@property (nonatomic,strong) UIImageView *headerImg;
@property (nonatomic,strong) UIImageView *studyUpImg;
@property (nonatomic,strong) UIImageView *downImg;
@property (nonatomic,strong) UILabel *timeTileLb;
@property (nonatomic,strong) UILabel *timeValueLb;
@property (nonatomic,strong) UILabel *subjectTitleLb;
@property (nonatomic,strong) UILabel *yearTitleLb;
@property (nonatomic,strong) UIButton *selectYearBtn;
@property (nonatomic,strong) UIButton *subjectValueBtn;
@property (nonatomic,strong) UIButton *examButton;


@end

@implementation TrainingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    if (self.testType == TestType_Simulation)
    {
        self.lblTitle.text = @"考前模拟" ;
        [self.yearTitleLb setHidden:YES];
        [self.selectYearBtn setHidden:YES];
    }
    else if (self.testType == TestType_Original)
    {
        self.lblTitle.text = @"每日真题" ;
    }
    else if (self.testType == TestType_Secret)
    {
        self.lblTitle.text = @"考前密题" ;
    }
    
    NSString *str= [NSString stringWithFormat:@"%@%@\n考生准考证",self.examName,self.lblTitle.text];
    self.titleLb.attributedText = [NSMutableAttributedString ur_changeFontAndColor:BoldFont(FontSize22) Color:UR_ColorFromValue(0x333333) TotalString:str SubStringArray:@[@"考生准考证"]];

    NSString *infoStr = [NSString stringWithFormat:@"准考证号:%@\n考生姓名:用户%@\n考试场地:护考通平台",[URUserDefaults standardUserDefaults].userInforModel.phone,[[URUserDefaults standardUserDefaults].userInforModel.phone substringFromIndex:7]];
    self.examInfoLb.attributedText = [NSMutableAttributedString ur_changeLineSpaceWithTotalString:infoStr lineSpace:5];
    
    //选择科目
    if (self.testType == TestType_Secret)
    {
        self.subjectValueBtn.enabled = NO;
        [self.subjectValueBtn setTitle:self.subjectsStr forState:UIControlStateNormal];
        [self.subjectValueBtn setTitleColor:UR_ColorFromValue(0x333333) forState:UIControlStateNormal];
    }else
    {
        [[self.selectYearBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            PopoverView *popoverView = [PopoverView popoverView];
            popoverView.showShade = YES;
            popoverView.automaticArrowDirection = NO;
            popoverView.isUpward = YES;
            NSMutableArray *actionArr = [[NSMutableArray alloc] init];
            for (NSNumber *year in self.yearArr) {
                PopoverAction *action = [PopoverAction actionWithTitle:[NSString stringWithFormat:@"%@",year] handler:^(PopoverAction *action) {
                    [x setTitle:[NSString stringWithFormat:@"%@",year] forState:UIControlStateNormal];
                    [x setTitleColor:UR_ColorFromValue(0x333333) forState:UIControlStateNormal];
                    self.yearStr = [NSString stringWithFormat:@"%@",year];
                }];
                [actionArr addObject:action];
            }
            CGPoint point = CGPointMake(self.selectYearBtn.left + self.selectYearBtn.mj_w/2.0, self.selectYearBtn.mj_y + self.selectYearBtn.mj_h);
            
            [popoverView showToPoint:point withActions:actionArr];
        }];
        [[self.subjectValueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            
            //菜单弹框
            PopoverView *popoverView = [PopoverView popoverView];
            popoverView.showShade = YES;
            popoverView.automaticArrowDirection = NO;//取消自动朝向
            popoverView.isUpward = YES;//设置箭头朝向，向上
            NSMutableArray *actionArr = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in self.subjectArr) {
                PopoverAction *action1 = [PopoverAction actionWithTitle:dic[@"name"] handler:^(PopoverAction *action) {
                    
                    [x setTitle:dic[@"name"] forState:UIControlStateNormal];
                    [x setTitleColor:UR_ColorFromValue(0x333333) forState:UIControlStateNormal];
                    
                    self.subjectsStr = dic[@"name"] ;
                    self.keMuId = [dic[@"pivot"][@"kemu_id"] stringValue];
                }];
                
                [actionArr addObject:action1];
            }
            /*
            PopoverAction *action1 = [PopoverAction actionWithTitle:@"专业实务" handler:^(PopoverAction *action) {
                
                [x setTitle:@"专业实务" forState:UIControlStateNormal];
                [x setTitleColor:UR_ColorFromValue(0x333333) forState:UIControlStateNormal];
                
                self.subjectsStr = @"专业实务" ;
            }];
            
            PopoverAction *action2 = [PopoverAction actionWithTitle:@"实践能力" handler:^(PopoverAction *action) {
                
                [x setTitle:@"实践能力" forState:UIControlStateNormal];
                [x setTitleColor:UR_ColorFromValue(0x333333) forState:UIControlStateNormal];
                
                self.subjectsStr = @"实践能力" ;
            }];
            */
            
            CGPoint point = CGPointMake(self.subjectValueBtn.left + self.subjectValueBtn.mj_w/2.0, self.subjectValueBtn.mj_y + self.subjectValueBtn.mj_h + URSafeAreaNavHeight() + 43*AUTO_WIDTH);
            
            [popoverView showToPoint:point withActions:actionArr];
        }];
    }
    
    
    [[self.examButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        if ([NSString  isBlank:self.subjectsStr] || [NSString isBlank:self.yearStr])
        {
            [URToastHelper  showErrorWithStatus:@"请选择科目或试卷年份"] ;
        } else
        {
            if (self.testType == TestType_Simulation && [URUserDefaults standardUserDefaults].userInforModel.is_vip.integerValue==0)
            {
                // 考前模拟 && 不是会员
                [self isNotVip];
            }
            else//已经是会员
            {
                [self pushTrainingList];
            }
        }
    }];
    
    [[URCommonApiManager sharedInstance] getExamSubjectDataWithSubjectID:self.secondaryClassificationID?:@"" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        self.keMuDict = responseDict[@"data"];
        self.subjectArr = self.keMuDict[@"kemu"];
        self.yearArr = responseDict[@"data1"];
        self.timeValueLb.text = [NSString stringWithFormat:@"%@分钟",[responseDict[@"data"][@"times"] stringValue]];
    } requestFailureBlock:^(NSError *error, id response) {
    }];
}

- (void)pushTrainingList
{
    TrainingListViewController * listViewController = [[TrainingListViewController alloc] init];
    
    listViewController.subjectID = self.secondaryClassificationID?:@"" ;
    
//    if ([self.subjectsStr  isEqualToString:@"专业实务"]) {
//        listViewController.categoryID = @"1";
//    } else {
//        listViewController.categoryID = @"2";
//    }
    listViewController.categoryID = self.keMuId;
    listViewController.secondTitleStr = self.subjectsStr;
    listViewController.examTime = self.timeValueLb.text;
    listViewController.yearStr = self.yearStr?:@"";
    if (self.testType == TestType_Simulation) {
        listViewController.subTitleStr = @"考前模拟";
    } else if (self.testType == TestType_Original) {
        listViewController.subTitleStr = @"真题训练";
    } else if (self.testType == TestType_Secret) {
        listViewController.subTitleStr = @"考前密题";
        listViewController.secretVolume = self.secretVolume;
    }
    listViewController.testType = self.testType ;
    
    [self.navigationController pushViewController:listViewController animated:YES];
}

- (void)isNotVip
{
    // 非会员剩余次数
    [[URCommonApiManager  sharedInstance] getSimulationQuestionDataWithChooseType:self.testType subjectID:self.secondaryClassificationID?:@"" categoryID:self.keMuId token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" year:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        TrainingListModel * listModel = response ;
        
        if (listModel.data1.integerValue > 6)
        {
            [URAlert  alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"非会员用户可以体验6次,你使用完次数,开通会员无限制畅快学习!" cancelButtonTitle:@"返回上级" sureButtonTitles:@"开通会员" viewController:self handler:^(NSInteger buttonIndex) {
                
                if (buttonIndex==0)
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else //开通会员
                {
                    [self alertUserVipRight];
                }
            }] ;
            
        } else
        {
            //目前缺少弹框
            [self pushTrainingList];
        }
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)createUI
{
    self.view.backgroundColor = UR_ColorFromValue(0xf3f3f3);
    
    [self.view  addSubview:self.bgView];
    [self.bgView addSubview:self.titleLb];
    [self.bgView  addSubview:self.examInfoLb];
//    [self.bgView addSubview:self.barCodeImg];
    [self.bgView  addSubview:self.headerImg];
    [self.bgView addSubview:self.timeTileLb];
    [self.bgView  addSubview:self.timeValueLb];
    [self.bgView addSubview:self.subjectTitleLb];
    [self.bgView  addSubview:self.subjectValueBtn];
//    [self.bgView addSubview:self.studyUpImg];
//    [self.bgView addSubview:self.downImg];
    [self.view addSubview:self.examButton];
    [self.view addSubview:self.yearTitleLb];
    [self.view addSubview:self.selectYearBtn];
    
    [self.bgView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30) ;
        make.top.mas_equalTo(URSafeAreaNavHeight()+33*AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth() - 60, 450*AUTO_WIDTH));
    }];
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80 * AUTO_WIDTH, 80 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.bgView).mas_offset(22 * AUTO_WIDTH);
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.headerImg.mas_bottom).mas_offset(12 * AUTO_WIDTH);
    }];
    [self.examInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(83 * AUTO_WIDTH);
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(30 * AUTO_WIDTH);
    }];
    
//    [self.barCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.examInfoLb);
//        make.size.mas_equalTo(CGSizeMake(120 * AUTO_WIDTH, 17 * AUTO_WIDTH));
//        make.top.mas_equalTo(self.examInfoLb.mas_bottom).offset(5 * AUTO_WIDTH);
//    }];
    [self.timeTileLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.examInfoLb.mas_bottom).offset(25 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(86 * AUTO_WIDTH, 40 * AUTO_WIDTH));
        make.left.mas_equalTo(self.examInfoLb).mas_offset(-20);
    }];
    [self.subjectTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeTileLb);
        make.size.mas_equalTo(self.timeTileLb);
        make.top.mas_equalTo(self.timeTileLb.mas_bottom).offset(-0.5);
    }];
    [self.timeValueLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(123 * AUTO_WIDTH, 40 * AUTO_WIDTH));
        make.left.mas_equalTo(self.timeTileLb.mas_right).offset(-0.5);
        make.top.mas_equalTo(self.timeTileLb);
    }];
    [self.subjectValueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeValueLb);
        make.size.mas_equalTo(self.timeValueLb);
        make.top.mas_equalTo(self.timeValueLb.mas_bottom).offset(-0.5);
    }];
    
    [self.yearTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.subjectTitleLb.mas_bottom).offset(-0.5);
        make.left.mas_equalTo(self.timeTileLb);
        make.size.mas_equalTo(self.timeTileLb);
    }];
    
    [self.selectYearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeValueLb);
        make.size.mas_equalTo(self.timeValueLb);
        make.top.mas_equalTo(self.subjectValueBtn.mas_bottom).offset(-0.5);
    }];
    
//    [self.downImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.subjectValueBtn.mas_right).offset(5);
//        make.centerY.mas_equalTo(self.subjectValueBtn);
//        make.size.mas_equalTo(CGSizeMake(10 * AUTO_WIDTH, 10 * AUTO_WIDTH));
//    }];
//    [self.studyUpImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.bgView);
//        make.top.mas_equalTo(self.subjectTitleLb.mas_bottom).offset(22 * AUTO_WIDTH);
//        make.size.mas_equalTo(CGSizeMake(143.5 * AUTO_WIDTH, 25.5 * AUTO_WIDTH));
//    }];
    [self.examButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view) ;
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(26 * AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake(306 * AUTO_WIDTH, 53 * AUTO_WIDTH));
    }];
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView  alloc] init];
        
        UIImage * bgImageView = [UIImage  imageNamed:@"bankbg"] ;
        _bgView.contentMode = UIViewContentModeScaleAspectFill ;
        _bgView.layer.contents = (__bridge id)bgImageView.CGImage ;
    }
    
    return _bgView ;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"护考通模拟考试" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(18) textAlignment:NSTextAlignmentCenter numberLines:2];
    }
    return _titleLb;
}

- (UILabel *)examInfoLb
{
    if (!_examInfoLb) {
        _examInfoLb = [UILabel normalLabelWithTitle:@"准考证号:15202995373\n考生姓名:王春霞\n考试场地:护考通平台" titleColor:UR_ColorFromValue(0x353535) font:RegularFont(16) textAlignment:NSTextAlignmentLeft numberLines:3];
    }
    return _examInfoLb;
}

- (UIImageView *)headerImg
{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headimg"]];
    }
    return _headerImg;
}

- (UIImageView *)barCodeImg
{
    if (!_barCodeImg) {
        _barCodeImg = [[UIImageView alloc] init];
        _barCodeImg.backgroundColor = [UIColor grayColor];
    }
    return _barCodeImg;
}

- (UILabel *)timeTileLb
{
    if (!_timeTileLb) {
        _timeTileLb = [UILabel borderLabelWithRadius:0 borderColor:UR_COLOR_LINE borderWidth:0.5 title:@"考试时间" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(14) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _timeTileLb;
}

- (UILabel *)timeValueLb
{
    if (!_timeValueLb) {
        _timeValueLb = [UILabel borderLabelWithRadius:0 borderColor:UR_COLOR_LINE borderWidth:0.5 title:@"120分钟" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(14) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _timeValueLb;
}

- (UILabel *)subjectTitleLb
{
    if (!_subjectTitleLb) {
        _subjectTitleLb = [UILabel borderLabelWithRadius:0 borderColor:UR_COLOR_LINE borderWidth:0.5 title:@"考试科目" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(14) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _subjectTitleLb;
}
- (UILabel *)yearTitleLb {
    if (!_yearTitleLb) {
        _yearTitleLb = [UILabel borderLabelWithRadius:0 borderColor:UR_COLOR_LINE borderWidth:0.5 title:@"试卷年份" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(14) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _yearTitleLb;
}

- (UIButton *)subjectValueBtn
{
    if (!_subjectValueBtn) {
        _subjectValueBtn = [UIButton borderBtnWithBorderColor:UR_COLOR_LINE borderWidth:0.5 cornerRadius:0 title:@"请选择科目" titleColor:UR_ColorFromValue(0x999999) titleFont:RegularFont(14)];
        [_subjectValueBtn setImage:[UIImage imageNamed:@"down1"] forState:UIControlStateNormal];
        _subjectValueBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    }
    return _subjectValueBtn;
}

- (UIButton *)selectYearBtn {
    if (!_selectYearBtn) {
        _selectYearBtn = [UIButton borderBtnWithBorderColor:UR_COLOR_LINE borderWidth:0.5 cornerRadius:0 title:@"请选择年份" titleColor:UR_ColorFromValue(0x999999) titleFont:RegularFont(14)];
        [_selectYearBtn setImage:[UIImage imageNamed:@"down1"] forState:UIControlStateNormal];
        _selectYearBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    }
    return _selectYearBtn;
}
- (UIImageView *)studyUpImg
{
    if (!_studyUpImg) {
        _studyUpImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"资源 2"]];
    }
    return _studyUpImg;
}

-(UIImageView *)downImg {
    if (!_downImg) {
        _downImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down1"]];
    }
    return _downImg;
}
- (UIButton *)examButton
{
    if (!_examButton) {
        _examButton = [UIButton  buttonWithType:UIButtonTypeCustom] ;
        [_examButton setTitle:@"开始考试" forState:UIControlStateNormal];
        _examButton.titleLabel.font = [UIFont systemFontOfSize:24];
        [_examButton setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
        [_examButton  setBackgroundColor:UR_ColorFromValue(0xFF9B87)];
        _examButton.layer.cornerRadius = 27.0f ;
        _examButton.layer.masksToBounds = YES ;
    }
    return _examButton;
}


@end
