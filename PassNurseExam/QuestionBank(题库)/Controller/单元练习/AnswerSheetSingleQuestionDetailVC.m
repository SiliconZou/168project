//
//  AnswerSheetSingleQuestionDetailVC.m
//  PassNurseExam
//
//  Created by qc on 2019/9/30.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "AnswerSheetSingleQuestionDetailVC.h"
//cell
#import "UnitPracticeDetailQuestionTopicCell.h"
#import "UnitPracticeDetailQuestionContentCell.h"
#import "UnitPracticeDetailImgOrVideoCell.h"
#import "UnitPracticeDetailOptionsCell.h"
#import "UnitPracticeDetailAnswerKeysCell.h"

static NSString * const UnitPracticeDetailTopicCellIdentifier = @"UnitPracticeDetailTopicCellIdentifier";
static NSString * const UnitPracticeDetailImgOrVideoCellIdentifier = @"UnitPracticeDetailImgOrVideoCellIdentifier";
static NSString * const UnitPracticeDetailQuestionContentCellIdentifier = @"UnitPracticeDetailQuestionContentCellIdentifier";
static NSString * const UnitPracticeDetailOptionsCellIdentifier = @"UnitPracticeDetailOptionsCellIdentifier";
static NSString * const UnitPracticeDetailAnswerKeysCellIdentifier = @"UnitPracticeDetailAnswerKeysCellIdentifier";


@interface AnswerSheetSingleQuestionDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *noTitles;
@property (nonatomic, strong) ZFPlayerController *questionsPlayer;

@end

@implementation AnswerSheetSingleQuestionDetailVC

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
    self.cViewNav.hidden = YES;
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.closeBtn];
    [self.bgView addSubview:self.tableView];

    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = YES;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(320 * AUTO_WIDTH, 480 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).offset(URSafeAreaNavHeight()/2.0);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(50 * AUTO_WIDTH, 45 * AUTO_WIDTH));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.top.mas_equalTo(self.closeBtn.mas_bottom);
    }];
    
    self.bgView.transform = CGAffineTransformMakeScale(0.8, 0.8);

    [[self.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismiss];
    }];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.transform = CGAffineTransformMakeScale(1, 1);
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }];
}

- (void)dismiss
{    
    [self.view removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.unitQuestionModel.picture.length > 0 || self.unitQuestionModel.video.length > 0)
        {
            return 3;
        }
        return 2;
    }
    return section == 1 ? self.unitQuestionModel.options.count : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnitPracticeDetailDataModel *dataModel = self.unitQuestionModel;
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
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

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = NORMAL_COLOR;//UR_ColorFromValue(0x59A2FF);
    }
    return _bgView;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton ImgBtnWithImageName:@"guanbi"];
    }
    return _closeBtn;
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
        
        [_tableView registerClass:[UnitPracticeDetailQuestionTopicCell class] forCellReuseIdentifier:UnitPracticeDetailTopicCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailImgOrVideoCell class] forCellReuseIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailQuestionContentCell class] forCellReuseIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailOptionsCell class] forCellReuseIdentifier:UnitPracticeDetailOptionsCellIdentifier];
        [_tableView registerClass:[UnitPracticeDetailAnswerKeysCell class] forCellReuseIdentifier:UnitPracticeDetailAnswerKeysCellIdentifier];
    }
    return _tableView;
}


@end
