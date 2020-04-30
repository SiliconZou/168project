//
//  TrainingDetailViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "TrainingDetailViewController.h"

//cell
#import "SimulationProgressCell.h"
#import "UnitPracticeDetailQuestionTopicCell.h"
#import "UnitPracticeDetailQuestionContentCell.h"
#import "UnitPracticeDetailImgOrVideoCell.h"
#import "UnitPracticeDetailOptionsCell.h"
#import "UnitPracticeDetailBtnCell.h"

#import "UnitPracticeDetailBottomView.h"
#import "AnswerSheetView.h"
#import "AnswerResultsVC.h"
#import "ReportErrorsVC.h"

#import "UILabel+DateCountdown.h"

static NSString * const SimulationProgressCellIdentifier = @"SimulationProgressCellIdentifier";
static NSString * const UnitPracticeDetailTopicCellIdentifier = @"UnitPracticeDetailTopicCellIdentifier";
static NSString * const UnitPracticeDetailImgOrVideoCellIdentifier = @"UnitPracticeDetailImgOrVideoCellIdentifier";
static NSString * const UnitPracticeDetailQuestionContentCellIdentifier = @"UnitPracticeDetailQuestionContentCellIdentifier";
static NSString * const UnitPracticeDetailOptionsCellIdentifier = @"UnitPracticeDetailOptionsCellIdentifier";
static NSString * const UnitPracticeDetailBtnCellIdentifier = @"UnitPracticeDetailBtnCellIdentifier";

@interface TrainingDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UnitPracticeDetailBottomView * bottomView;

@property (nonatomic,assign) NSInteger nowAnswerNo;//当前答题进度编号
@property (nonatomic,strong) NSArray *noTitles;
@property (nonatomic, strong) ZFPlayerController *questionsPlayer;

@end

@implementation TrainingDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    self.questionsPlayer.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.questionsPlayer.viewControllerDisappear = YES ;
}

//-(void)viewDidAppear:(BOOL)animated {
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nowAnswerNo = 0;
    self.noTitles = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    
    self.lblTitle.text = self.lbTitleStr ;
    
    if(self.dataModel.list.count>0){
        [self createUI];
        [self configTarget];
    }
    
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
}

- (void)createUI{
    
    [self.view  addSubview:self.bottomView];
    [self.view addSubview:self.tableView];
    
    [self.bottomView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 64 * AUTO_WIDTH));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
}

- (void)navLeftPressed
{
    [URAlert alertViewWithStyle:URAlertStyleAlert title:@"提示" message:@"确定退出？退出后记录将不再保存" cancelButtonTitle:@"取消" sureButtonTitles:@"确定" viewController:self handler:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)configTarget
{
//    @weakify(self);
    
    [RACObserve(self, nowAnswerNo) subscribeNext:^(NSNumber * x) {
//        @strongify(self);
        
        if (self.nowAnswerNo == self.dataModel.list.count-1)
        {
            [self.bottomView.sheetButton setImage:[UIImage  imageNamed:@"tijiaochenggong"] forState:UIControlStateNormal];
            [self.bottomView.sheetButton setTitle:@"提交" forState:UIControlStateNormal];
        }else
        {
            [self.bottomView.sheetButton setImage:[UIImage  imageNamed:@"datiqia"] forState:UIControlStateNormal];
            [self.bottomView.sheetButton setTitle:@"答题卡" forState:UIControlStateNormal];
        }
        [self.bottomView.sheetButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleTop imageTitleSpace:10];
        
        
        TrainingListDataListModel *nowDataModel = self.dataModel.list[self.nowAnswerNo];
        
        [self.bottomView.collectButton setImage:[UIImage imageNamed:[nowDataModel.collected boolValue] ? @"shoucang" : @"un_shoucang"] forState:UIControlStateNormal];
        [self.bottomView.collectButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleTop imageTitleSpace:10];
        
        [self.tableView reloadData];
    }];
    
        @weakify(self);

    self.bottomView.selectedButtonBlock = ^(NSInteger tag) {
        @strongify(self);
        
        switch (tag) {
            case 0://上一题
                [self lastQuestion];
                break;
            case 1://答题卡
            {
                [self alertAnswerSheetView];
            }
                break;
            case 2:{//收藏
                [self  collectQuestion] ;
            }
                break;
            case 3:{//分享
                URSharedView * sharedView= [[URSharedView  alloc] init];
                NSDictionary *shareInfo = @{@"title":@"168网校-精选题库",@"descr":@"",@"shareUrl":@"https://www.baidu.com",@"path":@"pages/logs/logs",@"userName":@"gh_a8bc08217cb8",@"imgName":@"tiku"};
                [sharedView shareMiniProgramWithDict:shareInfo];
            }
                break;
            case 4://下一题
                [self nextQuestion];
                break;
            default:
                break;
        }
    };
}

//上一题
- (void)lastQuestion
{
    if (self.nowAnswerNo == 0) {
        [URAlert alertWithStyle:URAlertStyleAlert message:@"已经是第一题了"];
        return;
    }
    self.nowAnswerNo = self.nowAnswerNo - 1;
}

//下一题
- (void)nextQuestion
{
    if (self.nowAnswerNo == self.dataModel.list.count-1)
    {
        [URAlert alertWithStyle:URAlertStyleAlert message:@"已经是最后一题了"];
        return;
    }
    self.nowAnswerNo = self.nowAnswerNo + 1;
}

//答题卡
- (void)alertAnswerSheetView
{
    AnswerSheetView *sheetView = [[AnswerSheetView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:sheetView];
    
    [sheetView alertWithDataArr:self.dataModel.list linkQuestion:^(NSInteger nowIndex) {
        
        self.nowAnswerNo = nowIndex;
    } commit:^{
        [self commitJudge];
    }];
}

//提交判断
- (void)commitJudge
{
    __block NSInteger unAnswerSum = 0;
    
    [self.dataModel.list  enumerateObjectsUsingBlock:^(TrainingListDataListModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isAnswered == NO) {
            unAnswerSum = unAnswerSum + 1;
        }
    }] ;
    
    if (unAnswerSum > 0)
    {
        [URAlert alertViewWithStyle:URAlertStyleAlert title:@"提示" message:[NSString stringWithFormat:@"你还有%zd道题未作答，确定要提交吗？",unAnswerSum] cancelButtonTitle:@"继续作答" sureButtonTitles:@"提交" viewController:self handler:^(NSInteger buttonIndex) {
            
            //提交
            if (buttonIndex == 1) {
                [self commitResult];
            }
        }];
    }else
    {
        [self commitResult];
    }
}

- (void)commitResult
{
    //一道题都未做，也可以提交
    self.dataModel.isAnswered = YES;

    if (self.commitBlock) {
        self.commitBlock(self.dataModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//收藏题目
- (void)collectQuestion
{
    TrainingListDataListModel *nowDataModel = self.dataModel.list[self.nowAnswerNo];
    
    [[URCommonApiManager sharedInstance] unitExercisesCollectWithID:nowDataModel.idStr type:[self getTypeName] token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        if ([responseDict[@"data"] integerValue] == 1)
        {
            [URToastHelper  showErrorWithStatus:@"收藏成功"] ;
            [self.bottomView.collectButton setImage:[UIImage  imageNamed:@"shoucang"] forState:UIControlStateNormal];
            nowDataModel.collected = @"1";
        }else
        {
            [URToastHelper  showErrorWithStatus:@"取消收藏"] ;
            [self.bottomView.collectButton setImage:[UIImage  imageNamed:@"un_shoucang"] forState:UIControlStateNormal];
            nowDataModel.collected = @"0";
        }
        
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        
        if (self.dataModel.list[self.nowAnswerNo].picture.length > 0 || self.dataModel.list[self.nowAnswerNo].video.length > 0)
        {
            return 4;
        }
        return 3;
    }
    return section == 1 ? self.dataModel.list[self.nowAnswerNo].options.count : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrainingListDataListModel *dataModel = self.dataModel.list[self.nowAnswerNo];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            SimulationProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:SimulationProgressCellIdentifier];
            
            cell.questionBankTitleLb.text = self.titleStr?:@"";
            cell.progressView.progress = (self.nowAnswerNo+1)/(CGFloat)self.dataModel.list.count;
            cell.progressLb.text = [NSString stringWithFormat:@"%zd/%zd",self.nowAnswerNo+1,self.dataModel.list.count];
            [cell.countdownLb startTime:self.endtimeStr countDownType:countDown_type_ms];
            return cell;
        }
        else if (indexPath.row == 1)
        {
            UnitPracticeDetailQuestionTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailTopicCellIdentifier];
            
            if ([dataModel.type isEqualToString:@"1"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【单选】%@题型    (%@真题)",dataModel.question_type,dataModel.year];
            }else if ([dataModel.type isEqualToString:@"2"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【多选】%@题型    (%@真题)",dataModel.question_type,dataModel.year];
            }else if ([dataModel.type isEqualToString:@"3"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【判断】%@题型    (%@真题)",dataModel.question_type,dataModel.year];
            }else {
                cell.topicLb.text = @"";
            }
            
            CGFloat rate = 100;
            if ( [dataModel.finished_count doubleValue] > 0) {
                rate = ([dataModel.finished_count doubleValue] - [dataModel.error_count doubleValue]) / [dataModel.finished_count doubleValue] * 100;
            }
            cell.answerRateLb.text = [NSString stringWithFormat:@"ID:%@ 答题次数%@次 综合正确率%.0f%%",dataModel.idStr,dataModel.finished_count,rate];
            return cell;
        }
        else if (indexPath.row == [self.tableView numberOfRowsInSection:0]-1)
        {
            UnitPracticeDetailQuestionContentCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
            cell.questionContentLb.text = dataModel.title ?: @"";
            return cell;
        }
        else
        {
            //图片和视频的cell
            UnitPracticeDetailImgOrVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];
            
            if ([NSString isBlankString:dataModel.picture] == NO) {
                cell.currentPicURL = dataModel.picture;
            }else if ([NSString isBlankString:dataModel.video] == NO) {
                cell.currentPlayURL = dataModel.video;
            }
            self.questionsPlayer = cell.player;
            
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        UnitPracticeDetailOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailOptionsCellIdentifier];
        cell.noLb.text = self.noTitles[indexPath.row];
        
        OptionsModel *option = dataModel.options[indexPath.row];
        cell.optionsLb.text = option.optionName;
        cell.optionsLb.textColor = option.selected ? UR_ColorFromValue(0x9B89FF) : UR_ColorFromValue(0x333333);
        cell.noLb.textColor = option.selected ? UR_ColorFromValue(0xFFFFFF) : UR_ColorFromValue(0x333333);
        cell.noLb.backgroundColor = option.selected ? UR_ColorFromValue(0x9B89FF) : UR_ColorFromValue(0xFFFFFF);
        cell.noLb.layer.borderColor = option.selected ? UR_ColorFromValue(0x9B89FF).CGColor : UR_ColorFromValue(0xCCCCCC).CGColor;
        [cell.selectBtn setImage:[UIImage imageNamed:option.selected ? @"select" : @"unselect"] forState:UIControlStateNormal];
        return cell;
    }

    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        TrainingListDataListModel *dataModel = self.dataModel.list[self.nowAnswerNo];
        
        //只要有点击过，就代表作答了
        dataModel.isAnswered = YES;
        
        if ([dataModel.type isEqualToString:@"1"] || [dataModel.type isEqualToString:@"3"])
        {
            for (int i = 0; i < dataModel.options.count; i++)
            {
                OptionsModel *option = dataModel.options[i];
                option.selected = indexPath.row == i ? YES : NO;
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            
            //如果是单选题，0.5秒之后自动跳到下一题
            [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:0.5];
        }
        else if ([dataModel.type isEqualToString:@"2"])
        {
            //多选题
            for (int i = 0; i < dataModel.options.count; i++)
            {
                OptionsModel *option = dataModel.options[i];
                option.selected = !option.selected;
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        } else { }
    }
}



- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 64.0f;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
        
        [_tableView registerClass:[SimulationProgressCell class] forCellReuseIdentifier:SimulationProgressCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailQuestionTopicCell class] forCellReuseIdentifier:UnitPracticeDetailTopicCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailImgOrVideoCell class] forCellReuseIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailQuestionContentCell class] forCellReuseIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailOptionsCell class] forCellReuseIdentifier:UnitPracticeDetailOptionsCellIdentifier];
    }
    return _tableView;
}


- (UnitPracticeDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UnitPracticeDetailBottomView  alloc] init];
    }
    return _bottomView ;
}


@end
