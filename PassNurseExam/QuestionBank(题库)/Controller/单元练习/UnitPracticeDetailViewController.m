//
//  UnitPracticeDetailViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeDetailViewController.h"
//cell
#import "UnitPracticeDetailProgressCell.h"
#import "UnitPracticeDetailQuestionTopicCell.h"
#import "UnitPracticeDetailQuestionContentCell.h"
#import "UnitPracticeDetailImgOrVideoCell.h"
#import "UnitPracticeDetailOptionsCell.h"
#import "UnitPracticeDetailBtnCell.h"
#import "UnitPracticeDetailAnswerKeysCell.h"

#import "UnitPracticeDetailBottomView.h"
#import "AnswerSheetView.h"
#import "AskQuestionsView.h"
#import <PopoverView.h>
#import "AnswerResultsVC.h"
#import "ReportErrorsVC.h"

static NSString * const UnitPracticeDetailProgressCellIdentifier = @"UnitPracticeDetailProgressCellIdentifier";
static NSString * const UnitPracticeDetailTopicCellIdentifier = @"UnitPracticeDetailTopicCellIdentifier";
static NSString * const UnitPracticeDetailImgOrVideoCellIdentifier = @"UnitPracticeDetailImgOrVideoCellIdentifier";
static NSString * const UnitPracticeDetailQuestionContentCellIdentifier = @"UnitPracticeDetailQuestionContentCellIdentifier";
static NSString * const UnitPracticeDetailOptionsCellIdentifier = @"UnitPracticeDetailOptionsCellIdentifier";
static NSString * const UnitPracticeDetailBtnCellIdentifier = @"UnitPracticeDetailBtnCellIdentifier";
static NSString * const UnitPracticeDetailAnswerKeysCellIdentifier = @"UnitPracticeDetailAnswerKeysCellIdentifier";


@interface UnitPracticeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UnitPracticeDetailBottomView * bottomView;

@property (nonatomic,strong) UnitPracticeDetailModel * detailModel;
@property (nonatomic,assign) NSInteger nowAnswerNo;//当前答题进度编号
@property (nonatomic,strong) NSArray *noTitles;
@property (nonatomic, strong) ZFPlayerController *questionsPlayer;

@end

@implementation UnitPracticeDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    self.questionsPlayer.viewControllerDisappear = NO;

    [[URCommonApiManager  sharedInstance] getUnitExerciseDetailDataWithUnitID:self.questionBankModel.idStr?:@"" type:self.type?:@"" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.detailModel = response;
        self.nowAnswerNo = 0;
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.questionsPlayer.viewControllerDisappear = YES ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.noTitles = @[@"A",@"B",@"C",@"D",@"E",@"F"];
 
    [self createUI];
    [self configTarget];
}

- (void)createUI
{
    self.lblTitle.text = @"单元练习";
    [self.cBtnRight  setImage:[UIImage  imageNamed:@"ai221"] forState:UIControlStateNormal];
    self.cBtnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -44 * AUTO_WIDTH) ;
    
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

- (void)configTarget
{
    @weakify(self);
    
    [RACObserve(self, nowAnswerNo) subscribeNext:^(NSNumber * x) {
        @strongify(self);
        
        if (self.nowAnswerNo == self.detailModel.data.count-1)
        {
            [self.bottomView.sheetButton setImage:[UIImage  imageNamed:@"tijiaochenggong"] forState:UIControlStateNormal];
            [self.bottomView.sheetButton setTitle:@"提交" forState:UIControlStateNormal];
         }else
        {
            [self.bottomView.sheetButton setImage:[UIImage  imageNamed:@"datiqia"] forState:UIControlStateNormal];
            [self.bottomView.sheetButton setTitle:@"答题卡" forState:UIControlStateNormal];
        }
        [self.bottomView.sheetButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleTop imageTitleSpace:10];
        

        UnitPracticeDetailDataModel *nowDataModel = self.detailModel.data[self.nowAnswerNo];

        [self.bottomView.collectButton setImage:[UIImage imageNamed:[nowDataModel.collected boolValue] ? @"shoucang" : @"un_shoucang"] forState:UIControlStateNormal];
        [self.bottomView.collectButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleTop imageTitleSpace:10];

        [self.tableView reloadData];
    }];
    
    
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
            case 3://分享
                
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
    if (self.nowAnswerNo == self.detailModel.data.count-1)
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
    
    [sheetView alertWithDataArr:self.detailModel.data linkQuestion:^(NSInteger nowIndex) {
        
        self.nowAnswerNo = nowIndex;
    } commit:^{
        [self commitJudge];
    }];
}

//提交判断
- (void)commitJudge
{
    __block NSInteger unAnswerSum = 0;
    
    [self.detailModel.data enumerateObjectsUsingBlock:^(UnitPracticeDetailDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isAnswered == NO) {
            unAnswerSum = unAnswerSum + 1;
        }
    }];
    
    if (unAnswerSum > 0)
    {
        [URAlert alertViewWithStyle:URAlertStyleAlert title:@"提示" message:[NSString stringWithFormat:@"你还有%zd道题未作答，确定要提交吗？",unAnswerSum] cancelButtonTitle:@"继续作答" sureButtonTitles:@"提交" viewController:self handler:^(NSInteger buttonIndex) {
            //提交
            [self commitResult];
        }];
    }else
    {
        [self commitResult];
    }
}

//提交结果
- (void)commitResult
{
    //数据处理
    NSMutableArray *resultArr = [NSMutableArray array];
    
    for (int i = 0; i < self.detailModel.data.count; i++)
    {
        UnitPracticeDetailDataModel *model = self.detailModel.data[i];

        if (model.isAnswered)
        {
            //传json，只穿做了的题，
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
            
            // wrong 1正确 2错误
            dic[@"wrong"] = [optionStr isEqualToString:model.answer] ? @"1" : @"2";
            model.wrong = dic[@"wrong"];
            
            [resultArr addObject:dic];
        }
    }
    
    //数组转json
    NSError *error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:resultArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *recordId = [[NSString alloc] initWithData: jsonData encoding:NSUTF8StringEncoding];
    
    [[URCommonApiManager sharedInstance] commitQuestionWithRecord:recordId type:@"unit" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" info:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
       
        [URToastHelper showErrorWithStatus:@"提交成功"];

        AnswerResultsVC *vc = [[AnswerResultsVC alloc] init];
        vc.dataArr = self.detailModel.data;
        [self.navigationController pushViewController:vc animated:YES];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

//收藏题目
- (void)collectQuestion
{
    UnitPracticeDetailDataModel *nowDataModel = self.detailModel.data[self.nowAnswerNo];
    
    [[URCommonApiManager sharedInstance] unitExercisesCollectWithID:nowDataModel.idStr type:@"unit" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
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

//问题求助输入框
- (void)alerHelpAskQuestionView
{
    AskQuestionsView *askView = [[AskQuestionsView alloc] initWithFrame:CGRectMake(0, URSafeAreaNavHeight(), URScreenWidth(),self.tableView.mj_h)];
    askView.tag = 101;
    [self.view addSubview:askView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    UnitPracticeDetailDataModel *dataModel = self.detailModel.data[self.nowAnswerNo];
    return dataModel.showAnswerKeys ? 4 : 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.detailModel.data[self.nowAnswerNo].picture.length > 0 || self.detailModel.data[self.nowAnswerNo].video.length > 0)
        {
            return 4;
        }
        return 3;
    }
    return section == 1 ? self.detailModel.data[self.nowAnswerNo].options.count : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnitPracticeDetailDataModel *dataModel = self.detailModel.data[self.nowAnswerNo];
   
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UnitPracticeDetailProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailProgressCellIdentifier];
            
            cell.questionBankTitleLb.text = self.questionBankModel.name;
            cell.progressView.progress = (self.nowAnswerNo+1)/(CGFloat)self.detailModel.data.count;
            cell.progressLb.text = [NSString stringWithFormat:@"%zd/%zd",self.nowAnswerNo+1,self.detailModel.data.count];
            
            return cell;
        }
        else if (indexPath.row == 1)
        {
            UnitPracticeDetailQuestionTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailTopicCellIdentifier];
            
            if ([dataModel.type isEqualToString:@"1"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【单选】%@题型",dataModel.question_type];
            }else if ([dataModel.type isEqualToString:@"2"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【多选】%@题型",dataModel.question_type];
            }else if ([dataModel.type isEqualToString:@"3"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【判断】%@题型",dataModel.question_type];
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
    else if (indexPath.section == 2)
    {
        UnitPracticeDetailBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailBtnCellIdentifier];
        [cell.leftBtn setTitle:@"答案解析" forState:UIControlStateNormal];
        [cell.rightBtn setTitle:@"求助讨论" forState:UIControlStateNormal];
        
        [[[cell.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {

            dataModel.showAnswerKeys = !dataModel.showAnswerKeys;
            [self.tableView reloadData];
        }];
        [[[cell.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            
            [self alerHelpAskQuestionView];
        }];
        
        return cell;
    }
    else if (indexPath.section == 3)
    {
        UnitPracticeDetailAnswerKeysCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailAnswerKeysCellIdentifier];
        if (dataModel.answer.length > 0)
        {
            NSString *answerStr = @"参考答案：";

            for (int i = 0; i < dataModel.answer.length; i++)
            {
                //答案是从 1/2/3/4/5/6 开始编号，对应 A/B/C/D/E/F
                NSInteger index = [[dataModel.answer substringWithRange:NSMakeRange(i, 1)] integerValue]-1;
                answerStr = [answerStr stringByAppendingString:self.noTitles[index]];
            }
            cell.titleLb.text = answerStr;
        }
        cell.contentLb.text = [NSString stringWithFormat:@"【解析】%@",dataModel.analysis ?: @""];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        UnitPracticeDetailDataModel *dataModel = self.detailModel.data[self.nowAnswerNo];

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
           
            //如果是单选题，1秒之后自动跳到下一题
            [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:0.5];
        }
        else if ([dataModel.type isEqualToString:@"2"])
        {
            //多选题
            OptionsModel *option = dataModel.options[indexPath.row];
            option.selected = !option.selected;
            
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
        _tableView.estimatedRowHeight = 44.0f;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
        
        [_tableView registerClass:[UnitPracticeDetailProgressCell class] forCellReuseIdentifier:UnitPracticeDetailProgressCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailQuestionTopicCell class] forCellReuseIdentifier:UnitPracticeDetailTopicCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailImgOrVideoCell class] forCellReuseIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailQuestionContentCell class] forCellReuseIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailOptionsCell class] forCellReuseIdentifier:UnitPracticeDetailOptionsCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailBtnCell class] forCellReuseIdentifier:UnitPracticeDetailBtnCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailAnswerKeysCell class] forCellReuseIdentifier:UnitPracticeDetailAnswerKeysCellIdentifier];
    }
    return _tableView;
}


- (UnitPracticeDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UnitPracticeDetailBottomView  alloc] init];
    }
    return _bottomView ;
}

-(void)navRightPressed:(id)sender
{
    //右上角菜单弹框
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES;
    
    PopoverAction *reStart = [PopoverAction actionWithImage:[UIImage imageNamed:@"报错"] title:@"重新开始" handler:^(PopoverAction *action) {
       
        [self.detailModel.data enumerateObjectsUsingBlock:^(UnitPracticeDetailDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            obj.isAnswered = NO;
            obj.showAnswerKeys = NO;
            
            [obj.options enumerateObjectsUsingBlock:^(OptionsModel * _Nonnull option, NSUInteger idx, BOOL * _Nonnull stop) {
                option.selected = NO;
            }];
        }];
        
        self.nowAnswerNo = 0;
    }];
    
    PopoverAction *sprint = [PopoverAction actionWithImage:[UIImage imageNamed:@"冲刺"] title:@"冲刺" handler:^(PopoverAction *action) {
        
        [self.detailModel.data enumerateObjectsUsingBlock:^(UnitPracticeDetailDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.isAnswered = YES;
            obj.showAnswerKeys = YES;
            
            [obj.options enumerateObjectsUsingBlock:^(OptionsModel * _Nonnull option, NSUInteger idx, BOOL * _Nonnull stop) {
                option.selected = NO;
            }];
            
            for (int i = 0; i < obj.answer.length; i++)
            {
                //答案是从 1/2/3/4/5/6 开始编号，对应 A/B/C/D/E/F
                NSInteger index = [[obj.answer substringWithRange:NSMakeRange(i, 1)] integerValue]-1;
                OptionsModel *option = obj.options[index];
                option.selected = YES;
            }
        }];
        
        [self.tableView reloadData];
    }];
        
    PopoverAction *wrong = [PopoverAction actionWithImage:[UIImage imageNamed:@"报错"] title:@"报错" handler:^(PopoverAction *action) {
        
        UnitPracticeDetailDataModel *dataModel = self.detailModel.data[self.nowAnswerNo];

        ReportErrorsVC *vc = [[ReportErrorsVC alloc] init];
        vc.itemIdStr = dataModel.idStr;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [popoverView showToView:sender withActions:@[reStart,sprint,wrong]];
}


@end
