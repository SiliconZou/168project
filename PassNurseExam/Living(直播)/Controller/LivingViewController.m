//
//  LivingViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LivingViewController.h"
#import "QuestionBankBannerMenuCell.h"
#import "FamousTeacherBroadcastCollectionViewCell.h"
#import "LiveCourseRecommendationCollectionViewCell.h"
#import "FamousTeacherBroadcastHeaderView.h"

#import "FmousTeacherBroadcastViewController.h"
#import "LiveCourseRecommendViewController.h"
#import "BuyCourseVC.h"


static NSString * const QuestionBankBannerMenuCellIdentifier = @"QuestionBankBannerMenuCellIdentifier";

static NSString * const FamousTeacherBroadcastCellIdentifier = @"FamousTeacherBroadcastCollectionViewCellID" ;

static NSString * const LiveCourseRecommendationCellIdentifier = @"LiveCourseRecommendationCellIdentifier" ;

static NSString * const LiveBroadcastNoticeCellIdentifier  = @"LiveBroadcastNoticeCellIdentifier" ;

static NSString * const FamousTeacherBroadcastHeaderIdentifier = @"FamousTeacherBroadcastHeaderIdentifier" ;

static NSString * const LiveCourseRecommendationHeaderIdentifier = @"LiveCourseRecommendationHeaderIdentifier" ;

static NSString * const LiveBroadcastNoticeHeaderIdentifier = @"LiveBroadcastNoticeHeaderIdentifier" ;


@interface LivingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) UICollectionView * collectionView ;
@property (nonatomic,strong) NSArray *identifierArr;

@property (nonatomic,strong) LiveClassificationModel * bannerMenuModel;
@property (nonatomic,strong) NSMutableArray * bannerArray;
@property (nonatomic ,strong) NSString * courseID ;
@property (nonatomic,strong) LiveHomeModel *liveHomeMode;

@end

@implementation LivingViewController

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
    self.bannerArray = [NSMutableArray  arrayWithCapacity:0] ;
    
    @weakify(self);
    
    [[URCommonApiManager  sharedInstance] getLiveClassificationDataWithRequestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self);
        
        self.bannerMenuModel = response ;
        self.courseID = [NSString  stringWithFormat:@"%@",self.bannerMenuModel.data[0].courses[0].idStr] ;

        [self.bannerMenuModel.data1  enumerateObjectsUsingBlock:^(LiveClassificationBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self.bannerArray  addObject:obj.thumbnail];
        }];
        [self getListData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }] ;
}

-(void)getListData{
    
    [[URCommonApiManager  sharedInstance] getLiveHomeCourseListDataWithCourseId:self.courseID ?: @"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.liveHomeMode = response;
        [self.collectionView reloadData];

    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.cBtnLeft.hidden = NO;
    
    self.lblTitle.text = @"直播课堂" ;
    
    self.identifierArr = @[QuestionBankBannerMenuCellIdentifier,LiveCourseRecommendationCellIdentifier,FamousTeacherBroadcastCellIdentifier,LiveBroadcastNoticeCellIdentifier];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LoginSuccessNoti" object:nil] subscribeNext:^(id x) {
        
        if (self.courseID == nil || self.courseID.length == 0) {
            [self requestBannerAndMenu];
        }else {
            [self getListData];
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.identifierArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];
    if ([identifier isEqualToString:QuestionBankBannerMenuCellIdentifier]) {
        return 1;
    }else if ([identifier isEqualToString:FamousTeacherBroadcastCellIdentifier]) {
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
    
    if ([identifier isEqualToString:QuestionBankBannerMenuCellIdentifier])
    {
        QuestionBankBannerMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QuestionBankBannerMenuCellIdentifier forIndexPath:indexPath];
                
        // 菜单
        cell.menu.menuArr = self.bannerMenuModel.data;
        cell.bannerArray = self.bannerArray ;
        
        cell.menu.selectMenuBlcok = ^(QuestionClassificationTitleModel * _Nonnull menu1Model, CourseClassificationCoursesModel * _Nullable menu2Model) {
            
            self.courseID = menu2Model.idStr ;
            
            [self  getListData];
           
            [self.collectionView reloadData];
        };
        return cell;
    }
    else if ([identifier isEqualToString:FamousTeacherBroadcastCellIdentifier]){

        FamousTeacherBroadcastCollectionViewCell * collectionViewCell = [collectionView  dequeueReusableCellWithReuseIdentifier:FamousTeacherBroadcastCellIdentifier forIndexPath:indexPath] ;
        
        collectionViewCell.model = self.liveHomeMode.data[indexPath.row];
        
        [[[collectionViewCell.reservationButton  rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:collectionViewCell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
            
            if (self.liveHomeMode.data[indexPath.row].own.integerValue==0) {
                // 预约
                BuyCourseVC *vc = [[BuyCourseVC alloc] init];
                vc.buyType = 1 ;
                vc.dataModel = self.liveHomeMode.data[indexPath.row] ;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
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
            if (self.liveHomeMode.data2[indexPath.row].own.integerValue==0) {
                // 预约
                BuyCourseVC *vc = [[BuyCourseVC alloc] init];
                vc.buyType = 1 ;
                vc.dataModel = self.liveHomeMode.data2[indexPath.row] ;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        
        return collectionViewCell ;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = self.identifierArr[indexPath.section];
    
    if ([identifier isEqualToString:QuestionBankBannerMenuCellIdentifier]){
        return CGSizeMake(URScreenWidth(), (146+50+1) * AUTO_WIDTH);
    }else if ([identifier isEqualToString:FamousTeacherBroadcastCellIdentifier] || [identifier isEqualToString:LiveBroadcastNoticeCellIdentifier]){
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
            if ([identifier  isEqualToString:FamousTeacherBroadcastCellIdentifier]) {
                header.nameLb.text = @"名师专场直播推荐" ;
                header.moreBtn.tag =1 ;
            } else if ([identifier  isEqualToString:LiveCourseRecommendationCellIdentifier]){
                header.nameLb.text = @"今日直播课程推荐" ;
                header.moreBtn.tag =2 ;
            } else if ([identifier  isEqualToString:LiveBroadcastNoticeCellIdentifier]){
                header.nameLb.text = @"直播预告推荐" ;
                header.moreBtn.tag =3 ;
            }
            [header.moreBtn addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
    
    if (indexPath.section==1) {
        liveDetailViewController.idStr = [NSString  stringWithFormat:@"%@",self.liveHomeMode.data1[indexPath.row].course?:@""] ;
//        if (is_online==0) {
//            if (self.liveHomeMode.data[indexPath.row].own.integerValue==0) {
//                [URToastHelper  showErrorWithStatus:@"请先获取观看权限"] ;
//                return ;
//            }
//        }
        
        
    } else if (indexPath.section==2){
        liveDetailViewController.idStr = [NSString  stringWithFormat:@"%@",self.liveHomeMode.data[indexPath.row].idStr?:@""] ;
//        if (is_online==0) {
//            if (self.liveHomeMode.data1[indexPath.row].own.integerValue==0) {
//                [URToastHelper  showErrorWithStatus:@"请先获取观看权限"] ;
//                return ;
//            }
//        }
        
    } else if (indexPath.section==3){
        liveDetailViewController.idStr = [NSString  stringWithFormat:@"%@",self.liveHomeMode.data2[indexPath.row].idStr?:@""] ;
//        if (is_online==0) {
//            if (self.liveHomeMode.data2[indexPath.row].own.integerValue==0) {
//                [URToastHelper  showErrorWithStatus:@"请先获取观看权限"] ;
//                return ;
//            }
//        }
        
    }
    liveDetailViewController.hidesBottomBarWhenPushed = YES ;
    [self.navigationController  pushViewController:liveDetailViewController animated:YES];
}

-(void)moreButtonClick:(UIButton *)btn
{
    FmousTeacherBroadcastViewController * vc = [[FmousTeacherBroadcastViewController alloc] init];
    vc.menuModel = self.bannerMenuModel;
    vc.courseID = self.courseID;
    vc.typeStr = [NSString  stringWithFormat:@"%ld",btn.tag];
    vc.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:vc animated:YES];
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
        [_collectionView registerClass:[QuestionBankBannerMenuCell class] forCellWithReuseIdentifier:QuestionBankBannerMenuCellIdentifier];
        
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


@end
