//
//  DailyQuestionsDetailViewController.m
//  PassNurseExam
//
//  Created by qc on 15/9/2019.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "DailyQuestionsDetailViewController.h"
#import "DailyQuestionsDetailTopTableViewCell.h"
#import "UnitPracticeDetailOptionsCell.h"
#import "UnitPracticeDetailBtnCell.h"
#import "UnitPracticeDetailImgOrVideoCell.h"
#import "UnitPracticeDetailQuestionContentCell.h"
#import "ImgVideoQuestionBankAnalysisTableViewCell.h"

static NSString * const DailyQuestionsDetailTopTableViewCellIdentifier = @"DailyQuestionsDetailTopTableViewCellIdentifier";
static NSString * const UnitPracticeDetailImgOrVideoCellIdentifier = @"UnitPracticeDetailImgOrVideoCellIdentifier";
static NSString * const UnitPracticeDetailQuestionContentCellIdentifier = @"UnitPracticeDetailQuestionContentCellIdentifier";
static NSString * const UnitPracticeDetailOptionsCellIdentifier = @"UnitPracticeDetailOptionsCellIdentifier";
static NSString * const UnitPracticeDetailBtnCellIdentifier = @"UnitPracticeDetailBtnCellIdentifier";
static NSString * const ImgVideoQuestionBankAnalysisTableViewCellIdentifier = @"ImgVideoQuestionBankAnalysisTableViewCellIdentifier";

@interface DailyQuestionsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray *noTitles;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerController *questionsPlayer;

@end

@implementation DailyQuestionsDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.questionsPlayer.viewControllerDisappear = NO;
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
    self.questionsPlayer.viewControllerDisappear = YES ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noTitles = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    
    self.lblTitle.text = @"每日真题" ;
    [self.cBtnRight setImage:[UIImage  imageNamed:@"NewShare"] forState:UIControlStateNormal];
    self.cBtnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -44 * AUTO_WIDTH) ;

    [self.view  addSubview:self.tableView];
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(URSafeAreaNavHeight());
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()));
     }];
    
}

-(void)navLeftPressed {
    if (self.isPush) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)navRightPressed:(id)sender{
    
    URSharedView * sharedView= [[URSharedView  alloc] init];
//    URSharedModel * shareModel = [[URSharedModel alloc] init];
//    shareModel.url = [NSString  stringWithFormat:@"%@",URShareURL] ;
//    shareModel.thumbImage =@"headimg" ;
//    shareModel.title = @"掌上北京医院" ;
//    shareModel.descr = @"推荐168网校给好友，邀请好友得奖励" ;
//    [sharedView  urShowShareViewWithDXShareModel:shareModel shareContentType:URShareContentTypeImage];
    NSDictionary *shareInfo = @{@"title":@"168网校-每日真题",@"descr":@"",@"shareUrl":@"https://www.baidu.com",@"path":@"pages/logs/logs",@"userName":@"gh_a8bc08217cb8",@"imgName":@"zhenti"};
    [sharedView shareMiniProgramWithDict:shareInfo];
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
    
    [[URCommonApiManager sharedInstance] commitQuestionWithRecord:recordId type:@"daily_topic" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" info:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        [URToastHelper showErrorWithStatus:@"提交成功"];
        self.dataModel.finished = @"1";
        if ([optionStr isEqualToString:self.dataModel.answer])
        {
            //成功的话
            [URToastHelper showErrorWithStatus:@"恭喜你，回答正确！"];
            
        }else
        {
            //错误，展示答题解析
            [URToastHelper showErrorWithStatus:@"回答错误，请查看答案解析！"];
            self.dataModel.showAnswerKeys = YES;
        }
        [self.tableView reloadData];
        
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
            DailyQuestionsDetailTopTableViewCell * cell = [tableView  dequeueReusableCellWithIdentifier:DailyQuestionsDetailTopTableViewCellIdentifier];

            NSString * typeStr ;
            
            if (self.dataModel.type.integerValue==1) {
                typeStr = @"【单选题】" ;
            } else if (self.dataModel.type.integerValue==2){
                typeStr = @"【多选题】" ;
            } else if (self.dataModel.type.integerValue==3){
                typeStr = @"【判断题】" ;
            }
            
            cell.topicLb.text = [NSString  stringWithFormat:@"%@%@题型",typeStr,self.dataModel.question_type?:@""];
            cell.timeLabel.text = [NSString  stringWithFormat:@"%@",self.dataModel.qs_time?:@""];
            cell.nameLb.text = [NSString  stringWithFormat:@"(%@)每日真题",self.dataModel.subject_name?:@""];
            
            return cell;
        }
        else if (indexPath.row == [self.tableView numberOfRowsInSection:0]-1)
        {
            UnitPracticeDetailQuestionContentCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
            cell.questionContentLb.text = self.dataModel.title;
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
        
        [cell.rightBtn setTitle:[self.dataModel.finished boolValue] == YES ? @"返回" : @"提交" forState:UIControlStateNormal];
        
        @weakify(self);
        [[[cell.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            @strongify(self);
            self.dataModel.showAnswerKeys = !self.dataModel.showAnswerKeys;
            
            if (self.dataModel.showAnswerKeys == NO) {
                [self.player  stop];
            }
            
            [self.tableView reloadData];
        }];
        
        [[[cell.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            
            if ([self.dataModel.finished boolValue] == YES)//返回
            {
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                [self commitResult];//提交
            }
        }];
        
        return cell;
    }
    else if (indexPath.section == 3)
    {
        ImgVideoQuestionBankAnalysisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ImgVideoQuestionBankAnalysisTableViewCellIdentifier];
        
        if (self.dataModel.answer.length > 0)
        {
            NSString *answerStr = @"参考答案：";
            
//            for (int i = 0; i < self.dataModel.answer.length; i++)
//            {
//                //答案是从 1/2/3/4/5/6 开始编号，对应 A/B/C/D/E/F
//                NSInteger index = [[self.dataModel.answer substringWithRange:NSMakeRange(i, 1)] integerValue]-1;
//                answerStr = [answerStr stringByAppendingString:self.noTitles[index]];
//            }
            cell.titleLb.text = [answerStr stringByAppendingString:self.dataModel.answer];
        }
        cell.contentLb.text = self.dataModel.analysis ?: @"";
        cell.starsView.value = [self.dataModel.difficulty floatValue];
       
        if ([NSString isBlankString:self.dataModel.video_analysis] == NO) {
            cell.currentPlayURL = self.dataModel.video_analysis;
        }
        self.player = cell.player ;
        
        [[cell.playBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.questionsPlayer stop];
        }];
        return cell;
    }
    return [UITableViewCell new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && [self.dataModel.finished boolValue] == NO)
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
            for (int i = 0; i < self.dataModel.options.count; i++)
            {
                OptionsModel *option = self.dataModel.options[i];
                option.selected = !option.selected;
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        } else { }
    }
}

- (UITableView *)tableView{
    
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
        [_tableView registerClass:[DailyQuestionsDetailTopTableViewCell class] forCellReuseIdentifier:DailyQuestionsDetailTopTableViewCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailQuestionContentCell class] forCellReuseIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailImgOrVideoCell class] forCellReuseIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];
        [_tableView registerClass:[ImgVideoQuestionBankAnalysisTableViewCell class] forCellReuseIdentifier:ImgVideoQuestionBankAnalysisTableViewCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailBtnCell class] forCellReuseIdentifier:UnitPracticeDetailBtnCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailOptionsCell class] forCellReuseIdentifier:UnitPracticeDetailOptionsCellIdentifier];
    }
    return _tableView;
}


-(UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen || self.questionsPlayer.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return NO;
}

- (BOOL)shouldAutorotate {
    if (self.player.isFullScreen || self.questionsPlayer.isFullScreen) {
        return YES;
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen || self.questionsPlayer.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

//#pragma mark - UIScrollViewDelegate 列表播放必须实现
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [scrollView zf_scrollViewDidEndDecelerating];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
//}
//
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
//    [scrollView zf_scrollViewDidScrollToTop];
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [scrollView zf_scrollViewDidScroll];
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [scrollView zf_scrollViewWillBeginDragging];
//}


@end
