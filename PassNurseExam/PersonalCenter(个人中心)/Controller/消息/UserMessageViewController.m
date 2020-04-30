//
//  UserMessageViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/10/1.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserMessageViewController.h"
#import "UserMessageTableViewCell.h"


@interface UserMessageViewController ()<TYTabPagerViewDataSource, TYTabPagerViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) TYTabPagerView *pagerView;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) MineMessageModel * messageModel;

@property (nonatomic,assign) NSInteger  selectedIndex;


@end

@implementation UserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"消息通知" ;
    
    self.datas = @[@"班级通知",@"系统通知"] ;
    
    [self addTabPagerView];
    
    [self.view  addSubview:self.tableView];
    [self.tableView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(URSafeAreaNavHeight()+35) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()-35));
    }];

    @weakify(self) ;
    [[URCommonApiManager  sharedInstance] sendRequestGetMineMessageDataWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self) ;
        
        self.messageModel = response ;
        
        [self.tableView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, URSafeAreaNavHeight(), URScreenWidth(),42);
}

- (void)addTabPagerView {
    TYTabPagerView *pagerView = [[TYTabPagerView alloc]init];
    pagerView.tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    pagerView.backgroundColor = UR_ColorFromValue(0xffffff) ;
    pagerView.tabBar.layout.normalTextFont = RegularFont(FontSize16) ;
    pagerView.tabBar.layout.selectedTextFont = RegularFont(FontSize16) ;
    pagerView.tabBar.layout.selectedTextColor = UR_ColorFromValue(0xFF8500) ;
    pagerView.tabBar.progressView.backgroundColor = UR_ColorFromValue(0xFF8500);
    pagerView.tabBar.layout.cellSpacing = 0 ;
    pagerView.pageView.scrollView.scrollEnabled = NO ;
    pagerView.tabBar.layout.cellWidth = URScreenWidth()/2 ;
    pagerView.tabBar.layout.progressWidth = 100 ;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    [self.view addSubview:pagerView];
    _pagerView = pagerView;
    [_pagerView  reloadData];
}

#pragma mark - TYTabPagerViewDataSource
- (NSInteger)numberOfViewsInTabPagerView {
    return _datas.count;
}

- (UIView *)tabPagerView:(TYTabPagerView *)tabPagerView viewForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    
    UIView *view = [[UIView alloc]initWithFrame:[tabPagerView.layout frameForItemAtIndex:index]];
    
    return view;
}

- (NSString *)tabPagerView:(TYTabPagerView *)tabPagerView titleForIndex:(NSInteger)index {

    NSString *title = _datas[index];
    
    return title;
}

- (void)tabPagerView:(TYTabPagerView *)tabPagerView didSelectTabBarItemAtIndex:(NSInteger)index
{
    self.selectedIndex = index ;

    [self.tableView reloadData];
}
#pragma  mark -- UITableViewDataSource/UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.selectedIndex==0?self.messageModel.data.count:self.messageModel.data1.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserMessageTableViewCell * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"UserMessageTableViewCellID"] ;
    if (!tableViewCell) {
        tableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"UserMessageTableViewCell" owner:self options:nil][0];
        tableViewCell.selectionStyle =  UITableViewCellSelectionStyleNone ;
    }
    
    if (self.selectedIndex==0) {
        tableViewCell.model = self.messageModel.data[indexPath.row] ;
    } else {
        tableViewCell.model = self.messageModel.data1[indexPath.row] ;
    }
    
    return tableViewCell ;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView  alloc] init];
    headerView.backgroundColor = UR_ColorFromValue(0xeeeeee) ;

    return headerView ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01 ;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_ColorFromValue(0xffffff);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
