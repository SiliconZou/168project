//
//  UserCollectionViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/10/1.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserCollectionViewController.h"
#import "UserCollectionTableViewCell.h"
#import "WrongRenewVC.h"
#import "HomePageNewsInforModel.h"
@interface UserCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) CourseHomeMenuView *menu;
@property (nonatomic ,strong) HomePageNewsInforModel * newsInforModel ;
@property (nonatomic,strong) QuestionClassificationModel * model;
@property (nonatomic,strong) WrongRankingModel * collectionModel;
@property (nonatomic ,strong) NSString * courseID ;
@property (nonatomic ,strong) NSMutableArray * newsInforArray ;
@end

@implementation UserCollectionViewController {
    CGFloat menu_h;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    @weakify(self);
    if (_isNewsCollect) {
        
        [self getListData];
    } else {
        
        [[URCommonApiManager  sharedInstance] getQuestionClassificationDataWithRequestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
            @strongify(self);
            
            self.model = response ;
            
            self.courseID = [NSString  stringWithFormat:@"%@",self.model.data[0].subjects[0].idStr] ;
            
            [self  getListData] ;
            
            [self.tableView reloadData];
            
        } requestFailureBlock:^(NSError *error, id response) {
            
        }] ;
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isNewsCollect) {
        menu_h = 0;
        self.lblTitle.text = @"我的资讯收藏";
    } else {
        self.lblTitle.text = @"考题收藏" ;
    }
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _isNewsCollect == YES ? self.newsInforArray.count : self.collectionModel.data.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.menu.menuArr = self.model.data;
    
    @weakify(self);
    
    self.menu.selectMenuBlcok = ^(QuestionClassificationTitleModel *  _Nonnull menu1Model, QuestionClassificationSubTitleModel *  _Nonnull menu2Model) {
        
        @strongify(self);
        
        self.courseID = [NSString  stringWithFormat:@"%@",menu2Model.idStr?:@""] ;
        
        [self   getListData] ;
        
        //要重新请求，重新刷新
        [self.tableView reloadData];
    } ;
    
    return self.menu;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isNewsCollect) {
        HomePageNewsInforTableViewCell * newsInforTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageNewsInforTableViewCellID"] ;
        if (!newsInforTableViewCell) {
            newsInforTableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"HomePageNewsInforTableViewCell" owner:self options:nil][0] ;
            newsInforTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
        }
        
        newsInforTableViewCell.model = self.newsInforArray[indexPath.row] ;
        
        return newsInforTableViewCell;
    } else {
        UserCollectionTableViewCell * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"UserCollectionTableViewCellID"] ;
        
        if (!tableViewCell) {
            tableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"UserCollectionTableViewCell" owner:self options:nil][0] ;
        }
        
        tableViewCell.dataModel =  self.collectionModel.data[indexPath.row] ;
        
        return tableViewCell ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    QuestionClassificationTitleModel *menu1Model = self.model.data[self.menu.menu1Index];
    
    CGFloat height = _isNewsCollect ? 0 : menu1Model.subjects.count == 0 ? (50 * AUTO_WIDTH + 1) : (50 * 2 * AUTO_WIDTH + 1)+3;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isNewsCollect) {
        NSString *linkUrl = self.newsInforArray[indexPath.row][@"url"];
        URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:linkUrl];
        wkWebViewController.hidesBottomBarWhenPushed = YES ;
        wkWebViewController.itemTitle = @"" ;
        wkWebViewController.isNews = NO;
        [self.navigationController pushViewController:wkWebViewController animated:NO];
    } else {
        WrongRenewVC * vc = [[WrongRenewVC  alloc] init];
        vc.hidesBottomBarWhenPushed = YES ;
        vc.type = 2 ;
        vc.dataModel = self.collectionModel.data[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
    
}

-(void)getListData{
    if (_isNewsCollect) {
        [[URCommonApiManager sharedInstance] getCollectArcitleListWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            self.newsInforArray = (NSMutableArray *)responseDict[@"data"][@"data"] ;
            [self.tableView reloadData];
        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
    } else {
        [[URCommonApiManager  sharedInstance] sendGetExaminationQuestionsCollectionRequestWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" subjectID:self.courseID requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
            self.collectionModel  = response ;

            [self.tableView  reloadData];
            
        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
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

- (CourseHomeMenuView *)menu
{
    if (!_menu) {
        _menu = [[CourseHomeMenuView alloc] initWithFrame:CGRectMake(0, 0, URScreenWidth(), 50 * 2 * AUTO_WIDTH + 1)];
    }
    return _menu;
}



@end
