//
//  HomePageViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageBannerCell.h"
#import "HomePageClassifyCell.h"
#import "HomePageLiveCell.h"
#import "HomePageCourseCell.h"
#import "HomePageNewsCell.h"
#import "HomePageBooksCell.h"
#import "HomePageHeadlineCell.h"
#import "HomePageHeaderView.h"
#import "HomePageNavView.h"
#import "DailyQuestionsViewController.h"
#import "PYSearchViewController.h"
#import "UserMessageViewController.h"
#import "LivingViewController.h"
#import "PopoverView.h"
static NSString * const HomePageBannerCellIdentifier = @"HomePageBannerCellIdentifier";
static NSString * const HomePageClassifyCellIdentifier = @"HomePageClassifyCellIdentifier";
static NSString * const HomePageLiveCellIdentifier = @"HomePageLiveCellIdentifier";
static NSString * const HomePageCourseCellIdentifier = @"HomePageCourseCellIdentifier";
static NSString * const HomePageNewsCellIdentifier = @"HomePageNewsCellIdentifier";
static NSString * const HomePageBooksCellIdentifier = @"HomePageBooksCellIdentifier";
static NSString * const HomePageHeadlineCellIdentifier = @"HomePageHeadlineCellIdentifier";

static NSString * const HomePageHeaderViewIdentifier = @"HomePageHeaderViewIdentifier";


@interface HomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate>

@property (nonatomic,strong) HomePageNavView *navView;
@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,strong) NSMutableArray *identifierArr;
@property (nonatomic,strong) HomePageModel * homeModel ;
@property (nonatomic,strong) NSArray *customerArr;
@end

@implementation HomePageViewController

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated] ;
    
    @weakify(self) ;
    [[URCommonApiManager  sharedInstance] getHomePageDataSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self) ;
        self.homeModel = response ;
        
        [self.collection  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.cBtnLeft.hidden = YES;

    //HomePageLiveCellIdentifier, HomePageBooksCellIdentifier,
    self.identifierArr = is_online == 0 ? [NSMutableArray arrayWithObjects:HomePageBannerCellIdentifier,
                                    HomePageHeadlineCellIdentifier,
                                    HomePageClassifyCellIdentifier,
//                                    HomePageCourseCellIdentifier,
                                    HomePageNewsCellIdentifier,
                                    nil] :
    [NSMutableArray arrayWithObjects:HomePageBannerCellIdentifier,
                          HomePageHeadlineCellIdentifier,
                          HomePageClassifyCellIdentifier,
                          HomePageCourseCellIdentifier,
                          HomePageNewsCellIdentifier,
                          nil];
    [self createUI];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.identifierArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];
    if ([identifier isEqualToString:HomePageBannerCellIdentifier] || [identifier isEqualToString:HomePageHeadlineCellIdentifier]
         ) {
        return 1;
    }else if ([identifier isEqualToString:HomePageClassifyCellIdentifier]) {
        return is_online == 0 ? 6 : 8;
    }
    else if ([identifier isEqualToString:HomePageLiveCellIdentifier]) {
        return 2;
    }
    else if ([identifier isEqualToString:HomePageCourseCellIdentifier]) {
        return self.homeModel.data.count;
    }else if ([identifier isEqualToString:HomePageNewsCellIdentifier]) {
        return self.homeModel.data1.count;
    }else{
        return 10;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = self.identifierArr[indexPath.section];
    
    if ([identifier isEqualToString:HomePageBannerCellIdentifier]){
        HomePageBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomePageBannerCellIdentifier forIndexPath:indexPath];
        cell.homePageModel = self.homeModel ;
        cell.currentViewController = self ;
        return cell;
    }
    else if ([identifier isEqualToString:HomePageHeadlineCellIdentifier]){
        HomePageHeadlineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomePageHeadlineCellIdentifier forIndexPath:indexPath];
        cell.dataArray = self.homeModel.data3 ;
        cell.currentViewController = self ;
        return cell;
    }
    else if ([identifier isEqualToString:HomePageClassifyCellIdentifier]){
        HomePageClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomePageClassifyCellIdentifier forIndexPath:indexPath];
        cell.row = indexPath.row;
        return cell;
    }
    else if ([identifier isEqualToString:HomePageLiveCellIdentifier]){
        HomePageLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomePageLiveCellIdentifier forIndexPath:indexPath];
        return cell;

    }
    else if ([identifier isEqualToString:HomePageCourseCellIdentifier]){
        HomePageCourseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomePageCourseCellIdentifier forIndexPath:indexPath];
        cell.courseModel = self.homeModel.data[indexPath.row] ;

        return cell;
    }
    else if ([identifier isEqualToString:HomePageNewsCellIdentifier]){
        HomePageNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomePageNewsCellIdentifier forIndexPath:indexPath];
        cell.informationModel = self.homeModel.data1[indexPath.row] ;
        return cell;
    }
    else
    {
        HomePageBooksCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomePageBooksCellIdentifier forIndexPath:indexPath];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = self.identifierArr[indexPath.section];

    UICollectionReusableView *reuserView = nil;
    
    WEAKSELF(self) ;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (([identifier isEqualToString:HomePageCourseCellIdentifier] || [identifier isEqualToString:HomePageLiveCellIdentifier] ||
             [identifier isEqualToString:HomePageNewsCellIdentifier] ||
             [identifier isEqualToString:HomePageBooksCellIdentifier]) || [identifier isEqualToString:HomePageClassifyCellIdentifier])
        {
            HomePageHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HomePageHeaderViewIdentifier forIndexPath:indexPath];
            
            if ([identifier isEqualToString:HomePageLiveCellIdentifier]) {
                header.nameLb.text = @"推荐直播";
                [[header.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                    weakSelf.navigationController.tabBarController.selectedIndex =3 ;
                }];
            }else if ([identifier isEqualToString:HomePageCourseCellIdentifier]) {
                header.nameLb.text = @"精品课程";
                [header.moreBtn setHidden:NO];
                [[header.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                    weakSelf.navigationController.tabBarController.selectedIndex =2 ;
                }];
            }else if ([identifier isEqualToString:HomePageNewsCellIdentifier]) {
                header.nameLb.text = @"最新资讯";
                [header.moreBtn setHidden:NO];
                [[[header.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(id x) {
                    weakSelf.navigationController.tabBarController.selectedIndex = 0 ;
                    HomePageNewsInforViewController * newsViewController = [[HomePageNewsInforViewController alloc] init];
                    newsViewController.hidesBottomBarWhenPushed = YES ;
                    [weakSelf.navigationController pushViewController:newsViewController animated:YES] ;
                }];
            }else if ([identifier isEqualToString:HomePageBooksCellIdentifier]) {
                header.nameLb.text = @"推荐书籍";
                [[header.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                }];
            } else if ([identifier isEqualToString:HomePageClassifyCellIdentifier]) {
                header.nameLb.text = @"热门功能";
                [header.moreBtn setHidden:YES];
            }
            reuserView = header;
        }else
        {
            reuserView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        }
    }else
    {
        reuserView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reuserView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
    }
    return reuserView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = self.identifierArr[indexPath.section];
    if ([identifier isEqualToString:HomePageBannerCellIdentifier]
        ) {
        return CGSizeMake(URScreenWidth(), 160 * AUTO_WIDTH);
    }else if ([identifier isEqualToString:HomePageHeadlineCellIdentifier]
              ) {
        return CGSizeMake(URScreenWidth(), 40 * AUTO_WIDTH);
    }else if ([identifier isEqualToString:HomePageClassifyCellIdentifier]
              ) {
        return CGSizeMake(URScreenWidth()/4.0, 105 * AUTO_WIDTH);
    }
    else if ([identifier isEqualToString:HomePageLiveCellIdentifier]
              ) {
        return CGSizeMake(URScreenWidth()/2.0, 240 * AUTO_WIDTH);
    }
    else if ([identifier isEqualToString:HomePageCourseCellIdentifier]
              ) {
        return CGSizeMake(URScreenWidth(), 150 * AUTO_WIDTH);
    }else if ([identifier isEqualToString:HomePageNewsCellIdentifier]
              ) {
        return CGSizeMake(URScreenWidth(), 111 * AUTO_WIDTH);
    }else{
        return CGSizeMake(URScreenWidth()/2.0, 235 * AUTO_WIDTH);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];
    if ([identifier isEqualToString:HomePageBannerCellIdentifier]) {
        return CGSizeMake(0, 0);
    } else if ([identifier isEqualToString:HomePageHeadlineCellIdentifier]) {
        return CGSizeMake(URScreenWidth(), 2);
    } else {
        return CGSizeMake(URScreenWidth(), 9 * AUTO_WIDTH);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];

    if ([identifier isEqualToString:HomePageCourseCellIdentifier] || [identifier isEqualToString:HomePageLiveCellIdentifier] ||
         [identifier isEqualToString:HomePageNewsCellIdentifier] ||
         [identifier isEqualToString:HomePageBooksCellIdentifier] || [identifier isEqualToString:HomePageClassifyCellIdentifier])
    {
        return CGSizeMake(URScreenWidth(), 40 * AUTO_WIDTH);
    }
    return CGSizeMake(URScreenWidth(), 0.01);
 
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = self.identifierArr[indexPath.section];
    if ([identifier isEqualToString:HomePageNewsCellIdentifier])
    {
        NSString * linkURL = [NSString  stringWithFormat:@"%@",self.homeModel.data1[indexPath.row].url?:@""] ;
        
        if ([NSString isBlank:linkURL]==NO)
        {
            URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:linkURL];
            wkWebViewController.hidesBottomBarWhenPushed = YES ;
            wkWebViewController.itemTitle = [NSString  stringWithFormat:@"%@",self.homeModel.data1[indexPath.row].title?:@""] ;
            [self.navigationController pushViewController:wkWebViewController animated:YES];
        }
    }  else if ([identifier isEqualToString:HomePageCourseCellIdentifier])
    {
        HomPageHighQualityCoursesViewController *  courseViewController = [[HomPageHighQualityCoursesViewController alloc] init];
        
        courseViewController.nameStr = [NSString  stringWithFormat:@"%@",self.homeModel.data[indexPath.row].name?:@""] ;
        
        courseViewController.classID = [NSString  stringWithFormat:@"%@",self.homeModel.data[indexPath.row].idStr?:@""] ;
        courseViewController.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:courseViewController animated:YES];
    }
    else if ([identifier isEqualToString:HomePageClassifyCellIdentifier])
    {
        
        if(indexPath.row==0){
            self.navigationController.tabBarController.selectedIndex = is_online == 0 ? 1 : 2 ;
            
        }else if (indexPath.row==1) {
            if (is_online == 0) {
                [self openWebViewWithUrl:@"/mall/#/index?device=ios&token=" currVC:self];
            } else {
                LivingViewController *livingVC = [[LivingViewController alloc] init];
                livingVC.hidesBottomBarWhenPushed = YES ;
                [self.navigationController pushViewController:livingVC animated:YES];
            }
        }
        else if (indexPath.row==2){
            if (is_online == 0) {
                [self openWebViewWithUrl:@"/edu/#/index?device=ios&token=" currVC:self];
            } else {
                self.navigationController.tabBarController.selectedIndex = 1 ;
            }
            
        }else if (indexPath.row==3){
            if (is_online == 0) {
                HomePageNewsInforViewController * newsViewController = [[HomePageNewsInforViewController alloc] init];
                newsViewController.hidesBottomBarWhenPushed = YES ;
                [self.navigationController pushViewController:newsViewController animated:YES] ;
            } else {
                [self openWebViewWithUrl:@"/mall/#/index?device=ios&token=" currVC:self];
            }
        }
        
        else if (indexPath.row == 4) {
            if (is_online == 0) {
                [self openWebViewWithUrl:@"/recruitment/#/pages/index/index?device=ios&apitoken=" currVC:self];
            } else {
                [self openWebViewWithUrl:@"/edu/#/index?device=ios&token=" currVC:self];
            }
        } else if (indexPath.row == 5) {
            if (is_online == 0) {
                [self openWebViewWithUrl:@"/classs/#/pages/welcomeclass/welcomeclass?device=ios&apitoken=" currVC:self];
            } else {
                HomePageNewsInforViewController * newsViewController = [[HomePageNewsInforViewController alloc] init];
                newsViewController.hidesBottomBarWhenPushed = YES ;
                [self.navigationController pushViewController:newsViewController animated:YES] ;
            }
        } else if (indexPath.row == 6) {
            if (is_online == 0) {
                [self openWebViewWithUrl:@"/classs/#/pages/welcomeclass/welcomeclass?device=ios&apitoken=" currVC:self];
            } else {
                //http://edu.168wangxiao.cn/moments/#/pages/Recruitment/Recruitment?apitoken=f8f3c8de-3a9a-11ea-bdfe-000000020bc9&device=android
                //http://edu.168wangxiao.cn/recruitment/#/pages/index/index?apitoken=f8f3c8de-3a9a-11ea-bdfe-000000020bc9&device=android

                [self openWebViewWithUrl:@"/recruitment/#/pages/index/index?device=ios&apitoken=" currVC:self];
            }
        }

         else if (indexPath.row==7){
             [self openWebViewWithUrl:@"/classs/#/pages/welcomeclass/welcomeclass?device=ios&apitoken=" currVC:self];
        }
    }
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText{
    if (searchText.length) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        });
    }
}

- (void)createUI{
    self.customerArr = @[@{@"title":@"课程咨询",@"imgName":@"客服拷贝"},@{@"title":@"课件咨询",@"imgName":@"客服拷贝"},
                        @{@"title":@"App咨询",@"imgName":@"客服拷贝"},@{@"title":@"客服热线",@"imgName":@"耳机"},
                        @{@"title":@"技术支持",@"imgName":@"技术支持43"},@{@"title":@"本地学习",@"imgName":@"本地分校"}];
    [self.cViewNav addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.view addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(URSafeAreaNavHeight(), 0, 0, 0));
    }];
    
    @weakify(self) ;
    
    self.navView.selectedButtonBlock = ^(NSInteger tag) {
        
        @strongify(self) ;
        NSLog(@"输出点击的按钮的tag:%ld",(long)tag) ;
        if (tag==2) {
            
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
            searchViewController.searchBar.layer.cornerRadius = 15.0f ;
            searchViewController.searchBar.layer.masksToBounds = YES ;
            searchViewController.delegate = self;
            searchViewController.hidesBottomBarWhenPushed = YES ;
            searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
            [self.navigationController pushViewController:searchViewController animated:YES];
            
        } else if (tag==4)
        {
            if (userLoginStatus)
            {
                
                    PopoverView *popoverView = [PopoverView popoverView];
                    popoverView.showShade = YES;
                    popoverView.automaticArrowDirection = NO;//取消自动朝向
                    popoverView.isUpward = YES;//设置箭头朝向，向上
        //            popoverView.backgroundColor = UR_ColorFromValueA(0x333333, 0.9);
                    popoverView.style = PopoverViewStyleDark;
                    NSMutableArray *actionArr = [[NSMutableArray alloc] init];
                    for (int i=0; i < self.customerArr.count; i++) {
                        NSDictionary *dic = self.customerArr[i];
                        PopoverAction *action1 = [PopoverAction actionWithImage:[UIImage imageNamed:dic[@"imgName"]] title:dic[@"title"] handler:^(PopoverAction *action) {
                            if (i < 3 || i == 4) {
                                [self openOnlineWithQQ:self.homeModel.data5[i].qq];
                            } else if (i == 3) {
                                URMakePhoneCall(self.homeModel.data5[3].qq);
                            } else if (i == 5) {
                                NSString *classUrl = [NSString stringWithFormat:@"http://hukao.dianshiedu.cn/school/#/pages/welcomeclass/welcomeclass?device=ios&id=%@",self.homeModel.data5[5].qq?:@""];
                                URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:classUrl];
                                wkWebViewController.hidesBottomBarWhenPushed = YES ;
                                wkWebViewController.isShowNav = YES;
                                [self.navigationController pushViewController:wkWebViewController animated:YES];
                            }
                        }];
                        
                        [actionArr addObject:action1];
                    }
        //            for (NSDictionary *dic in self.customerArr) {
        //                PopoverAction *action1 = [PopoverAction actionWithImage:[UIImage imageNamed:dic[@"imgName"]] title:dic[@"title"] handler:^(PopoverAction *action) {
        //                    [self openOnlineWithQQ:self.homeModel.data5[].qq];
        //                }];
        //
        //                [actionArr addObject:action1];
        //            }
                    CGPoint point = CGPointMake(self.navView.addBtn.origin.x + self.navView.addBtn.frame.size.width/2, self.navView.addBtn.frame.size.height + URStatusBarHeight() + 10);
                    [popoverView showToPoint:point withActions:actionArr];
                
            } else {
                [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
            }
        } else if (tag==3){
            if (userLoginStatus)
            {
                HomePageScanViewController * scanViewController = [[HomePageScanViewController  alloc] init];
                [HomePageViewModel  qrCodeScanWithViewController:self pushViewController:scanViewController];
            } else {
                [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
            }
        }
    } ;
}

- (UICollectionView *)collection{
    if (!_collection) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.alwaysBounceVertical = YES;
        if (@available(ios 11.0, *)) {
            _collection.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets=NO;
#pragma clang diagnostic pop
        }
        
        //注册cell
        [_collection registerClass:[HomePageBannerCell class] forCellWithReuseIdentifier:HomePageBannerCellIdentifier];

        [_collection registerClass:[HomePageHeadlineCell class] forCellWithReuseIdentifier:HomePageHeadlineCellIdentifier];

        
        [_collection registerClass:[HomePageClassifyCell class] forCellWithReuseIdentifier:HomePageClassifyCellIdentifier];

        [_collection registerClass:[HomePageLiveCell class] forCellWithReuseIdentifier:HomePageLiveCellIdentifier];

        [_collection registerClass:[HomePageCourseCell class] forCellWithReuseIdentifier:HomePageCourseCellIdentifier];

        [_collection registerClass:[HomePageNewsCell class] forCellWithReuseIdentifier:HomePageNewsCellIdentifier];

        [_collection registerClass:[HomePageBooksCell class] forCellWithReuseIdentifier:HomePageBooksCellIdentifier];

        // 注册区头
        [_collection registerClass:[HomePageHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HomePageHeaderViewIdentifier];
        [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
        
    }
    return _collection;
}

-(HomePageNavView *)navView
{
    if (!_navView) {
        _navView = [[HomePageNavView alloc] init];
    }
    return _navView;
}

@end
