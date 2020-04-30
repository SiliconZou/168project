//
//  HomePageSearchViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/19.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "HomePageSearchViewController.h"

@interface HomePageSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) HomeArticleSearchModel * searchModel ;

@property (nonatomic ,strong) UITableView * tableView ;


@end

@implementation HomePageSearchViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    [[URCommonApiManager  sharedInstance] getArticleSearchDataWithKeyWord:self.searchStr?:@"" page:@"1" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.searchModel = response ;
        
        [self.tableView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"搜索结果" ;
    
    [self.view  addSubview:self.tableView];
    [self.tableView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(URSafeAreaNavHeight()) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()));
    }];
    
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchModel.data.data.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomePageNewsInforTableViewCell * newsInforTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageNewsInforTableViewCellID"] ;
    if (!newsInforTableViewCell) {
        newsInforTableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"HomePageNewsInforTableViewCell" owner:self options:nil][0] ;
        newsInforTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    
    newsInforTableViewCell.model = self.searchModel.data.data[indexPath.row] ;
    
    return newsInforTableViewCell ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row==self.searchModel.data.data.count-1?113:119 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * linkURL = [NSString  stringWithFormat:@"%@",self.searchModel.data.data[indexPath.row].url?:@""] ;
    
    if ([NSString isBlank:linkURL]==NO) {
        URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:linkURL];
        wkWebViewController.hidesBottomBarWhenPushed = YES ;
        wkWebViewController.itemTitle = @"" ;
        [self.navigationController pushViewController:wkWebViewController animated:NO];
    }
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

@end
