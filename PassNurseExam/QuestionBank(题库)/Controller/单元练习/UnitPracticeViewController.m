//
//  UnitPracticeViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeViewController.h"
#import "UnitPracticeTableViewCell.h"
#import "UnitAlertView.h"
#import "UnitPracticeDetailViewController.h"

@interface UnitPracticeViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic ,strong) UnitPracticeModel * model ;

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation UnitPracticeViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    @weakify(self);
    
    [[URCommonApiManager  sharedInstance] getUnitExerciseListDataWithSubjectID:self.secondaryClassificationID?:@"" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
     
        @strongify(self) ;
        
        self.model = response ;
        
        [self.tableView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"历年真题";
    
    [self.view  addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(URSafeAreaNavHeight());
        make.left.mas_equalTo(0) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()));
    }];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.data.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UnitPracticeTableViewCell * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"UnitPracticeTableViewCellID"] ;
    
    if (!tableViewCell) {
        tableViewCell = [[NSBundle   mainBundle] loadNibNamed:@"UnitPracticeTableViewCell" owner:self options:nil][0] ;
        
    }
    
    tableViewCell.dataModel = self.model.data[indexPath.row] ;
    
    return tableViewCell ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (userLoginStatus == NO) {
        
        [self  presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
        
    } else {
        if (self.model.data[indexPath.row].count.integerValue>0) {
            UnitAlertView *alert = [[UnitAlertView alloc] init];
            [[UIApplication sharedApplication].keyWindow addSubview:alert];
            
            @weakify(self) ;
            //1顺序 2随机
            alert.sSelectTypeBlock = ^(NSInteger tag) {
                
                @strongify(self) ;
                
                UnitPracticeDetailViewController * detailViewController =[[UnitPracticeDetailViewController  alloc] init];
                detailViewController.type = [NSString  stringWithFormat:@"%ld",(long)tag] ;
                
                detailViewController.questionBankModel = self.model.data[indexPath.row];
                
                [self.navigationController pushViewController:detailViewController animated:YES];
            };
        } else {
            
            [URToastHelper  showErrorWithStatus:@"请选择其他题目"] ;
        }
    }
    
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

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView  alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = UR_ColorFromValue(0xffffff) ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0) ;
        
        _tableView.estimatedRowHeight = 44.0f ;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO ;
#pragma clang diagnostic pop
        }
    }
    return _tableView ;
}

@end
