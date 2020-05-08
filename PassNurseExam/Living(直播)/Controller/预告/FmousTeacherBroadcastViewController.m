//
//  FmousTeacherBroadcastViewController.m
//  PassNurseExam
//
//  Created by quchao on 2019/10/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "FmousTeacherBroadcastViewController.h"
#import "FmousTeacherBroadcastCell.h"
#import "FamousTeacherBroadcastModel.h"
#import "LiveCourseRecommendViewController.h"
#import "BuyCourseVC.h"
#import "LiveTodayRecommendCell.h"
static NSString * const FmousTeacherBroadcastCellIdentifier = @"FmousTeacherBroadcastCellIdentifier";

@interface FmousTeacherBroadcastViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) CourseHomeMenuView *menu;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) FmousTeacherBroadcastModel *broadcastModel;
@property (nonatomic,strong) LiveHomeRecommedCourseModel *liveTodayModel;
@property (nonatomic,retain) NSMutableArray <LiveHomeRecommedCourseModel *> *tableData;
@end

@implementation FmousTeacherBroadcastViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.typeStr.integerValue==1) {
        self.lblTitle.text = @"名师专场直播推荐" ;
    } else if (self.typeStr.integerValue==2){
        self.lblTitle.text = @"今日直播课程推荐" ;
    } else if (self.typeStr.integerValue==3){
        self.lblTitle.text = @"直播预告推荐" ;
    }
    
    [self   getMoreListData] ;
}

-(void)getMoreListData{
    //    1专场 2 课程 3 预备
    [[URCommonApiManager  sharedInstance] getLiveMoreCourseListDataWithCourseId:self.courseID ?: @"" type:self.typeStr ?: @"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        self.broadcastModel = response;
        if (self.typeStr.integerValue == 2) {
            NSArray *dataArr = responseDict[@"data"];
            self.tableData = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in dataArr) {
                LiveHomeRecommedCourseModel *model = [LiveHomeRecommedCourseModel yy_modelWithDictionary:dict];
                [self.tableData addObject:model];
            }
        }
        [self.tableView reloadData];
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.menu];
    [self.view addSubview:self.tableView];
    
    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
        make.height.mas_equalTo(45 * AUTO_WIDTH);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.menu.mas_bottom);
        make.left.right.bottom.mas_offset(0);
    }];
    
    self.menu.menuArr = self.menuModel.data;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.typeStr.integerValue == 2 ? self.tableData.count : self.broadcastModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.typeStr.integerValue == 2) {
        LiveTodayRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveTodayRecommendCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.model = self.tableData[indexPath.row];
        return cell;
    } else {
        FmousTeacherBroadcastCell *cell = [tableView dequeueReusableCellWithIdentifier:FmousTeacherBroadcastCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        [[[cell.reservationButton  rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
            // 预约
            BuyCourseVC *vc = [[BuyCourseVC alloc] init];
            vc.buyType = 1 ;
            vc.dataModel = self.broadcastModel.data[indexPath.row] ;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        cell.model = self.broadcastModel.data[indexPath.row];
        if (indexPath.row == 0) {
            cell.line1.hidden = YES;
        }else {
            cell.line1.hidden = NO;
        }
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveCourseRecommendViewController * liveDetailViewController = [[LiveCourseRecommendViewController  alloc] init];
    liveDetailViewController.idStr = [NSString  stringWithFormat:@"%@",self.broadcastModel.data[indexPath.row].idStr?:@""] ;
    liveDetailViewController.hidesBottomBarWhenPushed = YES ;
    [self.navigationController  pushViewController:liveDetailViewController animated:YES];
    
}

- (CourseHomeMenuView *)menu
{
    if (!_menu) {
        _menu = [[CourseHomeMenuView alloc] init];
        @weakify(self);
        _menu.selectMenuBlcok = ^(QuestionClassificationTitleModel * _Nonnull menu1Model, CourseClassificationCoursesModel * _Nullable menu2Model) {
            @strongify(self);
            self.courseID = menu2Model.idStr ?:@"" ;
            [self   getMoreListData] ;
            
        } ;
    }
    return _menu;
}


-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView  alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = UR_ColorFromValue(0xffffff) ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 156;
        [_tableView registerNib:[UINib nibWithNibName:@"FmousTeacherBroadcastCell" bundle:nil] forCellReuseIdentifier:FmousTeacherBroadcastCellIdentifier];
        [_tableView registerClass:[LiveTodayRecommendCell class] forCellReuseIdentifier:@"LiveTodayRecommendCell"];
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
