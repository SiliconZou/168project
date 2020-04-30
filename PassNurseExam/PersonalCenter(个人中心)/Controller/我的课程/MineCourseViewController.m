//
//  MineCourseViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/10/1.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "MineCourseViewController.h"
#import "CourseListTableViewCell.h"
#import "CoursePackageListTableViewCell.h"
#import "CourseDetailViewController.h"
#import "CourseCombinationDetailViewController.h"

@interface MineCourseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) CourseHomeMenuView *menu;
@property (nonatomic,strong) CourseClassificationModel * model;
@property (nonatomic ,strong) CourseStageModel * courseStageModel;

@property (nonatomic ,strong) NSString * courseID ;
@property (nonatomic,strong) NSMutableArray * listArray;
@property (nonatomic ,assign) NSInteger  commonDataCount ;


@end

@implementation MineCourseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    @weakify(self);
//
//    [[URCommonApiManager   sharedInstance] getCourseClassificationDataWithRequestSuccessBlock:^(id response, NSDictionary *responseDict) {
//
//        @strongify(self);
//        self.model = response ;
//
//        self.courseID = [NSString  stringWithFormat:@"%@",self.model.data[0].courses[0].idStr] ;
//
//        [self  getListData] ;
//
//        [self.tableView reloadData];
//
//    } requestFailureBlock:^(NSError *error, id response) {
//
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"我的课程" ;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];
    
    self.listArray = [NSMutableArray   arrayWithCapacity:0] ;
    
    @weakify(self);
    
    [[URCommonApiManager   sharedInstance] getCourseClassificationDataWithRequestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self);
        self.model = response ;
        self.courseID = [NSString  stringWithFormat:@"%@",self.model.data[0].courses[0].idStr] ;
        
        [self  getListData] ;
        
        [self.tableView reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.menu.menuArr = self.model.data;
    
    @weakify(self);
    self.menu.selectMenuBlcok = ^(CourseClassificationDataModel * _Nonnull menu1Model, CourseClassificationCoursesModel * _Nullable menu2Model) {
        
        @strongify(self);
        
        self.courseID = [NSString  stringWithFormat:@"%@",menu2Model.idStr?:@""] ;
        
        [self   getListData] ;
        
        //要重新请求，重新刷新
        [self.tableView reloadData];
    };
    return self.menu;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<self.commonDataCount) {
        CoursePackageListTableViewCell * listTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"CoursePackageListTableViewCellID"];
        if (!listTableViewCell) {
            listTableViewCell =[[NSBundle   mainBundle] loadNibNamed:@"CoursePackageListTableViewCell" owner:self options:nil][0];
            listTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
        }
        listTableViewCell.combinationModel = self.listArray[indexPath.row] ;
        return listTableViewCell;
        
    } else {
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
        CourseDetailViewController * detailViewController = [[CourseDetailViewController  alloc] init];
        detailViewController.stageID = [NSString  stringWithFormat:@"%@",commonModel.idStr?:@""] ;
        detailViewController.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    } else {
        
        CourseStageCombinationModel * commonModel = self.listArray[indexPath.row] ;
        CourseCombinationDetailViewController * detailViewController = [[CourseCombinationDetailViewController  alloc] init];
        detailViewController.stageID = [NSString  stringWithFormat:@"%@",commonModel.idStr?:@""] ;
        detailViewController.commonModel = commonModel ;
        detailViewController.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    
}

-(void)getListData{
    
    [[URCommonApiManager  sharedInstance] sendMineCourseRequestWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" course:self.courseID?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        CourseStageModel * stageModel = response ;
        
        if(self.listArray.count>0){
            [self.listArray  removeAllObjects];
        }
        
        self.commonDataCount = stageModel.data1.count ;
        
        self.courseStageModel = stageModel ;
        
        [self.listArray   addObjectsFromArray:stageModel.data1];
        
        [self.listArray  addObjectsFromArray:stageModel.data];
        
        [self.tableView  reloadData];
        
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
