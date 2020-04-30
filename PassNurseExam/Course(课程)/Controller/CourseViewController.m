//
//  CourseViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseViewController.h"
#import "CourseListTableViewCell.h"
#import "CoursePackageListTableViewCell.h"
#import "CourseDetailViewController.h"
#import "CourseCombinationDetailViewController.h"

@interface CourseViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic,strong) CourseHomeMenuView *menu;

@property (nonatomic,strong) CourseClassificationModel * model;
@property (nonatomic,strong) NSMutableArray * bannerArray;

@property (nonatomic ,strong) NSMutableArray * listArray ;
@property (nonatomic ,strong) NSString * courseID ;
@property (nonatomic ,assign) NSInteger  commonDataCount ;

@end

@implementation CourseViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (self.courseID == nil || self.courseID.length == 0) {
        [self requestBannerAndMenu];
    }else {
        [self getListData];
    }
}

- (void)requestBannerAndMenu
{
    [[URCommonApiManager   sharedInstance] getCourseClassificationDataWithRequestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.model = response ;
        self.courseID = [NSString  stringWithFormat:@"%@",self.model.data[0].courses[0].idStr] ;
        
        [self.model.data1  enumerateObjectsUsingBlock:^(CourseClassificationBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self.bannerArray  addObject:obj.thumbnail];
            
        }] ;
        
        if (self.bannerArray.count>0) {
            self.cycleScrollView.imageURLStringsGroup = self.bannerArray ;
        }
        
        [self getListData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

-(void)getListData{
    
    [[URCommonApiManager   sharedInstance]  getCourseStageListDataWithClassID:self.courseID?:@"" userToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        CourseStageModel * stageModel = response ;
        
        if(self.listArray.count>0){
            [self.listArray  removeAllObjects];
        }
        
        //套餐数
        self.commonDataCount = stageModel.data1.count ;
    
        //添加 套餐list
        [self.listArray   addObjectsFromArray:stageModel.data1];
        //添加 课程list
        [self.listArray  addObjectsFromArray:stageModel.data];
        
        [self.tableView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"------------------------------------%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]);
   
    self.bannerArray = [NSMutableArray arrayWithCapacity:0];
    self.listArray  = [NSMutableArray arrayWithCapacity:0];
    
    self.cBtnLeft.hidden = YES;
    self.lblTitle.text = @"精品课程" ;
    
    if (is_online == 0) {
        self.cBtnRight.hidden = YES;
    } else {
        [self.cBtnRight setTitle:@"课程卡激活" forState:UIControlStateNormal];
        self.cBtnRight.titleLabel.font = RegularFont(14.0f) ;
        self.cBtnRight.titleEdgeInsets =UIEdgeInsetsMake(0, (-10/375)*URScreenWidth(), 0, 0) ;
    }
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.cycleScrollView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LoginSuccessNoti" object:nil] subscribeNext:^(id x) {
        [self getListData];
    }];
}


-(void)navRightPressed:(id)sender{
    if (userLoginStatus==YES) {
        UserActivationViewController *  activationViewController = [[UserActivationViewController  alloc] init];
        activationViewController.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:activationViewController animated:YES];
    } else {
        [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<self.commonDataCount)
    {
        CoursePackageListTableViewCell * listTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"CoursePackageListTableViewCellID"];
        if (!listTableViewCell) {
            listTableViewCell =[[NSBundle   mainBundle] loadNibNamed:@"CoursePackageListTableViewCell" owner:self options:nil][0];
            listTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
        }
        listTableViewCell.combinationModel = self.listArray[indexPath.row] ;
        return listTableViewCell;
        
    } else
    {
        CourseListTableViewCell * listTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"CourseListTableViewCellID"];
        if (!listTableViewCell) {
            listTableViewCell = [[CourseListTableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CourseListTableViewCellID"];
            listTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
        }
        listTableViewCell.courseModel = self.listArray[indexPath.row] ;
        listTableViewCell.currentViewController = self ;
        return listTableViewCell;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.menu.menuArr = self.model.data;
    
    @weakify(self);
    self.menu.selectMenuBlcok = ^(CourseClassificationDataModel * _Nonnull menu1Model, CourseClassificationCoursesModel * _Nullable menu2Model) {
        
        @strongify(self);
        
        self.courseID = [NSString  stringWithFormat:@"%@",menu2Model.idStr?:@""] ;
        
        [self  getListData] ;
        //要重新请求，重新刷新
        [self.tableView reloadData];
    };
    return self.menu;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CourseClassificationDataModel *menu1Model = self.model.data[self.menu.menu1Index];
    
    CGFloat height = menu1Model.courses.count == 0 ? (50 * AUTO_WIDTH + 1) : (50 * 2 * AUTO_WIDTH + 1)+3;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row>=self.commonDataCount) {
        
        BaseCourseModel * commonModel = self.listArray[indexPath.row] ;
        if (is_online==0) {
            if ([commonModel.own integerValue]==0) {
                [URToastHelper  showErrorWithStatus:@"请激活课程"] ;

                return ;
            }
        }
        CourseDetailViewController * detailViewController = [[CourseDetailViewController  alloc] init];
        detailViewController.stageID = [NSString  stringWithFormat:@"%@",commonModel.idStr?:@""] ;
        detailViewController.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    } else {
                
        CourseStageCombinationModel * commonModel = self.listArray[indexPath.row] ;
        
        if (is_online==0) {
            if ([commonModel.own integerValue]==0) {
                
                [URToastHelper  showErrorWithStatus:@"请激活课程"] ;
                return ;
            }
        }
        
        CourseCombinationDetailViewController * detailViewController = [[CourseCombinationDetailViewController  alloc] init];
        detailViewController.stageID = [NSString  stringWithFormat:@"%@",commonModel.idStr?:@""] ;
        detailViewController.commonModel = commonModel ;
        detailViewController.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }

}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSString * linkURL = [NSString  stringWithFormat:@"%@",self.model.data1[index].thumbnail?:@""] ;
    
    if ([NSString isBlank:linkURL]==NO){
        URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:linkURL];
        wkWebViewController.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:wkWebViewController animated:YES];
    }
}


-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        NSArray *imageNames = @[
                                @"banner",
                                @"banner"
                                ];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, URSafeAreaNavHeight(), URScreenWidth(), 200 *(URScreenWidth()/375)) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        _cycleScrollView.autoScrollTimeInterval = 3.0;
        _cycleScrollView.delegate = self ;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter ;
    }
    return _cycleScrollView ;
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
