
//
//  ImgVideoQuestionBankVC.m
//  PassNurseExam
//
//  Created by qc on 2019/9/20.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "ImgVideoQuestionBankVC.h"
#import "UnitPracticeDetailQuestionContentCell.h"
#import "UnitPracticeDetailOptionsCell.h"
#import "UnitPracticeDetailBtnCell.h"
#import "UnitPracticeDetailImgOrVideoCell.h"
#import "ImgVideoQuestionBankTopicCell.h"
#import "ImgVideoQuestionBankAnalysisTableViewCell.h"

static NSString * const UnitPracticeDetailQuestionContentCellIdentifier = @"UnitPracticeDetailQuestionContentCellIdentifier";
static NSString * const UnitPracticeDetailImgOrVideoCellIdentifier = @"UnitPracticeDetailImgOrVideoCellIdentifier";
static NSString * const ImgVideoQuestionBankTopicCellIdentifier = @"ImgVideoQuestionBankTopicCellIdentifier";
static NSString * const UnitPracticeDetailOptionsCellIdentifier = @"UnitPracticeDetailOptionsCellIdentifier";
static NSString * const UnitPracticeDetailBtnCellIdentifier = @"UnitPracticeDetailBtnCellIdentifier";
static NSString * const ImgVideoQuestionBankAnalysisTableViewCellIdentifier = @"ImgVideoQuestionBankAnalysisTableViewCellIdentifier";

@interface ImgVideoQuestionBankVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView * tableView ;
@property (nonatomic,strong) NSArray *noTitles;
@property (nonatomic,strong) QuestionPhotoVideoDataModel *photoVideoModel;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerController *questionsPlayer;


@end
 
@implementation ImgVideoQuestionBankVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.player.viewControllerDisappear = NO;
    self.questionsPlayer.viewControllerDisappear = NO;
    
    [self requestData];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.player.viewControllerDisappear = YES;
    self.questionsPlayer.viewControllerDisappear = YES ;
}

- (void)requestData
{
    @weakify(self) ;
    [[URCommonApiManager  sharedInstance] getMediaQuestionDataWithType:[NSString  stringWithFormat:@"%@",self.type] subjectID:self.subjectID token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self) ;
        
        self.photoVideoModel = response;
        [self.tableView reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noTitles = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    
    self.lblTitle.text = self.type.integerValue==1?@"考前密题":@"视频题库" ;
    
    [self.cBtnRight setImage:[UIImage  imageNamed:@"NewShare"] forState:UIControlStateNormal];
    self.cBtnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -44 * AUTO_WIDTH) ;
    
    [self.view  addSubview:self.tableView];
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(URSafeAreaNavHeight());
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()));
    }];
}

-(void)navRightPressed:(id)sender{
    
    URSharedView * sharedView= [[URSharedView  alloc] init];
    URSharedModel * shareModel = [[URSharedModel alloc] init];
    shareModel.url = [NSString  stringWithFormat:@"%@",URShareURL] ;
    shareModel.thumbImage =@"headimg" ;
    shareModel.title = @"掌上北京医院" ;
    shareModel.descr = @"推荐168网校给好友，邀请好友得奖励" ;
    [sharedView  urShowShareViewWithDXShareModel:shareModel shareContentType:URShareContentTypeImage];
}


//提交结果
- (void)commitResult
{
    //数据处理
    NSMutableArray *resultArr = [NSMutableArray array];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // id：题id
    dic[@"id"] = self.photoVideoModel.idStr;
    
    //option：选择的答案
    NSString *optionStr = @"";
    for (int j = 0; j < self.photoVideoModel.options.count; j++)
    {
        OptionsModel *option = self.photoVideoModel.options[j];
        
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
    dic[@"wrong"] = [optionStr isEqualToString:self.photoVideoModel.answer] ? @"1" : @"2";
    
    [resultArr addObject:dic];
    
    //数组转json
    NSError *error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:resultArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *recordId = [[NSString alloc] initWithData: jsonData encoding:NSUTF8StringEncoding];
    
    //错题排行的 type 跟 单元练习里一样，传 unit
    [[URCommonApiManager sharedInstance] commitQuestionWithRecord:recordId type:@"unit" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" info:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        [URToastHelper showErrorWithStatus:@"提交成功"];
        self.photoVideoModel.isAnswered = YES;
        
        if ([optionStr isEqualToString:self.photoVideoModel.answer]) {
            //成功的话
            [URToastHelper showErrorWithStatus:@"恭喜你，回答正确！"];
        }else {
            //错误，展示答题解析
            [URToastHelper showErrorWithStatus:@"回答错误，请查看答案解析！"];
        }
        self.photoVideoModel.showAnswerKeys = YES;
        [self.tableView reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.photoVideoModel == nil ? 0 : self.photoVideoModel.showAnswerKeys ? 4 : 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.photoVideoModel.picture.length > 0 || self.photoVideoModel.video.length > 0)
        {
            return 3;
        }
        return 2;
    }
    return section == 1 ? self.photoVideoModel.options.count : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            ImgVideoQuestionBankTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ImgVideoQuestionBankTopicCellIdentifier];
            
            if ([self.photoVideoModel.type isEqualToString:@"1"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【单选】%@题型",self.photoVideoModel.question_type];
            }else if ([self.photoVideoModel.type isEqualToString:@"2"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【多选】%@题型",self.photoVideoModel.question_type];
            }else if ([self.photoVideoModel.type isEqualToString:@"3"]) {
                cell.topicLb.text = [NSString stringWithFormat:@"【判断】%@题型",self.photoVideoModel.question_type];
            }else {
                cell.topicLb.text = @"";
            }
            return cell;
        }
        else if (indexPath.row == [self.tableView numberOfRowsInSection:0]-1)
        {
            UnitPracticeDetailQuestionContentCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
            cell.questionContentLb.text = self.photoVideoModel.title ?: @"";
            return cell;
        }
        else
        {
            //图片和视频的cell
            UnitPracticeDetailImgOrVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];
            
            if ([NSString isBlankString:self.photoVideoModel.picture] == NO) {
                cell.currentPicURL = self.photoVideoModel.picture;
            }else if ([NSString isBlankString:self.photoVideoModel.video] == NO) {
                cell.currentPlayURL = self.photoVideoModel.video;
            }
            self.questionsPlayer = cell.player;
            
            [[cell.playBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                [self.player stop];
            }];
            
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        UnitPracticeDetailOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailOptionsCellIdentifier];
        cell.noLb.text = self.noTitles[indexPath.row];
        
        OptionsModel *option = self.photoVideoModel.options[indexPath.row];
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
       
        [cell.leftBtn setTitle:@"下一题" forState:UIControlStateNormal];
        [cell.rightBtn setTitle:self.photoVideoModel.isAnswered ? @"返回" : @"提交" forState:UIControlStateNormal];
        
        cell.leftBtn.hidden = !self.photoVideoModel.isAnswered;
        [cell.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if (self.photoVideoModel.isAnswered) {
                make.right.mas_offset(-22 * AUTO_WIDTH);
            }else {
                make.right.mas_offset(-URScreenWidth()/2.0+153 * AUTO_WIDTH/2.0);
            }
        }];
        
        [[[cell.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            
            self.photoVideoModel = nil;
            [self.player stop];
            [self.questionsPlayer stop];
            [self requestData];
        }];
        
        [[[cell.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            
            if (self.photoVideoModel.isAnswered) {
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
        ImgVideoQuestionBankAnalysisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ImgVideoQuestionBankAnalysisTableViewCellIdentifier];
        if (self.photoVideoModel.answer.length > 0)
        {
            NSString *answerStr = @"参考答案：";
            
            for (int i = 0; i < self.photoVideoModel.answer.length; i++)
            {
                //答案是从 1/2/3/4/5/6 开始编号，对应 A/B/C/D/E/F
                NSInteger index = [[self.photoVideoModel.answer substringWithRange:NSMakeRange(i, 1)] integerValue]-1;
                answerStr = [answerStr stringByAppendingString:self.noTitles[index]];
            }
            cell.titleLb.text = answerStr;
        }
        cell.contentLb.text = self.photoVideoModel.analysis ?: @"";
        cell.starsView.value = [self.photoVideoModel.difficulty floatValue];
        
        if ([NSString isBlankString:self.photoVideoModel.video_analysis] == NO) {
            cell.currentPlayURL = self.photoVideoModel.video_analysis;
        }
        self.player = cell.player;
        
        [[cell.playBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.questionsPlayer stop];
        }];
        
        return cell;
    }
    return [UITableViewCell new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && self.photoVideoModel.isAnswered == NO)
    {
        if ([self.photoVideoModel.type isEqualToString:@"1"] || [self.photoVideoModel.type isEqualToString:@"3"])
        {
            for (int i = 0; i < self.photoVideoModel.options.count; i++)
            {
                OptionsModel *option = self.photoVideoModel.options[i];
                option.selected = indexPath.row == i ? YES : NO;
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
        else if ([self.photoVideoModel.type isEqualToString:@"2"])
        {
            //多选题
            OptionsModel *option = self.photoVideoModel.options[indexPath.row];
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
        [_tableView registerClass:[ImgVideoQuestionBankTopicCell class] forCellReuseIdentifier:ImgVideoQuestionBankTopicCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailImgOrVideoCell class] forCellReuseIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailQuestionContentCell class] forCellReuseIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
        [_tableView registerClass:[ImgVideoQuestionBankAnalysisTableViewCell class] forCellReuseIdentifier:ImgVideoQuestionBankAnalysisTableViewCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailBtnCell class] forCellReuseIdentifier:UnitPracticeDetailBtnCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailOptionsCell class] forCellReuseIdentifier:UnitPracticeDetailOptionsCellIdentifier];
    }
    return _tableView;
}



@end
