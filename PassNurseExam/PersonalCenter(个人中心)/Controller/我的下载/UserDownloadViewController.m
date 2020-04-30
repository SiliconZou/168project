//
//  UserDownloadViewController.m
//  PassNurseExam
//
//  Created by 王星琛 on 20/10/2019.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "UserDownloadViewController.h"
#import "CourseDownloadFileInfoModel.h"

@interface UserDownloadCell : UITableViewCell

@property (nonatomic ,strong) UILabel *nameLb;
@property (nonatomic,strong) UIImageView *videoImgV;
@end

@implementation UserDownloadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.videoImgV];
    
    [self.videoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70 * AUTO_WIDTH, 40 * AUTO_WIDTH));
        make.left.mas_offset(15 * AUTO_WIDTH);
        make.top.mas_offset(15 * AUTO_WIDTH);
        make.bottom.mas_offset(-15  * AUTO_WIDTH);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.videoImgV.mas_right).offset(15 * AUTO_WIDTH);
        make.top.mas_equalTo(self.videoImgV);
        make.right.mas_offset(-15 * AUTO_WIDTH);
    }];
}

- (UIImageView *)videoImgV
{
    if (!_videoImgV) {
        _videoImgV = [UIImageView new];
    }
    return _videoImgV;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:2];
    }
    return _nameLb;
}

@end

static NSString * const UserDownloadCellIdentifier = @"UserDownloadCellIdentifier";

@interface UserDownloadViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *list;
@property (nonatomic ,strong) NSMutableArray * courseArray;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@property (nonatomic,strong) UIView * tableHeaderView;

@end

@implementation UserDownloadViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    self.list = [[CourseDownloadFileInfoModel shareInstance] loadFileList:@"course"];
    
    [[URCommonApiManager  sharedInstance] getUserAllCurriculumDataWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        UsergetAllCurriculumModel * model = response ;
        
        if (model.data.count>0) {
            
            self.courseArray = [NSMutableArray  arrayWithCapacity:0] ;
            
            [model.data  enumerateObjectsUsingBlock:^(UsergetAllCurriculumDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.list  enumerateObjectsUsingBlock:^(FileModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([obj.md5  isEqualToString:model.checkCode]) {
                        
                        [self.courseArray  addObject:model];
                                                
                        *stop = YES ;
                        
                        return  ;
                    }
                }] ;
            }];
        }
        
        [self.tableView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"我的下载" ;
 
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];
    
    self.tableHeaderView = [[UIView  alloc] initWithFrame:CGRectMake(0, URSafeAreaNavHeight(), URScreenWidth(), 210 * AUTO_WIDTH)];
    self.tableHeaderView.hidden = YES ;
    [self.view  addSubview:self.tableHeaderView];
    [self.tableHeaderView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    

    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;

    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };

    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player stop];
        
        self.tableHeaderView.hidden = YES ;
        
        [self.tableView  mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(URSafeAreaNavHeight()) ;
        }];
        
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:UserDownloadCellIdentifier];
    
    FileModel *model = self.courseArray[indexPath.row];

    cell.nameLb.text = model.courseName;
    cell.selectionStyle  = UITableViewCellSelectionStyleNone ;
    cell.videoImgV.image = [UIImage firstFrameWithVideoURL:[NSURL URLWithString:model.playUrl] size:CGSizeMake(70, 70)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileModel *model = self.courseArray[indexPath.row];
   
    [URToastHelper showWithStatus:@"正在解析下载视频"];
    [[CourseDownloadFileInfoModel shareInstance] funcDeFile:model.downloadUrl finishBlock:^(NSString *path) {
         //解码后返回 path
         dispatch_async(dispatch_get_main_queue(), ^{
             [URToastHelper dismiss];
             
             self.tableHeaderView.hidden= NO ;
             [self.tableView  mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.top.mas_equalTo(URSafeAreaNavHeight() + 210 * AUTO_WIDTH) ;
             }];
             
             self.player.assetURL = [NSURL fileURLWithPath:path];
         });
    }];
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
    }
    return _containerView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.rowHeight = 84.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
        [_tableView registerClass:[UserDownloadCell class] forCellReuseIdentifier:UserDownloadCellIdentifier];
        
    }
    return _tableView;
}

@end
