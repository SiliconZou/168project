//
//  HomePageNewsInforViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "HomePageNewsInforViewController.h"
#import "HomePageNavView.h"
#import "PYSearchViewController.h"
#import "UserCollectionViewController.h"

@interface HomePageNewsInforViewController ()<SDCycleScrollViewDelegate,TYTabPagerViewDataSource, TYTabPagerViewDelegate,UITableViewDelegate,UITableViewDataSource,PYSearchViewControllerDelegate>

@property (nonatomic ,strong) HomePageNewsInforModel * newsInforModel ;

@property (nonatomic ,strong) SDCycleScrollView * cycleScrollView ;

@property (nonatomic ,strong) NSMutableArray * cycleArray ;

@property (nonatomic, strong) TYTabPagerView * pagerView;

@property (nonatomic ,strong) UITableView * tableView ;

@property (nonatomic ,strong) NSMutableArray * newsInforArray ;

@property (nonatomic ,assign) NSInteger  pageIndex  ;

@property (nonatomic ,copy) NSString *  categoryID  ;

@property (nonatomic,strong) HomePageNavView *navView;



@end

@implementation HomePageNewsInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageIndex = 1  ;
    
    self.categoryID = @"0" ;
    
    self.view.backgroundColor = UR_ColorFromValue(0xffffff) ;
    
    self.cycleArray = [NSMutableArray   arrayWithCapacity:0] ;
    [self.cBtnRight setTitle:@"我的收藏" forState:UIControlStateNormal];
    [self.cBtnRight.titleLabel setFont:[UIFont systemFontOfSize:15]];
    UIButton * searchButton = [[UIButton  alloc] init] ;
    [searchButton  setImage:[UIImage  imageNamed:@"searchBj"] forState:UIControlStateNormal];
    searchButton.imageView.contentMode = UIViewContentModeScaleAspectFit ;
    [self.cViewNav  addSubview:searchButton];
    [searchButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(70*AUTO_WIDTH) ;
        make.top.mas_equalTo(URSafeAreaStateHeight()+6) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-140, 32*AUTO_WIDTH));
    }];
    [[searchButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSArray *hotSeaches = @[@"2019真题", @"2019护考准考证", @"2019护考重点", @"2019护士招聘，西安医院"];
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入搜索的内容" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            
            if ([NSString  isBlank:searchText]) {
                [URToastHelper  showErrorWithStatus:@"请输入搜索内容"] ;
            } else {
                HomePageSearchViewController * searchViewController = [[HomePageSearchViewController  alloc] init];
                searchViewController.searchStr = searchText ;
                
                [self.navigationController pushViewController:searchViewController animated:YES];
            }
            
        }];
        searchViewController.hotSearchStyle = PYHotSearchStyleBorderTag;
        searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag;
        searchViewController.searchBarCornerRadius = 15.0f ;
        searchViewController.delegate = self;
        searchViewController.hidesBottomBarWhenPushed = YES ;
        searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
        [self.navigationController pushViewController:searchViewController animated:YES];
        
    }];
    
    [self.view  addSubview:self.tableView];
    self.tableView.tableHeaderView = self.cycleScrollView ;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(URSafeAreaNavHeight());
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight())) ;
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
        [self  loadMoreData] ;
    }] ;
    
    @weakify(self) ;
    
    [[URCommonApiManager   sharedInstance] sendArticleSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self) ;
        
        self.newsInforModel = response ;
        
        self.newsInforArray = (NSMutableArray *)self.newsInforModel.firstClassArticleList ;
        
        [self.newsInforModel.nav  enumerateObjectsUsingBlock:^(HomePageNewsInforNavModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cycleArray  addObject:obj.thumb?:@""];
        }];
        
        if (self.cycleArray.count>0) {
            self.cycleScrollView.imageURLStringsGroup = self.cycleArray ;
        }
        
        if (self.newsInforModel.classList.count>0) {
            HomePageNewsInforClassListModel * model = [[HomePageNewsInforClassListModel alloc] init];
            [model setCategory_name:@"最新资讯"];
            [model setCategory_id:@"0"];
            
            [self.newsInforModel.classList  insertObject:model atIndex:0];

        }
        
        self.pagerView.tabBar.layout.progressWidth = URScreenWidth()/self.newsInforModel.classList.count-10 ;
        self.pagerView.tabBar.layout.cellWidth = URScreenWidth()/self.newsInforModel.classList.count ;
        [self.pagerView  reloadData];
        
        [self.tableView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

-(void)navRightPressed:(id)sender {
    NSLog(@"我的收藏");
    UserCollectionViewController *collectVC = [[UserCollectionViewController alloc] init];
    collectVC.isNewsCollect = YES;
    [self.navigationController pushViewController:collectVC animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSString * linkURL  = self.newsInforModel.nav[index].url ;
    
    if ([NSString isBlank:linkURL]==NO) {
        URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:linkURL];
        wkWebViewController.itemTitle = @"" ;
        [self.navigationController pushViewController:wkWebViewController animated:NO];
    }
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            //            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
            //                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
            //                [searchSuggestionsM addObject:searchSuggestion];
            //            }
            //            // Refresh and display the search suggustions
            //            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark - TYTabPagerViewDataSource
- (NSInteger)numberOfViewsInTabPagerView {
    return self.newsInforModel.classList.count;
}

- (UIView *)tabPagerView:(TYTabPagerView *)tabPagerView viewForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    UIView *view = [[UIView alloc]initWithFrame:[tabPagerView.layout frameForItemAtIndex:index]];
    return view;
}

- (NSString *)tabPagerView:(TYTabPagerView *)tabPagerView titleForIndex:(NSInteger)index {
    
    return self.newsInforModel.classList[index].category_name;
}

- (void)tabPagerView:(TYTabPagerView *)tabPagerView didSelectTabBarItemAtIndex:(NSInteger)index{
    
    self.pageIndex = 0;
    
    self.categoryID = [NSString  stringWithFormat:@"%@",self.newsInforModel.classList[index].category_id?:@""] ;
    
    [self.newsInforArray  removeAllObjects];
    
    [self loadMoreData];
    
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsInforArray.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomePageNewsInforTableViewCell * newsInforTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageNewsInforTableViewCellID"] ;
    if (!newsInforTableViewCell) {
        newsInforTableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"HomePageNewsInforTableViewCell" owner:self options:nil][0] ;
        newsInforTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    
    newsInforTableViewCell.model = self.newsInforArray[indexPath.row] ;
    
    return newsInforTableViewCell ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row==self.newsInforArray.count-1?113:119 ;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView = [[UIView  alloc] init];
    headerView.backgroundColor = [UIColor  whiteColor] ;
    
    [headerView addSubview:self.pagerView];
    [self.pagerView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 40));
    }];
    
    UIView * lineView = [[UIView  alloc] init];
    lineView.backgroundColor = UR_ColorFromValue(0xDDDDDD);
    [headerView  addSubview:lineView];
    [lineView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 1));
    }];
                             
    return headerView ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 41 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * linkURL  ;
    
    if ([self.newsInforArray[indexPath.row] isKindOfClass:[HomePageNewsInforFirstClassArticleListModel  class]]) {
        HomePageNewsInforFirstClassArticleListModel * listModel = self.newsInforArray[indexPath.row] ;
        linkURL = [NSString  stringWithFormat:@"%@",listModel.url?:@""] ;
    } else if ([self.newsInforArray[indexPath.row] isKindOfClass:[HomePageNewsInforMoreListModel  class]]) {
        HomePageNewsInforMoreListModel * moreListModel = self.newsInforArray[indexPath.row] ;
        linkURL = [NSString  stringWithFormat:@"%@",moreListModel.url?:@""] ;
    }
    
    if ([NSString isBlank:linkURL]==NO) {
        URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:linkURL];
        wkWebViewController.hidesBottomBarWhenPushed = YES ;
        wkWebViewController.itemTitle = @"" ;
        wkWebViewController.isNews = YES;
        [self.navigationController pushViewController:wkWebViewController animated:NO];
    }
}

-(void)navLeftPressed{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)loadMoreData{
    
    WEAKSELF(self);
    
    [[URCommonApiManager   sharedInstance] getNewsInforListDataWithPage:[NSString  stringWithFormat:@"%ld",self.pageIndex+1] categoryID:self.categoryID requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        HomePageNewsInforMoreModel * model = response ;
        
        [self.newsInforArray  addObjectsFromArray:model.data];
        
        [weakSelf.tableView reloadData];
        weakSelf.pageIndex++;
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } requestFailureBlock:^(NSError *error, id response) {
        [weakSelf.tableView.mj_footer endRefreshing];

    }];
    
}

#pragma mark - Lazy Init

-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        NSArray *imageNames = @[
                                @"banner",
                                @"banner"
                                ];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, URSafeAreaNavHeight(), URScreenWidth(), 146 *(URScreenWidth()/375)) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        _cycleScrollView.autoScrollTimeInterval = 3.0;
        _cycleScrollView.delegate = self ;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter ;
    }
    return _cycleScrollView ;
}

-(TYTabPagerView *)pagerView{
    if (!_pagerView) {
        _pagerView = [[TYTabPagerView alloc]init];
        _pagerView.backgroundColor = UR_ColorFromValue(0xffffff) ;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        _pagerView.tabBar.layout.selectedTextColor = UR_ColorFromValue(0x333333);
        _pagerView.tabBar.layout.progressColor = UR_ColorFromValue(0x9B89FF);
        _pagerView.tabBar.layout.progressHeight = 3.0f ;
        _pagerView.tabBar.layout.normalTextFont = RegularFont(16.0f) ;
        _pagerView.tabBar.layout.selectedTextFont = RegularFont(16.0f) ;
    }
    return _pagerView ;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView  alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = UR_ColorFromValue(0xffffff) ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 44.0f ;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
    }
    return _tableView ;
}

-(HomePageNavView *)navView
{
    if (!_navView) {
        _navView = [[HomePageNavView alloc] init];
        _navView.addBtn.hidden = YES ;
        _navView.scanBtn.hidden = YES ;
        _navView.channelBtn.hidden = YES ;
    }
    return _navView;
}


@end
