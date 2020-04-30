//
//  HomPageHighQualityCoursesViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomPageHighQualityCoursesViewController.h"
#import "CourseListTableViewCell.h"
#import "CoursePackageListTableViewCell.h"
#import "CourseDetailViewController.h"
#import "CourseCombinationDetailViewController.h"

@interface HomPageHighQualityCoursesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) CourseStageModel * courseStageModel;

@property (nonatomic ,strong) UITableView * tableView ;

@property (nonatomic,strong) NSMutableArray * listArray;

@property (nonatomic ,assign) NSInteger  commonDataCount ;


@end

@implementation HomPageHighQualityCoursesViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestList];
}

- (void)requestList
{
    NSLog(@"输出分类ID:%@",self.classID) ;
    
    self.listArray = [NSMutableArray arrayWithCapacity:0] ;
    
    [[URCommonApiManager   sharedInstance]  getCourseStageListDataWithClassID:self.classID?:@"" userToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = self.nameStr?:@"" ;
    
    [self.view  addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(URSafeAreaNavHeight()) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()));
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LoginSuccessNoti" object:nil] subscribeNext:^(id x) {
        [self requestList];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count ;
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


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView = [[UIView  alloc] init];
    return footerView ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row>=self.commonDataCount) {
        
        BaseCourseModel * commonModel = self.listArray[indexPath.row] ;
        if (is_online==0) {
            if (commonModel.own.integerValue ==0) {
                [URToastHelper  showErrorWithStatus:@"请激活该课程"] ;
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
            if (commonModel.own.integerValue ==0) {
               [URToastHelper  showErrorWithStatus:@"请激活该课程"] ;
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

@end
