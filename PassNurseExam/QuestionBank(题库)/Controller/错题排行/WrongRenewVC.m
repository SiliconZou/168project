//
//  WrongRenewVC.m
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "WrongRenewVC.h"
#import "UnitPracticeDetailQuestionContentCell.h"
#import "UnitPracticeDetailAnswerKeysCell.h"
#import "UnitPracticeDetailOptionsCell.h"
#import "UnitPracticeDetailBtnCell.h"
#import "UnitPracticeDetailImgOrVideoCell.h"
#import "UnitPracticeDetailQuestionTopicCell.h"

static NSString * const UnitPracticeDetailQuestionContentCellIdentifier = @"UnitPracticeDetailQuestionContentCellIdentifier";
static NSString * const UnitPracticeDetailImgOrVideoCellIdentifier = @"UnitPracticeDetailImgOrVideoCellIdentifier";
static NSString * const UnitPracticeDetailTopicCellIdentifier = @"UnitPracticeDetailTopicCellIdentifier";
static NSString * const UnitPracticeDetailOptionsCellIdentifier = @"UnitPracticeDetailOptionsCellIdentifier";
static NSString * const UnitPracticeDetailBtnCellIdentifier = @"UnitPracticeDetailBtnCellIdentifier";
static NSString * const UnitPracticeDetailAnswerKeysCellIdentifier = @"UnitPracticeDetailAnswerKeysCellIdentifier";

@interface WrongRenewVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView * tableView ;
@property (nonatomic,strong) NSArray *noTitles;
@property (nonatomic, strong) ZFPlayerController *questionsPlayer;

@end

@implementation WrongRenewVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.questionsPlayer.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.questionsPlayer.viewControllerDisappear = YES ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noTitles = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    
    if (self.type==1) {
        self.lblTitle.text = @"错题回顾" ;
        [self.cBtnRight setImage:[UIImage  imageNamed:@"NewShare"] forState:UIControlStateNormal];
        self.cBtnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -44 * AUTO_WIDTH) ;
    } else {
        self.lblTitle.text = @"收藏题目" ;
        [self.cBtnRight setImage:[UIImage  imageNamed:@"collect"] forState:UIControlStateNormal];
        self.cBtnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -44 * AUTO_WIDTH) ;
    }
    
    [self.view  addSubview:self.tableView];
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(URSafeAreaNavHeight());
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()));
    }];
}

-(void)navRightPressed:(id)sender{
    if (self.type ==1) {
        URSharedView * sharedView= [[URSharedView  alloc] init];
        URSharedModel * shareModel = [[URSharedModel alloc] init];
        shareModel.url = [NSString  stringWithFormat:@"%@",URShareURL] ;
        shareModel.thumbImage =@"AppIcon" ;
        shareModel.title = @"168网校" ;
        shareModel.descr = @"推荐168网校给好友，邀请好友得奖励" ;
        [sharedView  urShowShareViewWithDXShareModel:shareModel shareContentType:URShareContentTypeImage];
    } else {
        
        [URAlert  alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"确定要取消收藏吗？" cancelButtonTitle:@"再想想" sureButtonTitles:@"确定" viewController:self handler:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                [[URCommonApiManager sharedInstance] unitExercisesCollectWithID:self.dataModel.idStr type:@"unit" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                    
                    if ([responseDict[@"data"] integerValue] == 1){
                        [URToastHelper  showErrorWithStatus:@"收藏成功"] ;
                        [self.cBtnRight setImage:[UIImage  imageNamed:@"collect"] forState:UIControlStateNormal];
                        self.dataModel.collected = @"1";
                    }else{
                        [URToastHelper  showErrorWithStatus:@"取消收藏"] ;
                        [self.cBtnRight setImage:[UIImage  imageNamed:@"shoucang"] forState:UIControlStateNormal];
                        
                        self.dataModel.collected = @"0";
                        
                    }                    
                } requestFailureBlock:^(NSError *error, id response) {
                    
                }];
                
                
            }
        }] ;
        
    }
}

//提交结果
- (void)commitResult
{
    //数据处理
    NSMutableArray *resultArr = [NSMutableArray array];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // id：题id
    dic[@"id"] = self.dataModel.idStr;
    
    //option：选择的答案
    NSString *optionStr = @"";
    for (int j = 0; j < self.dataModel.options.count; j++)
    {
        OptionsModel *option = self.dataModel.options[j];
        
        if (option.selected == YES) {
            optionStr = [NSString stringWithFormat:@"%@%d",optionStr,j+1];
        }
    }
    
    if (optionStr.length == 0) {
        [URToastHelper showErrorWithStatus:@"请选择答案"];
        return;
    }
    
    dic[@"option"] = optionStr;
    
    // wrong 1正确2错误
    dic[@"wrong"] = [optionStr isEqualToString:self.dataModel.answer] ? @"1" : @"2";
    
    [resultArr addObject:dic];
    
    //数组转json
    NSError *error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:resultArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *recordId = [[NSString alloc] initWithData: jsonData encoding:NSUTF8StringEncoding];
    
    //错题排行的 type 跟 单元练习里一样，传 unit
    [[URCommonApiManager sharedInstance] commitQuestionWithRecord:recordId type:@"unit" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" info:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        [URToastHelper showErrorWithStatus:@"提交成功"];
        self.dataModel.isAnswered = YES;
        
        if ([optionStr isEqualToString:self.dataModel.answer])
        {
            //成功的话
            [URToastHelper showErrorWithStatus:@"恭喜你，回答正确！"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else
        {
            //错误，展示答题解析
            [URToastHelper showErrorWithStatus:@"回答错误，请查看答案解析！"];
            self.dataModel.showAnswerKeys = YES;
            [self.tableView reloadData];
        }
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataModel.showAnswerKeys ? 4 : 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.dataModel.picture.length > 0 || self.dataModel.video.length > 0)
        {
            return 3;
        }
        return 2;
    }
    return section == 1 ? self.dataModel.options.count : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UnitPracticeDetailQuestionTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailTopicCellIdentifier];

            if ([self.dataModel.type isEqualToString:@"1"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【单选】%@题型",self.dataModel.question_type];
            }else if ([self.dataModel.type isEqualToString:@"2"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【多选】%@题型",self.dataModel.question_type];
            }else if ([self.dataModel.type isEqualToString:@"3"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【判断】%@题型",self.dataModel.question_type];
            }else {
                cell.topicLb.text = @"";
            }
            
            CGFloat rate = 100;
            if ( [self.dataModel.finished_count doubleValue] > 0) {
                rate = ([self.dataModel.finished_count doubleValue] - [self.dataModel.error_count doubleValue]) / [self.dataModel.finished_count doubleValue] * 100;
            }
            cell.answerRateLb.text = [NSString stringWithFormat:@"ID:%@ 答题次数%@次 综合正确率%.0f%%",self.dataModel.idStr,self.dataModel.finished_count,rate];
            
            return cell;
        }else if (indexPath.row == [self.tableView numberOfRowsInSection:0]-1)
        {
            UnitPracticeDetailQuestionContentCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
            cell.questionContentLb.text = self.dataModel.title ?: @"";
            return cell;
        }
        else
        {
            //图片和视频的cell
            UnitPracticeDetailImgOrVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];
            if ([NSString isBlankString:self.dataModel.picture] == NO) {
                cell.currentPicURL = self.dataModel.picture;
            }else if ([NSString isBlankString:self.dataModel.video] == NO) {
                cell.currentPlayURL = self.dataModel.video;
            }
            self.questionsPlayer = cell.player;
            
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        UnitPracticeDetailOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailOptionsCellIdentifier];
        cell.noLb.text = self.noTitles[indexPath.row];
        
        OptionsModel *option = self.dataModel.options[indexPath.row];
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
        [cell.leftBtn setTitle:@"查看解析" forState:UIControlStateNormal];
        [cell.rightBtn setTitle:self.dataModel.isAnswered ? @"返回" : @"提交" forState:UIControlStateNormal];
        
        [[[cell.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            
            self.dataModel.showAnswerKeys = !self.dataModel.showAnswerKeys;
            [self.tableView reloadData];
        }];
        
        [[[cell.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            
            if (self.dataModel.isAnswered) {
                //返回
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                //提交
                [self commitResult];
            }
        }];
        
        return cell;
    }
    else if (indexPath.section == 3)
    {
        UnitPracticeDetailAnswerKeysCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailAnswerKeysCellIdentifier];
        if (self.dataModel.answer.length > 0)
        {
            NSString *answerStr = @"参考答案：";
            
            for (int i = 0; i < self.dataModel.answer.length; i++)
            {
                //答案是从 1/2/3/4/5/6 开始编号，对应 A/B/C/D/E/F
                NSInteger index = [[self.dataModel.answer substringWithRange:NSMakeRange(i, 1)] integerValue]-1;
                answerStr = [answerStr stringByAppendingString:self.noTitles[index]];
            }
            cell.titleLb.text = answerStr;
        }
        cell.contentLb.text = [NSString stringWithFormat:@"【解析】%@",self.dataModel.analysis ?: @""];
        return cell;
    }
    return [UITableViewCell new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && self.dataModel.isAnswered == NO)
    {
        if ([self.dataModel.type isEqualToString:@"1"] || [self.dataModel.type isEqualToString:@"3"])
        {
            for (int i = 0; i < self.dataModel.options.count; i++)
            {
                OptionsModel *option = self.dataModel.options[i];
                option.selected = indexPath.row == i ? YES : NO;
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
        else if ([self.dataModel.type isEqualToString:@"2"])
        {
            //多选题
            OptionsModel *option = self.dataModel.options[indexPath.row];
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO ;
#pragma clang diagnostic pop
        }
        [_tableView registerClass:[UnitPracticeDetailQuestionTopicCell class] forCellReuseIdentifier:UnitPracticeDetailTopicCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailImgOrVideoCell class] forCellReuseIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailQuestionContentCell class] forCellReuseIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailAnswerKeysCell class] forCellReuseIdentifier:UnitPracticeDetailAnswerKeysCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailBtnCell class] forCellReuseIdentifier:UnitPracticeDetailBtnCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailOptionsCell class] forCellReuseIdentifier:UnitPracticeDetailOptionsCellIdentifier];
    }
    return _tableView;
}


@end

