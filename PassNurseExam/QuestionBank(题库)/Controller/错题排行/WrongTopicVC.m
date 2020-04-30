//
//  WrongTopicVC.m
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "WrongTopicVC.h"
#import "WrongTopicCell.h"
#import "WrongRenewVC.h"

static NSString * const WrongTopicCellIdentifier = @"WrongTopicCellIdentifier";

@interface WrongTopicVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) WrongRankingModel *model;

@end

@implementation WrongTopicVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    @weakify(self);
    
    [[URCommonApiManager  sharedInstance] getWrongTopicListDataWithSubjectID:self.secondaryClassificationID?:@"" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self) ;
        
        self.model = response;
        
        [self.tableView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

//收藏题目
- (void)collectQuestion:(WrongRankingDataModel *)questionModel index:(NSIndexPath *)indexPath
{
    
    [[URCommonApiManager sharedInstance] unitExercisesCollectWithID:questionModel.idStr type:@"unit" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        if ([responseDict[@"data"] integerValue] == 1)
        {
            [URToastHelper  showErrorWithStatus:@"收藏成功"] ;
            questionModel.collected = @"1";
        }else
        {
            [URToastHelper  showErrorWithStatus:@"取消收藏"] ;
            questionModel.collected = @"0";
        }
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cSuperTitle = @"错题排行";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(URSafeAreaNavHeight(), 0, 0, 0));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WrongTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:WrongTopicCellIdentifier];
    WrongRankingDataModel *model = self.model.data[indexPath.row];

    cell.nameLb.text = model.title;
    
    //错误率
    NSString *errRate = [NSString stringWithFormat:@"%.0f%%",[model.error_count floatValue]/[model.finished_count floatValue]];
    NSString *errRateStr = [NSString stringWithFormat:@"错误率%.0f%%",[model.error_count floatValue]/[model.finished_count floatValue]];
    NSMutableAttributedString *rateAtrstr = [NSMutableAttributedString ur_changeColorWithColor:UR_ColorFromValue(0xFF7979) totalString:errRateStr subStringArray:@[errRate]];
    [cell.wrongrateBtn setAttributedTitle:rateAtrstr forState:UIControlStateNormal];
   
    
    //已做人数
    NSString *numStr = [NSString stringWithFormat:@"%@人已做",model.finished_count];
    NSMutableAttributedString *numAtrstr = [NSMutableAttributedString ur_changeColorWithColor:UR_ColorFromValue(0xFF7979) totalString:numStr subStringArray:@[model.finished_count]];
    [cell.finishedNumberBtn setAttributedTitle:numAtrstr forState:UIControlStateNormal];
    
    //收藏按钮
    cell.collectBtn.selected = [model.collected boolValue];
    
    [[[cell.collectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        
        [self collectQuestion:model index:indexPath];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WrongRenewVC * vc = [[WrongRenewVC  alloc] init];
    vc.hidesBottomBarWhenPushed = YES ;
    vc.type = 1 ;
    vc.dataModel = self.model.data[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage  imageNamed:@"empty_noorder"] ;
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSDictionary * attributeDict = @{
                                     NSFontAttributeName:RegularFont(17.0f) ,
                                     NSForegroundColorAttributeName:UR_ColorFromValue(0x666666)
                                     };
    
    return [[NSAttributedString  alloc] initWithString:@"暂无数据" attributes:attributeDict];
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self ;
        _tableView.emptyDataSetSource = self ;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.rowHeight = 95 * AUTO_WIDTH;
        _tableView.separatorColor = UR_COLOR_LINE;
        _tableView.separatorInset = UIEdgeInsetsZero;
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
        [_tableView registerClass:[WrongTopicCell class] forCellReuseIdentifier:WrongTopicCellIdentifier];
    }
    return _tableView;
}
@end
