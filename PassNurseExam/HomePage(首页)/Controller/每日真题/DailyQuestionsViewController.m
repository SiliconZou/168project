//
//  DailyQuestionsViewController.m
//  PassNurseExam
//
//  Created by qc on 14/9/2019.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "DailyQuestionsViewController.h"
#import "DailyQuestionsTableViewCell.h"
#import "DailyQuestionsDetailViewController.h"

@interface DailyQuestionsViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SDCycleScrollView * cycleScrollView;

@property (nonatomic,strong) QuestionClassificationModel * model;

@property (nonatomic,strong) NSMutableArray * bannerArray;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) CourseHomeMenuView *menu;

@property (nonatomic,copy) NSString * subjectID;

@property (nonatomic ,strong)DailyQuestionsModel * questionModel ;

@end

@implementation DailyQuestionsViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    self.bannerArray = [NSMutableArray  arrayWithCapacity:0] ;
    
    @weakify(self);
    
    [[URCommonApiManager  sharedInstance] getQuestionClassificationDataWithRequestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self);
        
        self.model = response ;
        
        [self.model.data1  enumerateObjectsUsingBlock:^(QuestionClassificationBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self.bannerArray  addObject:obj.thumbnail];
            
        }] ;
        
        if (self.bannerArray.count>0) {
            self.cycleScrollView.imageURLStringsGroup = self.bannerArray ;
        }
        
        self.subjectID = [NSString  stringWithFormat:@"%@",self.model.data[0].subjects[0].idStr?:@""] ;
        
        [self  getDailyQuestionlListDataWithSubjectID:self.model.data[0].subjects[0].idStr?:@""];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }] ;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.lblTitle.text = @"每日真题" ;
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.cycleScrollView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.questionModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DailyQuestionsTableViewCell * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"DailyQuestionsTableViewCellID"];
    
    if (!tableViewCell) {
        
        tableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"DailyQuestionsTableViewCell" owner:self options:nil][0] ;
        
        tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    
    tableViewCell.questionModel = self.questionModel.data[indexPath.row] ;
    
    
    return tableViewCell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.menu.menuArr = self.model.data;
    
    @weakify(self);
    self.menu.selectMenuBlcok = ^(QuestionClassificationTitleModel * _Nonnull menu1Model, CourseClassificationCoursesModel * _Nullable menu2Model) {
        
        @strongify(self);
        
        [self  getDailyQuestionlListDataWithSubjectID:menu2Model.idStr?:@""] ;
        
        [self.tableView reloadData];
        
    };
    return self.menu;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    QuestionClassificationTitleModel *menu1Model = self.model.data[self.menu.menu1Index];
    
    CGFloat height = menu1Model.subjects.count == 0 ? (50 * AUTO_WIDTH + 1) : (50 * 2 * AUTO_WIDTH + 1);
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DailyQuestionsDetailViewController * detailViewController = [[DailyQuestionsDetailViewController  alloc] init];
    detailViewController.hidesBottomBarWhenPushed = YES ;
    detailViewController.dataModel = self.questionModel.data[indexPath.row] ;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

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

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.estimatedRowHeight = 44.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
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

- (CourseHomeMenuView *)menu{
    if (!_menu) {
        _menu = [[CourseHomeMenuView alloc] initWithFrame:CGRectMake(0, 0, URScreenWidth(), 50 * 2 * AUTO_WIDTH + 1)];
    }
    return _menu;
}

-(void)getDailyQuestionlListDataWithSubjectID:(NSString *)subjectID{
    
    [[URCommonApiManager  sharedInstance] getDailyQuestionlListDataWithSubjectID:subjectID?:@"" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.questionModel = response ;
        
        [self.tableView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }] ;
}
@end
