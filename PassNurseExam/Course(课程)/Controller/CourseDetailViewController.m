//
//  CourseDetailViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "CourseDetailViewController.h"

#import "CourseDetailTopInfoCell.h"
#import "CourseDetailTeacherCell.h"
#import "CourseDetailMenuCell.h"
#import "CourseDetailSubCatalogueCell.h"
#import "CourseDetailMaterialsCell.h"
#import "CourseDetailProblemSolvingCell.h"
#import "CourseDetailCatalogueHeader.h"

#import "CourseDownloadFileInfoModel.h"

#import "CourseTeacherViewController.h"
#import "CourseDownloadViewController.h"

#define countTime 10*60
static NSString * const CourseDetailTopInfoCellIdentifier = @"CourseDetailTopInfoCellIdentifier";
static NSString * const CourseDetailTeacherCellIdentifier = @"CourseDetailTeacherCellIdentifier";
static NSString * const CourseDetailMenuCellIdentifier = @"CourseDetailMenuCellIdentifier";
static NSString * const CourseDetailSubCatalogueCellIdentifier = @"CourseDetailSubCatalogueCellIdentifier";
static NSString * const CourseDetailMaterialsCellIdentifier = @"CourseDetailMaterialsCellIdentifier";
static NSString * const CourseDetailProblemSolvingCellIdentifier = @"CourseDetailProblemSolvingCellIdentifier";


@interface CourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) CourseCommonDetailModel * detailModel;
@property (nonatomic,assign) NSInteger currentShowItem;//当前展示的内容0：课程目录，1：配套资料，2：问题解答
@property (nonatomic,assign) NSInteger currentChapterIndex;//当前章节的 index
@property (nonatomic,assign) NSInteger curriculumIndex;//当前章节中课件 index

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;
@property (nonatomic, copy) NSURL * currentPlayURL;//当前播放的url

@property (nonatomic, copy) NSString *typeIdStr;
@property (nonatomic, strong) NSTimer *popTimer; //弹出签到按钮计时器
@property (nonatomic, strong) UIButton *signBtn;
@property (nonatomic, assign) BOOL isfullScreen;
@property (nonatomic, copy) NSString * currentPlayURLStr;//当前播放的url
@property (nonatomic, copy) NSString * currentName;//当前播放课程的名字

@end

@implementation CourseDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.player.viewControllerDisappear = NO;
    [self requestCourseDetail];
}

- (void)requestCourseDetail
{
    @weakify(self) ;
    
    [[URCommonApiManager  sharedInstance] getChapterCurriculumsDataWithStageID:self.stageID?:@"" userToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self) ;
        
        self.detailModel = response ;
        
        NSString * urlstr ;
        
        if (self.detailModel.data.count>0) {
            urlstr = self.detailModel.data[0].thumbnail ;
        } else {
            urlstr = @"" ;
        }
        
        [self.containerView setImageWithURLString:urlstr placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
        
        self.playBtn.hidden = YES ;
        
        [self.tableView reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.player.viewControllerDisappear = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"精品课程" ;
    
    [self.cBtnRight setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [[self.cBtnRight  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    self.cBtnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -44 * AUTO_WIDTH) ;
    
    
    UIView * tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, URSafeAreaNavHeight(), URScreenWidth(), 210 * AUTO_WIDTH)];
    [self.view addSubview:tableHeaderView];
    [tableHeaderView addSubview:self.containerView];
    [self.containerView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.containerView addSubview:self.playBtn];
    [self.playBtn   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.containerView);
        make.left.mas_equalTo((URScreenWidth()-60)/2);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    self.signBtn = [UIButton ImgBtnWithImageName:@"考勤1"];
    [self.controlView addSubview:self.signBtn];
    [self.signBtn setHidden:YES];
    [self.signBtn addTarget:self action:@selector(checkOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.controlView);
//        make.right.equalTo(self.controlView).offset(-20);
        make.centerX.equalTo(self.controlView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        self_weak_.isfullScreen = isFullScreen;
        if (!isFullScreen) {
            [self_weak_.signBtn setHidden:YES];
        }
        [self setNeedsStatusBarAppearanceUpdate];
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        
        [self.player stop];
        
        //        [self.player.currentPlayerManager replay];
        //        [self.player playTheNext];
        //        if (!self.player.isLastAssetURL) {
        //            [self.controlView showTitle:@"" coverURLString:@"" fullScreenMode:ZFFullScreenModeLandscape];
        //        } else {
        //
        //        }
    };
    
    self.player.assetURLs = self.assetURLs;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(tableHeaderView.mas_bottom);
    }];
    
    //设置默认
    self.currentShowItem = 0;
    self.currentChapterIndex = -1;
    self.curriculumIndex = -1;
}

-(void)navRightPressed:(id)sender {
    URSharedView * sharedView= [[URSharedView  alloc] init];
    NSString *sharePath = [NSString stringWithFormat:@"pages/sharePage1/sharePage1?url=%@&title=%@",self.currentPlayURLStr?:@"",self.currentName?:@""];
    NSDictionary *shareInfo = @{@"title":self.currentName?:@"",@"descr":@"",@"shareUrl":@"https://www.baidu.com",@"path":sharePath,@"userName":@"gh_e9ff3903a4a4",@"imgName":[self getImgName]};
    [sharedView shareMiniProgramWithDict:shareInfo];
}
- (NSString *)getImgName {
    if ([self.courseID isEqualToString:@"4"]) {
        return @"课程-护士资格";
    } else if ([self.courseID isEqualToString:@"2"]) {
        return @"课程-初级护师";
    } else {
        return @"课程-健康管理师";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.currentShowItem == 0) {
        return 3 + self.detailModel.data.count;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section < 3) {
        return 1;
    }
    if (self.currentShowItem == 0) {
        CourseCommonDetailDataModel * dataModel = self.detailModel.data[section-3];
        return dataModel.selected ? dataModel.curriculums.count : 0;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)//课程信息
    {
        CourseDetailTopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseDetailTopInfoCellIdentifier];
        [cell.downloadBtn addTarget:self action:@selector(downloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.collectBtn addTarget:self action:@selector(checkOnClick) forControlEvents:UIControlEventTouchUpInside];
        if (self.currentChapterIndex == -1)//显示默认信息
        {
            cell.model = self.detailModel.data1;
        }else
        {
            if (self.curriculumIndex >= 0)//显示选中 的课件内容
            {
                cell.curriculumsModel = self.detailModel.data[self.currentChapterIndex].curriculums[self.curriculumIndex];
            }
            else//显示选中的章节内容
            {
                cell.chapterModel = self.detailModel.data[self.currentChapterIndex];
            }
        }
        
        return cell;
    }
    else if (indexPath.section == 1)//老师信息
    {
        CourseDetailTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseDetailTeacherCellIdentifier];
        
        if (self.currentChapterIndex == -1)
        {
            // 显示默认信息
            cell.dataModel1 = self.detailModel.data1;
        }else
        {
            // 老师的信息 会 随着 章节变动而变动
            cell.dataModel = self.detailModel.data[self.currentChapterIndex];
        }
        return cell;
    }
    else if (indexPath.section == 2)//菜单
    {
        CourseDetailMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseDetailMenuCellIdentifier];
        
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(NSNumber *index) {

            self.currentShowItem = [index intValue];
            [self.tableView reloadData];
        }];
        return cell;
    }
    else
    {
        if (self.currentShowItem == 0)//章节列表
        {
            CourseDetailSubCatalogueCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseDetailSubCatalogueCellIdentifier];
            if (self.detailModel.data.count>0) {
                cell.curriculumsModel = self.detailModel.data[indexPath.section-3].curriculums[indexPath.row];
            }
            return cell;
        }
        else if (self.currentShowItem == 1)//配套资料
        {
            CourseDetailMaterialsCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseDetailMaterialsCellIdentifier];
            [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.data1.kit] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                [cell.iconView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(image.size.height * URScreenWidth()/image.size.width);
                }];
            }];
            return cell;
        }
        else//问题解答
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseDetailProblemSolvingCellIdentifier];
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 2 && self.currentShowItem == 0)
    {
        CourseDetailCatalogueHeader *header = [[CourseDetailCatalogueHeader alloc] initWithFrame:CGRectMake(0, 0, URScreenWidth(), 42 * AUTO_WIDTH)];
        CourseCommonDetailDataModel * dataModel = self.detailModel.data[section-3];
        header.dataModel = dataModel ;
        header.noLb.text = [NSString stringWithFormat:@"%02zd.",section-2];
        
        [[header.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [self.detailModel.data enumerateObjectsUsingBlock:^(CourseCommonDetailDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx == section - 3)
                {
                    obj.selected = !obj.selected;
                    self.currentChapterIndex = idx;
                    self.curriculumIndex = -1;
                }else {
                    obj.selected = NO;
                }
            }];
            [self.tableView reloadData];
        }];
        return header;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section > 2 && self.currentShowItem == 0) ? 42 * AUTO_WIDTH : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section > 2 && self.currentShowItem == 0) ? 0.01 : 9 * AUTO_WIDTH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        CourseTeacherViewController * teacherViewController = [[CourseTeacherViewController alloc] init];
        
        if (self.currentChapterIndex == -1)// 此时显示的是老师的默认信息
        {
            if (self.detailModel.data1.teachers.count > 0)
            {
                BaseCourseTeacherModel *teacher = self.detailModel.data1.teachers[0];
                teacherViewController.teacherID = teacher.idStr;
            }
            [self.navigationController pushViewController:teacherViewController animated:YES];
        }
        else// 因为老师的信息 会 随着 章节变动而变动，所以，要获取当前展开并选择的章节
        {
            if (self.detailModel.data.count > 0)
            {
                teacherViewController.teacherID = [NSString  stringWithFormat:@"%@",self.detailModel.data[self.currentChapterIndex].teacher_id ?: @""];
            }
            [self.navigationController pushViewController:teacherViewController animated:YES];
        }
    }
    else if (indexPath.section>2  && self.currentShowItem == 0)
    {
        //未登录
        if (userLoginStatus == NO)
        {
            [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
            return;
        }
        
        //已登录
        CourseCommonDetailDataCurriculumsModel *curriculumsModel = self.detailModel.data[indexPath.section-3].curriculums[indexPath.row];

        if (curriculumsModel.vip.intValue == 1)//会员课程
        {
            if ([URUserDefaults standardUserDefaults].userInforModel.is_vip.intValue == 0)//还不是会员
            {
                if (is_online == 0)//未上线
                {
                    [URToastHelper showErrorWithStatus:@"您还不是会员，暂不可观看"];
                }
                else//已上线，会员支付页面
                {
                    [URAlert  alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"开通会员之后才可以观看该视频，是否立即开通!" cancelButtonTitle:@"取消" sureButtonTitles:@"立即开通" viewController:self handler:^(NSInteger buttonIndex) {
                        
                        if (buttonIndex==1) {
                             MemberPayAlertView * payAlertView = [[MemberPayAlertView  alloc] init];
                                                [payAlertView showAlertView:@{@"buyType":@"1"} finish:^{
                                                     
                                                }];
                            [self requestCourseDetail];
                        }
                    }];
                }
                return ;
            }
            //已经是会员
            [self playVideo:indexPath];
        } else
        {
            if (curriculumsModel.charge.intValue==1)//付费课程
            {
                if (curriculumsModel.own.intValue==0)//未购买
                {
                    if (is_online==0)//未上线
                    {
                        [URToastHelper showErrorWithStatus:@"暂不可观看"];
                    }
                    else//已上线，走购买流程
                    {
                        [URAlert  alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"购买之后才可以观看该视频，是否立即购买!" cancelButtonTitle:@"取消" sureButtonTitles:@"立即购买" viewController:self handler:^(NSInteger buttonIndex) {
                            
                            if (buttonIndex==1)
                            {
                                 MemberPayAlertView * payAlertView = [[MemberPayAlertView  alloc] init];
                                 [payAlertView showAlertView:@{@"buyType":@"2",
                                                               @"univalence":curriculumsModel.univalence,
                                                               @"idStr":curriculumsModel.idStr,
                                                               @"courseBuyType":@"curriculum"} finish:^{
                                     
                                     [self requestCourseDetail];
                                 }];
                            }
                        }];
                    }
                    return;
                }
                //已购买
                [self playVideo:indexPath];
            }
            else//免费课程
            {
                [self playVideo:indexPath];
            }
        }
    }
}

-(void)popOverClickBtn {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CourseDetailTopInfoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.collectBtn.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @1.0;
    animation.toValue = @0;
    animation.duration = 5;
    [cell.collectBtn.layer addAnimation:animation forKey:nil];
    if (self.isfullScreen) {
        self.signBtn.hidden = NO;
        [self.signBtn.layer addAnimation:animation forKey:nil];
    }
}

- (void)playVideo:(NSIndexPath *)indexPath
{
    self.playBtn.hidden = NO ;
    if (self.curriculumIndex == -1) {
        self.popTimer = [NSTimer scheduledTimerWithTimeInterval:10*60 target:self selector:@selector(popOverClickBtn) userInfo:nil repeats:YES];
    }
    
    if (self.curriculumIndex != indexPath.row) {
        [self.popTimer invalidate];
        self.popTimer = nil;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        CourseDetailTopInfoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        self.popTimer = [NSTimer scheduledTimerWithTimeInterval: countTime target:self selector:@selector(popOverClickBtn) userInfo:nil repeats:YES];
        cell.collectBtn.hidden = YES;
    }
    
    CourseCommonDetailDataCurriculumsModel *curriculumsModel = self.detailModel.data[indexPath.section-3].curriculums[indexPath.row];
    self.typeIdStr = curriculumsModel.idStr;
    self.currentName = curriculumsModel.name;
    self.currentPlayURLStr = curriculumsModel.play_address;
    
    [[URCommonApiManager   sharedInstance] sendCourseClickStatisticsRquestWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" type:@"curriculum" type_id:curriculumsModel.idStr?:@"" time_stamp:appStartUpTime requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }] ;
   
    //  有的文件已经下载完毕或者下载了一部分，需要知道进度信息，调用此方法返回 已经存在文件的进度信息
    TaskProgressInfo *info = [[DownloadManager shareManager] progressInfoIfFileExsit:curriculumsModel.download_address];

    //已经下载
    if (info && info.progress >= 1)
    {
        NSArray *safeFileList = [[CourseDownloadFileInfoModel shareInstance] loadFileList:@"course"];

        [safeFileList enumerateObjectsUsingBlock:^(FileModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //表示 校验成功，此课程是我的账号购买并下载的
            if ([obj.checkCode isEqualToString:curriculumsModel.md5]) {
                
                [URToastHelper showWithStatus:@"正在解析下载视频"];
                [[CourseDownloadFileInfoModel shareInstance] funcDeFile:curriculumsModel.download_address finishBlock:^(NSString *path) {
                     //解码后返回 path
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [URToastHelper dismiss];
                         self.player.assetURL = [NSURL fileURLWithPath:path];
                         self.currentPlayURL = [NSURL fileURLWithPath:path];
                     });
                }];
                
                *stop = YES;
                return ;
            }
        }];
        
    }else
    {
        self.player.assetURL = [NSURL URLWithString:[NSString  stringWithFormat:@"%@",curriculumsModel.play_address]];
        self.currentPlayURL = [NSURL URLWithString:[NSString  stringWithFormat:@"%@",curriculumsModel.play_address]];
    }
    
    self.curriculumIndex = indexPath.row;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)downloadButtonClick:(UIButton *)btn
{
    //未登录
    if (userLoginStatus == NO)
    {
        [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
        return;
    }
    
    //已登录
    CourseDownloadViewController * downloadViewController = [[CourseDownloadViewController alloc] init];
    downloadViewController.detailModel = self.detailModel;
    
    downloadViewController.backVideoPathBlock = ^(NSString * _Nonnull path) {
        //已下载视频 解码后返回 path
        dispatch_async(dispatch_get_main_queue(), ^{
            self.playBtn.hidden = NO;
            self.player.assetURL = [NSURL fileURLWithPath:path];
            self.currentPlayURL = [NSURL fileURLWithPath:path];
        });
    };
    [self.navigationController pushViewController:downloadViewController animated:YES];
}

-(void)checkOnClick{
    
    [[URCommonApiManager sharedInstance] clickStatisticsWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" type_id:self.typeIdStr ? : @"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        [URToastHelper showErrorWithStatus:@"操作成功"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        CourseDetailTopInfoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.collectBtn.hidden = YES;
        self.signBtn.hidden = YES;
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
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
        _tableView.separatorColor = UR_COLOR_LINE;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
        [_tableView registerClass:[CourseDetailTopInfoCell class] forCellReuseIdentifier:CourseDetailTopInfoCellIdentifier];
        [_tableView registerClass:[CourseDetailTeacherCell class] forCellReuseIdentifier:CourseDetailTeacherCellIdentifier];
        [_tableView registerClass:[CourseDetailMenuCell class] forCellReuseIdentifier:CourseDetailMenuCellIdentifier];
        [_tableView registerClass:[CourseDetailSubCatalogueCell class] forCellReuseIdentifier:CourseDetailSubCatalogueCellIdentifier];
        [_tableView registerClass:[CourseDetailMaterialsCell class] forCellReuseIdentifier:CourseDetailMaterialsCellIdentifier];
        [_tableView registerClass:[CourseDetailProblemSolvingCell class] forCellReuseIdentifier:CourseDetailProblemSolvingCellIdentifier];
    }
    return _tableView;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
        _controlView.prepareShowControlView = YES;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        
        [_containerView setImageWithURLString:self.detailModel.data[0].thumbnail?:@"" placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (void)playClick:(UIButton *)sender {
    
    self.player.assetURL = [NSURL URLWithString:[NSString  stringWithFormat:@"%@",self.currentPlayURL]] ;
    
//    [self.controlView showTitle:@"" coverURLString:self.currentPlayURL.absoluteString fullScreenMode:ZFFullScreenModeAutomatic];
}

@end
