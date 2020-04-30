//
//  CourseTeacherViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "CourseTeacherViewController.h"
#import "CourseTeacherInfoCell.h"
#import "CourseListTableViewCell.h"
#import "CourseDetailViewController.h"

static NSString * const CourseTeacherInfoCellIdentifier = @"CourseTeacherInfoCellIdentifier";
static NSString * const CourseListTableViewCellIdentifier = @"CourseListTableViewCellIdentifier";

@interface CourseTeacherViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) CourseTeacherInforModel * teacherInforModel;

@end

@implementation CourseTeacherViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestTeacherInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"老师简介" ;
    
     [self.cBtnRight setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
     [[self.cBtnRight  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
     self.cBtnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -44 * AUTO_WIDTH) ;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
        make.height.mas_equalTo(URScreenHeight()-URSafeAreaNavHeight()) ;
    }];
    
}

- (void)requestTeacherInfo
{
    @weakify(self) ;
    [[URCommonApiManager  sharedInstance] getCourseTeacherInforDataWithTeacherID:self.teacherID?:@""  userToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"-1" type:1 requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self) ;
        
        self.teacherInforModel = response ;
        
        [self.tableView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

-(void)navRightPressed:(id)sender{
    URSharedView * sharedView= [[URSharedView  alloc] init];
    URSharedModel * shareModel = [[URSharedModel alloc] init];
    shareModel.url = [NSString  stringWithFormat:@"%@",URShareURL] ;
    shareModel.thumbImage =@"AppIcon" ;
    shareModel.title = @"168网校" ;
    shareModel.descr = @"推荐168网校给好友，邀请好友得奖励" ;
    [sharedView  urShowShareViewWithDXShareModel:shareModel shareContentType:URShareContentTypeImage];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : self.teacherInforModel.data1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
       CourseTeacherInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseTeacherInfoCellIdentifier];
        
        @weakify(self) ;
        cell.selectedButtonBlock = ^(NSInteger tag) {
            @strongify(self) ;
            
            //tag ： 2  送花； 1 点赞
            //参数type ： 3  送花； 2 点赞，所以 tag+1
            
            [[URCommonApiManager  sharedInstance] getCourseTeacherInforDataWithTeacherID:self.teacherID?:@"" userToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"-1" type:tag+1 requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                [URToastHelper showErrorWithStatus:responseDict[@"msg"]?:@""] ;
                //刷新数据
                [self requestTeacherInfo];
                
            } requestFailureBlock:^(NSError *error, id response) {
             
            }];
        };
        cell.dataModel = self.teacherInforModel.data ;
        return cell;
    }
    else
    {
        CourseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseListTableViewCellIdentifier];
        cell.courseModel = self.teacherInforModel.data1[indexPath.row];
        cell.currentViewController = self ;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.section == 0) return;
    
    BaseCourseModel * dataModel = self.teacherInforModel.data1[indexPath.row] ;
    
    CourseDetailViewController * detailViewController = [[CourseDetailViewController  alloc] init];
    detailViewController.stageID = [NSString  stringWithFormat:@"%@",dataModel.idStr?:@""] ;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView = [[UIView  alloc] init];
    headerView.backgroundColor = [UIColor  clearColor] ;
    
    return headerView ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0?0.01:3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.estimatedRowHeight = 44.0f;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
        [_tableView registerClass:[CourseTeacherInfoCell class] forCellReuseIdentifier:CourseTeacherInfoCellIdentifier];
        [_tableView registerClass:[CourseListTableViewCell class] forCellReuseIdentifier:CourseListTableViewCellIdentifier];
    }
    return _tableView;
}

@end
