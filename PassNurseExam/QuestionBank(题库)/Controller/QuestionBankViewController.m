//
//  QuestionBankViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "QuestionBankViewController.h"
#import "QuestionBankCell.h"
#import "QuestionBankSimulationCell.h"
#import "QuestionBankUserRightCell.h"
#import "QuestionBankBannerMenuCell.h"

#import "WrongTopicVC.h"
#import "ImgVideoQuestionBankVC.h"
#import "TrainingViewController.h"
#import "SecretVolumeViewController.h"
#import "DailyQuestionsViewController.h"
static NSString * const QuestionBankCellIdentifier = @"QuestionBankCellIdentifier";
static NSString * const QuestionBankSimulationCellIdentifier = @"QuestionBankSimulationCellIdentifier";
static NSString * const QuestionBankUserRightCellIdentifier = @"QuestionBankUserRightCellIdentifier";
static NSString * const QuestionBankBannerMenuCellIdentifier = @"QuestionBankBannerMenuCellIdentifier";

@interface QuestionBankViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) QuestionClassificationModel * model;

@property (nonatomic,strong) NSMutableArray * bannerArray;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,copy) NSString * primaryClassificationID;
@property (nonatomic,copy) NSString * secondaryClassificationID;
@property (nonatomic,strong) NSArray *identifierArr;
@property (nonatomic,copy) NSString *examName;
@property (nonatomic,copy) NSString *exchangeName;
@property (nonatomic,strong) QuestionClassCategoryModel * categoryModel;
@property (nonatomic,strong) NSDictionary * trueSubjectDic;
@end

@implementation QuestionBankViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    self.bannerArray = [NSMutableArray  arrayWithCapacity:0] ;

    @weakify(self);

    [[URCommonApiManager  sharedInstance] getQuestionClassificationDataWithRequestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self);
        
        self.model = response ;
        
        self.primaryClassificationID = [NSString  stringWithFormat:@"%@",self.model.data[0].idStr?:@""] ;
        
        self.secondaryClassificationID = [NSString  stringWithFormat:@"%@",self.model.data[0].subjects[0].idStr?:@""] ;
        
        [self.model.data1  enumerateObjectsUsingBlock:^(QuestionClassificationBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self.bannerArray  addObject:obj.thumbnail];
            
        }];
        
        [self getUnitListData] ;
        
        [self.collectionView reloadData];

    } requestFailureBlock:^(NSError *error, id response) {
        
    }] ;
}

-(void)getUnitListData{
  
    @weakify(self) ;
    [[URCommonApiManager  sharedInstance] getItemCategoryDataWithSubjectID:self.secondaryClassificationID?:@"" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self) ;
        
        self.categoryModel = response ;
        self.trueSubjectDic = responseDict[@"data"][0];
        [self.collectionView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cBtnLeft.hidden = YES;
    self.lblTitle.text = @"VIP题库" ;
    self.identifierArr = is_online == 0 ? @[QuestionBankBannerMenuCellIdentifier,QuestionBankSimulationCellIdentifier,QuestionBankCellIdentifier] : @[QuestionBankBannerMenuCellIdentifier,QuestionBankSimulationCellIdentifier,QuestionBankCellIdentifier]; //QuestionBankUserRightCellIdentifier
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LoginSuccessNoti" object:nil] subscribeNext:^(id x) {
        [self getUnitListData];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.identifierArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];
    return [identifier isEqualToString:QuestionBankCellIdentifier] ? self.categoryModel.data.count : 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = self.identifierArr[indexPath.section];
    
    if ([identifier isEqualToString:QuestionBankBannerMenuCellIdentifier])
    {
        QuestionBankBannerMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QuestionBankBannerMenuCellIdentifier forIndexPath:indexPath];
               
        // 菜单
        cell.menu.menuArr = self.model.data;
        cell.bannerArray = self.bannerArray ;
        QuestionClassificationTitleModel *model = self.model.data[0];
        self.exchangeName = model.subjects[0].name;
        
        cell.menu.selectMenuBlcok = ^(QuestionClassificationTitleModel * _Nonnull menu1Model, CourseClassificationCoursesModel * _Nullable menu2Model) {
            
            self.primaryClassificationID = [NSString  stringWithFormat:@"%@",menu1Model.idStr?:@""] ;
            
            self.secondaryClassificationID = [NSString  stringWithFormat:@"%@",menu2Model.idStr?:@""] ;
            self.examName = menu2Model.name;
            [self  getUnitListData] ;
            
            [self.collectionView reloadData];
        };
        return cell;
    }
    else if ([identifier isEqualToString:QuestionBankUserRightCellIdentifier])
    {
        QuestionBankUserRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QuestionBankUserRightCellIdentifier forIndexPath:indexPath];
        
        [[[cell.userRightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            
            if(userLoginStatus ==YES){
                [self alertUserVipRight];
            }else {
                [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
            }
        }];
        return cell;
    }
    else if ([identifier isEqualToString:QuestionBankSimulationCellIdentifier])
    {
        QuestionBankSimulationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QuestionBankSimulationCellIdentifier forIndexPath:indexPath];
        //牛刀小试
        [[[cell.examNowBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            
            [self examNowWithType:TestType_Simulation];
        }];
        return cell;
    }
    else
    {
        QuestionBankCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QuestionBankCellIdentifier forIndexPath:indexPath];
        cell.model = self.categoryModel.data[indexPath.row];
        
        if (indexPath.row == 0) {
            if ([self.trueSubjectDic[@"have_new"] isEqualToNumber:@1]) {
                [cell.redView setHidden:NO];
            } else {
                [cell.redView setHidden:YES];
            }
        }
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        return footer;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = self.identifierArr[indexPath.section];
    
    QuestionClassCategoryDataModel * dataModel = self.categoryModel.data[indexPath.row];

    if ([identifier isEqualToString:QuestionBankCellIdentifier]){
        if(userLoginStatus ==YES){
            
            if ([dataModel.name  isEqualToString:@"每日真题"])
            {
//                UnitPracticeViewController * practiceViewController = [[UnitPracticeViewController  alloc] init];
//                practiceViewController.hidesBottomBarWhenPushed = YES ;
//                practiceViewController.primaryClassificationID = self.primaryClassificationID?:@"";
//                practiceViewController.secondaryClassificationID = self.secondaryClassificationID?:@"" ;
//                [self.navigationController pushViewController:practiceViewController animated:YES];
                DailyQuestionsViewController *questionVC = [[DailyQuestionsViewController alloc] init];
                questionVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:questionVC animated:YES];
            }
            else if ([dataModel.name  isEqualToString:@"历年真题"])
            {
                [self examNowWithType:TestType_Original];
            }
            else if ([dataModel.name isEqualToString:@"考前密题"])
            {
                if (is_online == 0) {
//                    [URToastHelper  showErrorWithStatus:@"该功能暂未开放"] ;
                    ImgVideoQuestionBankVC * controller = [[ImgVideoQuestionBankVC alloc] init];
                    controller.hidesBottomBarWhenPushed = YES ;
                    controller.type = @"1";
                    controller.subjectID  = self.secondaryClassificationID?:@"" ;
                    [self.navigationController pushViewController:controller animated:YES];
                } else {
                    if ([URUserDefaults standardUserDefaults].userInforModel.is_vip.integerValue == 0)
                    {
                         //不是会员
                        [self alertUserVipRight];
                    }
                    else//已经是会员
                    {
                        SecretVolumeViewController * volumeViewController = [[SecretVolumeViewController  alloc] init];
                        
                        volumeViewController.primaryClassificationID = self.primaryClassificationID?:@"";
                        volumeViewController.secondaryClassificationID = self.secondaryClassificationID?:@"" ;
                        
                        volumeViewController.hidesBottomBarWhenPushed = YES ;
                        [self.navigationController pushViewController:volumeViewController animated:YES];
                    }
                }
            }
            else if ([dataModel.name  isEqualToString:@"错题排行"])
            {
                WrongTopicVC *vc = [[WrongTopicVC  alloc] init];
                vc.hidesBottomBarWhenPushed = YES ;
                vc.primaryClassificationID = self.primaryClassificationID?:@"";
                vc.secondaryClassificationID = self.secondaryClassificationID?:@"" ;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([dataModel.name  isEqualToString:@"图片题库"] || [dataModel.name  isEqualToString:@"视频题库"])
            {
                ImgVideoQuestionBankVC * controller = [[ImgVideoQuestionBankVC alloc] init];
                controller.hidesBottomBarWhenPushed = YES ;
                controller.type = [dataModel.name  isEqualToString:@"图片题库"]?@"1":@"2" ;
                controller.subjectID  = self.secondaryClassificationID?:@"" ;
                [self.navigationController pushViewController:controller animated:YES];
            }
        }else{
            [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = self.identifierArr[indexPath.section];
    
    if ([identifier isEqualToString:QuestionBankBannerMenuCellIdentifier])
    {
        return CGSizeMake(URScreenWidth(), (146+50*2+1) * AUTO_WIDTH);
    }
    else if ([identifier isEqualToString:QuestionBankUserRightCellIdentifier])
    {
        return CGSizeMake(URScreenWidth(), 50 * AUTO_WIDTH);
    }
    else if ([identifier isEqualToString:QuestionBankSimulationCellIdentifier])
    {
        return CGSizeMake(URScreenWidth(), 50 * AUTO_WIDTH);
    }
    else {
        return CGSizeMake(170 * AUTO_WIDTH, 83 * AUTO_WIDTH);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(URScreenWidth(), 8);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];
    
    if ([identifier isEqualToString:QuestionBankCellIdentifier])
    {
        return UIEdgeInsetsMake(0, 12, 0, 12);
    }else {
        return UIEdgeInsetsZero;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];
    
    if ([identifier isEqualToString:QuestionBankCellIdentifier])
    {
        return 9;
    }else {
        return 0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    NSString *identifier = self.identifierArr[section];

    if ([identifier isEqualToString:QuestionBankCellIdentifier])
    {
        return 9;
    }else {
        return 0;
    }
}


//牛刀小试、真题训练
-(void)examNowWithType:(TestType)testType
{
    if (userLoginStatus)
    {
        TrainingViewController * viewController  = [[TrainingViewController alloc] init];
        viewController.testType = testType ;
        
        viewController.primaryClassificationID = self.primaryClassificationID?:@"";
        viewController.secondaryClassificationID = self.secondaryClassificationID?:@"" ;
        viewController.examName = self.examName?:self.exchangeName;
        viewController.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
    }
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
        [_collectionView registerClass:[QuestionBankUserRightCell class] forCellWithReuseIdentifier:QuestionBankUserRightCellIdentifier];
        [_collectionView registerClass:[QuestionBankBannerMenuCell class] forCellWithReuseIdentifier:QuestionBankBannerMenuCellIdentifier];
        [_collectionView registerClass:[QuestionBankCell class] forCellWithReuseIdentifier:QuestionBankCellIdentifier];
        [_collectionView registerClass:[QuestionBankSimulationCell class] forCellWithReuseIdentifier:QuestionBankSimulationCellIdentifier];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}



@end
