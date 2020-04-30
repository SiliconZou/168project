//
//  MyLivingVC.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/26.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "MyLivingVC.h"
#import "FamousTeacherBroadcastCollectionViewCell.h"
#import "LiveCourseRecommendationCollectionViewCell.h"
#import "FamousTeacherBroadcastHeaderView.h"

#import "FmousTeacherBroadcastViewController.h"
#import "LiveCourseRecommendViewController.h"
#import "BuyCourseVC.h"

static NSString * const FamousTeacherBroadcastCellIdentifier = @"FamousTeacherBroadcastCollectionViewCellID" ;

static NSString * const LiveCourseRecommendationCellIdentifier = @"LiveCourseRecommendationCellIdentifier" ;

static NSString * const LiveBroadcastNoticeCellIdentifier  = @"LiveBroadcastNoticeCellIdentifier" ;

static NSString * const FamousTeacherBroadcastHeaderIdentifier = @"FamousTeacherBroadcastHeaderIdentifier" ;

static NSString * const LiveCourseRecommendationHeaderIdentifier = @"LiveCourseRecommendationHeaderIdentifier" ;

static NSString * const LiveBroadcastNoticeHeaderIdentifier = @"LiveBroadcastNoticeHeaderIdentifier" ;


@interface MyLivingVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) CourseHomeMenuView *menu;
@property (nonatomic ,strong) UICollectionView * collectionView ;
@property (nonatomic,strong) NSArray *identifierArr;

@property (nonatomic,strong) LiveClassificationModel * bannerMenuModel;
@property (nonatomic ,strong) NSString * courseID ;
@property (nonatomic,strong) LiveHomeModel *liveHomeMode;

@end

@implementation MyLivingVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    if (self.courseID == nil || self.courseID.length == 0) {
        [self requestBannerAndMenu];
    }else {
        [self getListData];
    }
}

- (void)requestBannerAndMenu
{
    @weakify(self);
    
    [[URCommonApiManager  sharedInstance] getLiveClassificationDataWithRequestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self);
        
        self.bannerMenuModel = response ;
        self.courseID = [NSString  stringWithFormat:@"%@",self.bannerMenuModel.data[0].courses[0].idStr] ;

        [self getListData];
        
        self.menu.menuArr = self.bannerMenuModel.data;
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }] ;
}

-(void)getListData{
    
    [[URCommonApiManager  sharedInstance]  getUserBuyLiveCourseDataWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" course:self.courseID ?: @""  requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.liveHomeMode = response;
        [self.collectionView reloadData];

    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
       
    self.lblTitle.text = @"我的直播课程" ;
    
    self.identifierArr = @[FamousTeacherBroadcastCellIdentifier,LiveCourseRecommendationCellIdentifier,LiveBroadcastNoticeCellIdentifier];
    
    [self.view addSubview:self.menu];
    self.menu.frame = CGRectMake(0, URSafeAreaNavHeight(), URScreenWidth(), 50 * 2 * AUTO_WIDTH + 1);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(self.menu.mas_bottom);
    }];
 
    
    @weakify(self);
    
    self.menu.selectMenuBlcok = ^(QuestionClassificationTitleModel * _Nonnull menu1Model, CourseClassificationCoursesModel * _Nullable menu2Model) {
        
        @strongify(self);
        
        self.courseID = menu2Model.idStr;
        [self  getListData];
        [self.collectionView reloadData];
    };
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.identifierArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];
    if ([identifier isEqualToString:FamousTeacherBroadcastCellIdentifier]) {
        return self.liveHomeMode.data.count;
    }else if ([identifier isEqualToString:LiveCourseRecommendationCellIdentifier]) {
        return self.liveHomeMode.data1.count;
    } else if ([identifier isEqualToString:LiveBroadcastNoticeCellIdentifier]){
        return self.liveHomeMode.data2.count ;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = self.identifierArr[indexPath.section];
    
    if ([identifier isEqualToString:FamousTeacherBroadcastCellIdentifier]){

        FamousTeacherBroadcastCollectionViewCell * collectionViewCell = [collectionView  dequeueReusableCellWithReuseIdentifier:FamousTeacherBroadcastCellIdentifier forIndexPath:indexPath] ;
       
        collectionViewCell.model = self.liveHomeMode.data[indexPath.row];
        
        [[[collectionViewCell.reservationButton  rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:collectionViewCell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
            // 预约
            BuyCourseVC *vc = [[BuyCourseVC alloc] init];
            vc.buyType = 1 ;
            vc.dataModel = self.liveHomeMode.data[indexPath.row] ;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return collectionViewCell ;
    }
    else if ([identifier  isEqualToString:LiveCourseRecommendationCellIdentifier]){
        
        LiveCourseRecommendationCollectionViewCell * collectionViewCell = [collectionView  dequeueReusableCellWithReuseIdentifier:LiveCourseRecommendationCellIdentifier forIndexPath:indexPath] ;
        collectionViewCell.model = self.liveHomeMode.data1[indexPath.row];
        return collectionViewCell ;
    } else {
        FamousTeacherBroadcastCollectionViewCell * collectionViewCell = [collectionView  dequeueReusableCellWithReuseIdentifier:FamousTeacherBroadcastCellIdentifier forIndexPath:indexPath] ;
        collectionViewCell.model = self.liveHomeMode.data2[indexPath.row];
       
        [[[collectionViewCell.reservationButton  rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:collectionViewCell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
            // 预约
            BuyCourseVC *vc = [[BuyCourseVC alloc] init];
            vc.buyType = 1 ;
            vc.dataModel = self.liveHomeMode.data2[indexPath.row] ;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return collectionViewCell ;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = self.identifierArr[indexPath.section];
    
    if ([identifier isEqualToString:FamousTeacherBroadcastCellIdentifier] || [identifier isEqualToString:LiveBroadcastNoticeCellIdentifier]){
        return CGSizeMake(URScreenWidth(), 164 * AUTO_WIDTH);
    }else {
        return CGSizeMake(URScreenWidth(), 129 * AUTO_WIDTH);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = self.identifierArr[indexPath.section];
    
    UICollectionReusableView *reuserView = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if ([identifier  isEqualToString:FamousTeacherBroadcastCellIdentifier]||[identifier  isEqualToString:LiveCourseRecommendationCellIdentifier]||[identifier  isEqualToString:LiveBroadcastNoticeCellIdentifier]){

            FamousTeacherBroadcastHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:FamousTeacherBroadcastHeaderIdentifier forIndexPath:indexPath];
            
            header.moreBtn.hidden = YES ;

            if ([identifier  isEqualToString:FamousTeacherBroadcastCellIdentifier]) {
                header.nameLb.text = @"名师专场直播推荐" ;
            } else if ([identifier  isEqualToString:LiveCourseRecommendationCellIdentifier]){
                header.nameLb.text = @"直播课程推荐" ;
            } else if ([identifier  isEqualToString:LiveBroadcastNoticeCellIdentifier]){
                header.nameLb.text = @"直播预告推荐" ;
            }
            reuserView = header;
            
        }else{
            reuserView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        }
    }else{
        reuserView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        reuserView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
    }
    return reuserView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];
    
    if ([identifier isEqualToString:FamousTeacherBroadcastCellIdentifier] || [identifier isEqualToString:LiveCourseRecommendationCellIdentifier] || [identifier isEqualToString:LiveBroadcastNoticeCellIdentifier]){
        return CGSizeMake(URScreenWidth(), 50 * AUTO_WIDTH);
    } else {
        return CGSizeMake(URScreenWidth(), 0.01);
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];
    if (identifier == FamousTeacherBroadcastCellIdentifier || identifier == LiveCourseRecommendationCellIdentifier) {
        return CGSizeMake(URScreenWidth(), 8);
    } else {
        return CGSizeMake(URScreenWidth(), 0.5);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];
    if (identifier == LiveCourseRecommendationCellIdentifier) {
        return 1 ;
    } else {
        return 0;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LiveCourseRecommendViewController * liveDetailViewController = [[LiveCourseRecommendViewController  alloc] init];
    
    if (indexPath.section==0) {
        liveDetailViewController.idStr = [NSString  stringWithFormat:@"%@",self.liveHomeMode.data[indexPath.row].course?:@""] ;
    } else if (indexPath.section==1){
        liveDetailViewController.idStr = [NSString  stringWithFormat:@"%@",self.liveHomeMode.data1[indexPath.row].idStr?:@""] ;
    } else if (indexPath.section==2){
        liveDetailViewController.idStr = [NSString  stringWithFormat:@"%@",self.liveHomeMode.data2[indexPath.row].idStr?:@""] ;
    }
    liveDetailViewController.hidesBottomBarWhenPushed = YES ;
    [self.navigationController  pushViewController:liveDetailViewController animated:YES];
}
 

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        if (@available(ios 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets=NO;
#pragma clang diagnostic pop
        }
        
        //注册cell
        
        [_collectionView registerNib:[UINib  nibWithNibName:@"FamousTeacherBroadcastCollectionViewCell" bundle:[NSBundle  mainBundle]] forCellWithReuseIdentifier:FamousTeacherBroadcastCellIdentifier];
        
        [_collectionView registerClass:[LiveCourseRecommendationCollectionViewCell class] forCellWithReuseIdentifier:LiveCourseRecommendationCellIdentifier];
        
        [_collectionView registerClass:[LiveCourseRecommendationCollectionViewCell class] forCellWithReuseIdentifier:LiveBroadcastNoticeCellIdentifier];
        
        
        // 注册区头
        [_collectionView registerClass:[FamousTeacherBroadcastHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:FamousTeacherBroadcastHeaderIdentifier];
        
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}

- (CourseHomeMenuView *)menu
{
    if (!_menu) {
        _menu = [[CourseHomeMenuView alloc] init];
    }
    return _menu;
}


@end
