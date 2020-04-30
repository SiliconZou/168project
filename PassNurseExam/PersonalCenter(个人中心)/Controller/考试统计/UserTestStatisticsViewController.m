//
//  UserTestStatisticsViewController.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/9.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserTestStatisticsViewController.h"
#import "UserTestStatisticsTableViewCell.h"
#import "ConfirmPapersViewController.h"

static
@interface UserTestStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UserTestStatisticsModel *statisticsModel;

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation UserTestStatisticsViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    [[URCommonApiManager   sharedInstance] sendGetTestStatisticsDataRequestWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.statisticsModel = response ;
        
        [self.tableView reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"考试统计" ;
    
    [self.view  addSubview:self.tableView];
    
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(URSafeAreaNavHeight()) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statisticsModel.data.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserTestStatisticsTableViewCell * tableViewCell = [tableView   dequeueReusableCellWithIdentifier:@"UserTestStatisticsTableViewCellID"] ;
    
    if (!tableViewCell) {
        tableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"UserTestStatisticsTableViewCell" owner:self options:nil][0];
    }
    
    tableViewCell.dataModel = self.statisticsModel.data[indexPath.row] ;
    return tableViewCell ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 57 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[URCommonApiManager  sharedInstance] sendGetTestStatisticsDetailDataRequestWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" idStr:self.statisticsModel.data[indexPath.row].idStr?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
       
        ConfirmPapersViewController * detailViewController = [[ConfirmPapersViewController  alloc] init];
        detailViewController.type =2 ;
        detailViewController.lbTitleStr = [NSString  stringWithFormat:@"%@",self.statisticsModel.data[indexPath.row].title?:@""] ;
        detailViewController.listMdel = response;
        
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine ;
        _tableView.estimatedRowHeight = 44.0f;
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


@end
