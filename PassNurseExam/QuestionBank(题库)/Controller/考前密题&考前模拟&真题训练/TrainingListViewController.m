//
//  TrainingListViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "TrainingListViewController.h"
#import "TrainingDetailViewController.h"
#import "ConfirmPapersViewController.h"
#import "UILabel+DateCountdown.h"

@interface TrainingListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) TrainingListModel * listMdel;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) UIButton * testEndButton;

@property (nonatomic,strong) UIButton * confirmPapersButton;

@property (nonatomic,copy) NSDate * startDate;
@property (nonatomic,copy) NSString * endtimeStr;

@end

@implementation TrainingListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //结束时间
    self.endtimeStr = [NSString stringWithFormat:@"%f",[[NSDate dateWithTimeIntervalSinceNow:[self.examTime intValue] * 60] timeIntervalSince1970] * 1000.0];
    //开始时间
    self.startDate = [NSDate date];
    
    self.lblTitle.text = [NSString  stringWithFormat:@"%@>%@",self.subTitleStr?:@"",self.secondTitleStr] ;
    
    [self.view  addSubview:self.tableView];
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(URSafeAreaNavHeight()) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()));
    }];
    
    [self requestData];
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commitResult) name:@"CountDownEndNoti" object:nil];
}

- (void)navLeftPressed
{
    [URAlert alertViewWithStyle:URAlertStyleAlert title:@"提示" message:@"确定退出？退出后记录将不再保存" cancelButtonTitle:@"取消" sureButtonTitles:@"确定" viewController:self handler:^(NSInteger buttonIndex) {
         
        if (buttonIndex == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)requestData
{
    @weakify(self) ;
    
    if (self.testType == TestType_Secret)
    {
        [[URCommonApiManager sharedInstance] getSecretQuestionDataWithVolume:self.secretVolume?:@"" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
            @strongify(self) ;
            self.listMdel = response ;
            [self.tableView  reloadData];
            
        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
    }
    else
    {
        [[URCommonApiManager  sharedInstance] getSimulationQuestionDataWithChooseType:self.testType subjectID:self.subjectID?:@"" categoryID:self.categoryID?:@"" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" year:self.yearStr requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
            @strongify(self) ;
            self.listMdel = response ;
            [self.tableView  reloadData];
            
        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
    }
}

//提交结果
- (void)commitResult
{
    //答题实际用时
    self.listMdel.useTime = [NSString stringWithFormat:@"%02d分%02d秒",(int)[[NSDate date] timeIntervalSinceDate:self.startDate] / 60,(int)[[NSDate date] timeIntervalSinceDate:self.startDate] % 60];
    self.listMdel.allTime = [NSString stringWithFormat:@"%@分",self.examTime];
    
    NSTimeInterval interval = [self.endtimeStr doubleValue]/1000.0 - [[NSDate date] timeIntervalSince1970];

    if (interval <= 0) {
        [URToastHelper showErrorWithStatus:@"答题时间已到，将自动交卷"];
    }
    
    //数据处理
    NSMutableArray *resultArr = [NSMutableArray array];
    
    [self.listMdel.data enumerateObjectsUsingBlock:^(TrainingListDataModel * _Nonnull partModel, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [partModel.list enumerateObjectsUsingBlock:^(TrainingListDataListModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if (model.isAnswered)
            {
                //传json，只传做了的题，
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                
                // id：题id
                dic[@"id"] = model.idStr;
                
                //option：选择的答案
                NSString *optionStr = @"";
                for (int j = 0; j < model.options.count; j++)
                {
                    OptionsModel *option = model.options[j];
                    
                    if (option.selected == YES) {
                        optionStr = [NSString stringWithFormat:@"%@%d",optionStr,j+1];
                    }
                }
                dic[@"option"] = optionStr;
                model.my_option = optionStr;
                
                // wrong 1正确 2错误
                dic[@"wrong"] = [optionStr isEqualToString:model.answer] ? @"1" : @"2";
                model.wrong = dic[@"wrong"];
                
                if ([optionStr isEqualToString:model.answer]) {
                    self.listMdel.correctCount += 1;
                }
                self.listMdel.finishCount += 1;
                
                [resultArr addObject:dic];
            }
            
        }];
        
        self.listMdel.allCount += partModel.list.count;
    }];
    
    //数组转json
    NSError *error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:resultArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *recordId = [[NSString alloc] initWithData: jsonData encoding:NSUTF8StringEncoding];
    
    
    
    NSDictionary * infoDict = @{
                                @"title":[NSString  stringWithFormat:@"%@>%@",self.subTitleStr?:@"",self.secondTitleStr],
                                @"from":@"ios",
                                @"subject":self.subTitleStr?:@"",
                                @"correct_num":@(self.listMdel.correctCount),//正确数量
                                @"notdone_num":@(self.listMdel.allCount-self.listMdel.finishCount),//未答数量
                                @"all_num":@(self.listMdel.allCount),//总数量
                                @"data": [self.listMdel.data  yy_modelToJSONObject] //所有内容（包含新增的两个字段 wrong、my_option）
                                };
    
    NSData * infoData = [NSJSONSerialization  dataWithJSONObject:infoDict options:NSJSONWritingPrettyPrinted error:&error];
    NSString * infoStr =[[NSString  alloc] initWithData:infoData encoding:NSUTF8StringEncoding];
    
    [[URCommonApiManager sharedInstance] commitQuestionWithRecord:recordId type:[self getTypeName] token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" info:infoStr?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        
        ConfirmPapersViewController * detailViewController = [[ConfirmPapersViewController  alloc] init];
        detailViewController.type = 1 ;
        detailViewController.lbTitleStr = [NSString  stringWithFormat:@"%@>%@",self.subTitleStr?:@"",self.secondTitleStr] ;
        detailViewController.listMdel = self.listMdel;
        
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (NSString *)getTypeName
{
    switch (self.testType) {
        case TestType_Simulation:
            return @"simulation";
        case TestType_Original:
            return @"original";
        case TestType_Secret:
            return @"secret";
        default:
            return @"";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listMdel.data.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"tableViewCellID"] ;
    
    if (!tableViewCell) {
        
        tableViewCell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableViewCellID"];
        tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        UIImageView * flagImageView = [[UIImageView  alloc] init];
        flagImageView.tag = 1000 ;
        [tableViewCell.contentView  addSubview:flagImageView];
        [flagImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15) ;
            make.top.mas_equalTo(12) ;
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }] ;
    }
    
    tableViewCell.textLabel.text = [NSString  stringWithFormat:@"%@",self.listMdel.data[indexPath.row].name?:@""] ;
    tableViewCell.textLabel.textColor = UR_ColorFromValue(0x333333) ;
    tableViewCell.textLabel.font = RegularFont(16.0f) ;
    
    UIImageView * flagImageView = [tableViewCell.contentView  viewWithTag:1000] ;
    flagImageView.image = [UIImage imageNamed:self.listMdel.data[indexPath.row].isAnswered ? @"redflag" : @"grayflag"];
    
    return tableViewCell ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    header.backgroundColor = UR_COLOR_BACKGROUND_ALL;
    
    UILabel *timeLb = [UILabel normalLabelWithTitle:[NSString stringWithFormat:@"答题时间：%@分钟",self.examTime] titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    [header addSubview:timeLb];
    
    UILabel *countdownLb = [UILabel normalLabelWithTitle:[NSString stringWithFormat:@"时间：%@分钟",self.examTime] titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    [header addSubview:countdownLb];
    
    UIImageView *shalouImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shalou"]];
    [header addSubview:shalouImg];
    
    [shalouImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(header);
    }];
    [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(header);
        make.right.mas_equalTo(shalouImg.mas_left).offset(-5);
    }];
    [countdownLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(header);
        make.left.mas_equalTo(shalouImg.mas_right).offset(5);
    }];

    [countdownLb startTime:self.endtimeStr countDownType:countDown_type_ms];
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footerview = [[UIView  alloc] init];
    
    self.testEndButton = [[UIButton  alloc] init];
    [self.testEndButton setTitle:@"结束测验" forState:UIControlStateNormal];
    [self.testEndButton  setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
    [self.testEndButton setBackgroundColor:[UIColor  redColor]];
    self.testEndButton.layer.cornerRadius = 20.0f *AUTO_WIDTH;
    self.testEndButton.layer.masksToBounds = YES ;
    self.testEndButton.titleLabel.font = RegularFont(16.0f) ;
    [footerview  addSubview:self.testEndButton];
    [self.testEndButton   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * AUTO_WIDTH) ;
        make.top.mas_equalTo(30 * AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake((URScreenWidth()-60*AUTO_WIDTH)/2, 40 * AUTO_WIDTH));
    }];
    
    self.confirmPapersButton = [[UIButton  alloc] init];
    [self.confirmPapersButton setTitle:@"确认交卷" forState:UIControlStateNormal];
    [self.confirmPapersButton  setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
    [self.confirmPapersButton setBackgroundColor:[UIColor  redColor]];
    self.confirmPapersButton.layer.cornerRadius = 22.0f *AUTO_WIDTH;
    self.confirmPapersButton.layer.masksToBounds = YES ;
    self.confirmPapersButton.titleLabel.font = RegularFont(16.0f) ;
    [footerview  addSubview:self.confirmPapersButton];
    [self.confirmPapersButton   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20 * AUTO_WIDTH) ;
        make.top.mas_equalTo(self.testEndButton) ;
        make.size.mas_equalTo(self.testEndButton);
    }];
    
    @weakify(self);
    [[self.testEndButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [URAlert alertViewWithStyle:URAlertStyleAlert title:@"提示" message:@"确定退出？退出后记录将不再保存" cancelButtonTitle:@"取消" sureButtonTitles:@"确定" viewController:self handler:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }];
    [[self.confirmPapersButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self commitResult];
    }];
    
    return footerview ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50 * AUTO_WIDTH;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 89 * AUTO_WIDTH ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row - 1 >= 0) {
        TrainingListDataModel *lastModle = self.listMdel.data[indexPath.row - 1];
        if (lastModle.isAnswered == NO) {
            [URToastHelper showErrorWithStatus:@"请先完成上一部分题目"];
            return;
        }
    }
    TrainingDetailViewController * detailViewController = [[TrainingDetailViewController  alloc] init];
    
    detailViewController.dataModel = [self.listMdel.data[indexPath.row] copy];
    
    NSLog(@"%@\n",self.listMdel.data[indexPath.row]);
    NSLog(@"%@",detailViewController.dataModel);
    
    detailViewController.titleStr = [NSString  stringWithFormat:@"%@",self.listMdel.data[indexPath.row].name?:@""] ;
    detailViewController.lbTitleStr = [NSString  stringWithFormat:@"%@>%@",self.subTitleStr?:@"",self.secondTitleStr] ;
    detailViewController.endtimeStr = self.endtimeStr;
    
    detailViewController.commitBlock = ^(TrainingListDataModel * model) {
        //将提交上来的数据替换掉原来的数据
        [self.listMdel.data replaceObjectAtIndex:indexPath.row withObject:model];
    };
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.separatorColor = UR_COLOR_LINE;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0) ;
        _tableView.estimatedRowHeight = 70.0f * AUTO_WIDTH;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
    }
    return _tableView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
