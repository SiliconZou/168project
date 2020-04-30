//
//  LiveCourseRecommendViewController.m
//  PassNurseExam
//
//  Created by quchao on 2019/10/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveCourseRecommendViewController.h"
#import "LiveSectionCourseTitleTableViewCell.h"
#import "LiveSectionTeacherInforTableViewCell.h"
#import "LiveSectionTextChatTableViewCell.h"
#import "LiveSectionPDFTableViewCell.h"
#import "LiveSectionImgInfoCell.h"
#import "LiveSectionMenuCell.h"
#import "LiveSectionCatalogCell.h"
#import "LiveSectionSendQuestionCell.h"
#import "LiveSectionCatalogHeader.h"
#import "LiveSecionBottomView.h"
#import "NELiveDetailVideoView.h"
#import "GiftAlertView.h"
#import "BuyCourseVC.h"
#import "GiftAlertView.h"
#import "NELCInputView.h"
#import "GrabAnswerView.h"
#import "AdminiMoreToolAlertView.h"
#import "StatisticsAlert1.h"
#import "StatisticsAlert2.h"
#import "LiveSectionManagerView.h"
#import "LiveSectionViesAnswerModel.h"


static  NSString * const  LiveSectionCourseTitleTableViewCellIdentifier = @"LiveSectionCourseTitleTableViewCellIdentifier" ;
static  NSString * const  LiveSectionTeacherInforTableViewCellIdentifier = @"LiveSectionTeacherInforTableViewCellIdentifier" ;

static  NSString * const  LiveSectionMenuThreeCellIdentifier = @"LiveSectionMenuThreeCellIdentifier" ;
static  NSString * const  LiveSectionMenuFourCellIdentifier = @"LiveSectionMenuFourCellIdentifier" ;
static  NSString * const  LiveSectionMenuManagerCellIdentifier = @"LiveSectionMenuManagerCellIdentifier" ;

static  NSString * const  LiveSectionImgInfoCellIdentifier = @"LiveSectionImgInfoCellIdentifier" ;
static  NSString * const  LiveSectionCatalogCellIdentifier = @"LiveSectionCatalogCellIdentifier" ;
static  NSString * const  LiveSectionChatTextCellIdentifier = @"LiveSectionChatTextCellIdentifier" ;
static  NSString * const  LiveSectionPDFCellIdentifier = @"LiveSectionPDFCellIdentifier" ;
static  NSString * const  LiveSectionOnlineAnswerCellIdentifier = @"LiveSectionOnlineAnswerCellIdentifier" ;

static  NSString * const  LiveSectionSendQuestionCellIdentifier = @"LiveSectionSendQuestionCellIdentifier" ;

@interface LiveCourseRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) CourseHomeMenuView *menu;
@property (nonatomic,strong) LiveSecionBottomView * bottomView;
@property (nonatomic,strong) NELCInputView *inputView;
@property (nonatomic,strong) NELiveDetailVideoView *videoView;
@property (nonatomic,strong) AdminiMoreToolAlertView *adminView;
@property (nonatomic,strong) GiftAlertView *giftAler;

//0：课程详情，1：课程目录，2：配套资料，3：直播大厅，4：电子讲义，5：在线抢答，
@property (nonatomic,assign) NSInteger menuIndex;

@property (nonatomic,strong) LiveSectionDetailModel * detailModel;
@property (nonatomic,strong) LiveGivingModel * givingModel;

@property (nonatomic,strong) NSMutableArray <LivePenetrateMsgModel *> * chatTextArray;

@property (nonatomic,strong) NSMutableArray <LiveSectionAllQuestionsDataModel *>* onlineAnswerArray;

@property (nonatomic,strong) NSMutableArray * viesAnswerArray;

@property (nonatomic,strong) NSMutableArray * selectedAnswerArray;

@property (nonatomic,copy) NSString * teacherID;

@property (nonatomic,copy) NSString * selectedSectionID;

@property (nonatomic,strong) LiveSectionDetailData1SectionModel * selModel;

@property (nonatomic,strong) LiveSectionAllQuestionsModel * questionsModel;

@property (nonatomic,strong) StatisticsAlert1 * statisticsAlert1;

@property (nonatomic,strong) StatisticsAlert2 * statisticsAlert2;

@property (nonatomic,strong) LiveSectionManagerView * managerView;

@property (nonatomic,assign) NSInteger sourceTag ;

/**
 禁言状态
 */
@property (nonatomic,assign) NSInteger bannedStatus;

@property (nonatomic,assign) NSInteger  selectedTextTag;

@property (nonatomic,copy) NSString * pushQuestionID ;

@property (nonatomic,strong) UILabel * teacherNameLabel;
@property (nonatomic,strong) UIImageView * teacherImage;
@property (nonatomic,strong) UILabel * onLineNumLabel;

@property (nonatomic,strong) UIButton *playBtn;

@property (nonatomic,strong) UILabel *playTimeLb;

@property (nonatomic,strong) UIButton *signBtn;

@property (nonatomic,copy) NSString *stateStr;

@property (nonatomic,assign) int judgeValue;
@end

@implementation LiveCourseRecommendViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    
    self.chatTextArray = [NSMutableArray   arrayWithCapacity:0] ;
    
    self.onlineAnswerArray = [NSMutableArray  arrayWithCapacity:0] ;
    
    self.viesAnswerArray = [NSMutableArray  arrayWithCapacity:0] ;
    
    [self  getLiveSectionDetailData];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;//隐藏 条
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;//点击背景收回键盘
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self  getUserLiveRoomStatusWithType:@"2"] ;
    
    [self.videoView.videoView _deallocPlayer];
    
    NSSet * set = [NSSet  setWithObject:[NSString  stringWithFormat:@"live%@",self.detailModel.data.idStr?:@""]];
    
    [JPUSHService  deleteTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0] ;
    
    //恢复右滑返回
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}

-(void)navLeftPressed{
    
    [self  getUserLiveRoomStatusWithType:@"2"] ;
    
    [self.videoView.videoView _deallocPlayer];
    
    NSSet * set = [NSSet  setWithObject:[NSString  stringWithFormat:@"live%@",self.detailModel.data.idStr?:@""]];
    
    [JPUSHService  deleteTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0] ;
    
    //恢复右滑返回
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"直播" ;
    
    self.selectedSectionID = @"4" ;
    
    self.bannedStatus = 0 ;

    [self.view  addSubview:self.videoView];
    [self.view  addSubview:self.bottomView];
    [self.view  addSubview:self.inputView];
    [self.view  addSubview:self.tableView];
    [self.videoView addSubview:self.playBtn];
    [self.videoView addSubview:self.playTimeLb];
    [self.videoView.videoView addSubview:self.signBtn];
    [self.videoView addSubview:self.teacherImage];
    [self.videoView addSubview:self.teacherNameLabel];
    [self.videoView addSubview:self.onLineNumLabel];
    
    self.tableView.frame = CGRectMake(0, URSafeAreaNavHeight()+(URScreenWidth()/16 *9), URScreenWidth(), URScreenHeight()-(URSafeAreaNavHeight()+(URScreenWidth()/16 *9)));
     
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom) ;
        make.left.mas_offset(0);
        make.width.mas_equalTo(URScreenWidth());
        make.height.mas_equalTo(49 * AUTO_WIDTH);
    }];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom) ;
        make.left.mas_offset(0);
        make.width.mas_equalTo(URScreenWidth());
        make.height.mas_equalTo(49 * AUTO_WIDTH);
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.videoView);
        make.centerY.mas_equalTo(self.videoView);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [self.playTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.playBtn.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(self.videoView);
        make.height.mas_equalTo(20);
    }];
    
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.videoView.videoView).offset(-20);
        make.centerX.mas_equalTo(self.videoView.videoView);
        make.centerY.mas_equalTo(self.videoView.videoView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.teacherImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10 *AUTO_WIDTH) ;
        make.size.mas_equalTo(CGSizeMake(20 *AUTO_WIDTH, 20 *AUTO_WIDTH)) ;
    }];
    
    [self.teacherNameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.teacherImage.mas_right).mas_offset(10 *AUTO_WIDTH) ;
//        make.top.mas_equalTo(21* AUTO_WIDTH) ;
        make.centerY.mas_equalTo(self.teacherImage);
        make.height.mas_equalTo(20 * AUTO_WIDTH) ;
    }];
    
    [self.onLineNumLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.teacherNameLabel.mas_right).mas_offset(10*AUTO_WIDTH) ;
//        make.top.mas_equalTo(self.teacherNameLabel.mas_bottom).mas_offset(11 *AUTO_WIDTH);
        make.centerY.mas_equalTo(self.teacherImage);
        make.height.mas_equalTo(20 *AUTO_WIDTH) ;
//        make.right.mas_equalTo(-11 *AUTO_WIDTH);
//        make.bottom.mas_equalTo(-48 *AUTO_WIDTH);

    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUserMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    [self configTarget];
    @weakify(self)
    self.videoView.videoView.fullScreenChangedBlock = ^(BOOL isFullScreen) {
        if (!isFullScreen) {
            self_weak_.signBtn.hidden = YES;
        }
    };
}


- (void)configTarget{

    //监听键盘的通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(NSNotification *notify) {
        // 0.取出键盘动画的时间
        CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        // 1.取得键盘最后的frame
        CGRect keyboardFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        // 2.计算控制器的view需要平移的距离
        CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
        // 3.执行动画
        [UIView animateWithDuration:duration animations:^{
            
            self.tableView.frame = CGRectMake(0, URSafeAreaNavHeight()+URScreenWidth()/16 *9, URScreenWidth(), URScreenHeight() - (URSafeAreaNavHeight()+URScreenWidth()/16 *9) - 49 *AUTO_WIDTH + transformY);
            
            if (self.menuIndex==3)
            {
                if (self.chatTextArray.count > 0)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.chatTextArray.count - 1 inSection:3];
                    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }else {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
                    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }
            }
       }];
    }];
    [self.signBtn addTarget:self action:@selector(studentLaunchAttendance) forControlEvents:UIControlEventTouchUpInside];
    [[self.playBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        if (self.judgeValue == 1) {
//          开始直播  [self.playBtn setImage:[UIImage imageNamed:@"直播中"] forState:UIControlStateNormal];
            [self.videoView.videoView  _playVideo];
            self.videoView.isPlaying = YES;
            [self.playBtn setHidden:YES];
            [self.playTimeLb setHidden:YES];
        } else {
            [URToastHelper showErrorWithStatus:@"该直播课程未开始"];
        }
    }];
    [[self.inputView.sendBtn  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        if ([NSString  isBlank:self.inputView.textView.text]) {
            [URToastHelper  showErrorWithStatus:@"请输入发送内容"] ;
        }  else {
            [self  sendChatTextRequestWithChatText:self.inputView.textView.text];
        }
    }];
    
    
    if (is_online==0) {
        
        self.inputView.givingButton.hidden = YES ;
        
    } else {
        
        self.inputView.givingButton.hidden = NO ;
        
        [[self.inputView.givingButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (self.detailModel.data.is_admin.intValue==0) {
                [self  getGivingData] ;
            } else {
                self.adminView = [[AdminiMoreToolAlertView alloc] initWithFrame:CGRectMake(0, 0, URScreenWidth(), URScreenHeight())];
                [self.view addSubview:self.adminView];
                
                [self.adminView showWithBanned:self.sourceTag==1?([self.detailModel.data.state  isEqualToString:@"normal"]?NO:YES):(self.bannedStatus == 1?YES:NO) cutoverLine:self.selModel == nil ? NO : (self.selModel.sel_bl.integerValue == 1 ? NO : YES) commit:^(NSString * tag) {
                    
                    NSInteger selectedSyatus = tag.integerValue ;
                    
                    if (selectedSyatus == 1) {
                        [self   sendLiveSectionBannedWithType:@"jinyan" alias:@"all"] ;
                    } else if (selectedSyatus == 2) {
                        [self  sendLiveSectionBannedWithType:@"jiechujinyan" alias:@"all"];
                    } else if (selectedSyatus == 101) {
                        [self teacherLaunchAttendanceWith:@"1"];
                    } else if (selectedSyatus == 102) {
                        [self teacherLaunchAttendanceWith:@"2"];
                    } else if (selectedSyatus == 103) {
                        [self teacherLaunchAttendanceWith:@"3"];
                    } else if (selectedSyatus == 202) {
                        [self teacherChangeLiveTimeWith:nil type:@"2"];
                    } else if (selectedSyatus > 2000) {
                        NSString *time = [tag substringFromIndex:3];
                        [self teacherChangeLiveTimeWith:time type:@"1"];
                    }
                    else {
                        
                        self.selModel.sel_bl = self.selModel.sel_bl.integerValue == 1 ? @"2" : @"1";
                        [self  sendLiveSectionChangeURLWithURL:self.selModel.sel_bl];
                    }
                    
                } cancel:^{
        
                }];
            }
        }];
    }
    
    [RACObserve(self,menuIndex) subscribeNext:^(NSNumber * x) {
        
        if (self.detailModel.data.is_admin.intValue == 0 && self.detailModel.data.own.intValue == 0)
        {
            //普通用户未购买， 底下是 购买按钮
            self.tableView.frame = CGRectMake(0, URSafeAreaNavHeight()+(URScreenWidth()/16 *9), URScreenWidth(), URScreenHeight()-(URSafeAreaNavHeight()+URScreenWidth()/16 *9) -49 *AUTO_WIDTH);
            
//            self.inputView.hidden = YES;
//            self.bottomView.hidden = NO ;
            
            self.bottomView.priceLabel.text = [NSString stringWithFormat:@"¥%@元",self.detailModel.data.univalence?:@""] ;
            if (is_online == 0) {
                self.inputView.hidden = NO;
                self.bottomView.hidden = YES;
                [self.bottomView.buyButton setTitle:@"暂不可预约" forState:UIControlStateNormal];
                self.bottomView.userInteractionEnabled = NO;
            }else {
                self.inputView.hidden = YES;
                self.bottomView.hidden = NO ;
                [self.bottomView.buyButton setTitle:@"立即预约" forState:UIControlStateNormal];
                self.bottomView.userInteractionEnabled = YES;
            }
        }
        else if (self.menuIndex == 3)//(管理员 || 普通用户已购买) && 直播大厅
        {
            self.tableView.frame = CGRectMake(0, URSafeAreaNavHeight()+(URScreenWidth()/16 *9), URScreenWidth(), URScreenHeight()-(URSafeAreaNavHeight()+URScreenWidth()/16 *9) -49 *AUTO_WIDTH);

            self.inputView.hidden = NO;
            
            [self.inputView.givingButton  setImage:self.detailModel.data.is_admin.integerValue == 0?[UIImage  imageNamed:@"活动(2)"] : [UIImage  imageNamed:@"更多"] forState:UIControlStateNormal];
            
            self.bottomView.hidden = YES;
        }
        else
        {
            self.bottomView.hidden = self.inputView.hidden = YES ;

            self.tableView.frame = CGRectMake(0, URSafeAreaNavHeight()+(URScreenWidth()/16 *9), URScreenWidth(), URScreenHeight()-(URSafeAreaNavHeight()+URScreenWidth()/16 *9));
        }
    }];
    
}

#pragma mark tabledelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.menuIndex == 0 ||  //0：课程详情，
        self.menuIndex == 2 ||  //2：配套资料
        self.menuIndex == 3 ||  //3：直播大厅
        self.menuIndex == 4 ||  //4：电子讲义，
        self.menuIndex == 5)  //5：在线抢答
    {
        return 3+1;
    }
    else if (self.menuIndex == 1) //1：课程目录
    {
        return 3+self.detailModel.data1.count;
    } else if (self.menuIndex == 5) {
        return 1 ;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.menuIndex == 1 && section >= 3)  //1：课程目录，
    {
        LiveSectionDetailData1Model *sectionModel = self.detailModel.data1[section - 3];
        return sectionModel.live_section.count;//sectionModel.open ? sectionModel.live_section.count : 0;
    } else if (self.menuIndex==3 && section==3){
        return self.chatTextArray.count ;
    } else if (self.menuIndex==5 && section==3){
        return self.onlineAnswerArray.count + 1 ;
    } else if (section == 1) {
        return 0;
    }
    return 1 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        LiveSectionCourseTitleTableViewCell * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:LiveSectionCourseTitleTableViewCellIdentifier forIndexPath:indexPath] ;
        tableViewCell.detailModel = self.detailModel.data ;
        [[tableViewCell.signBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            [self studentLaunchAttendance];
        }];
        return tableViewCell ;
    }
    else if (indexPath.section == 1)
    {
        LiveSectionTeacherInforTableViewCell * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:LiveSectionTeacherInforTableViewCellIdentifier forIndexPath:indexPath] ;
        tableViewCell.detailModel = self.detailModel.data ;
       
        [[[tableViewCell.expandContractionButton  rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:tableViewCell.rac_prepareForReuseSignal] subscribeNext:^(UIButton * x) {

            self.detailModel.data.open = !self.detailModel.data.open;
            
            [self.tableView reloadData];
            
        }];
        return tableViewCell ;
    }
    else if (indexPath.section == 2)
    {
        LiveSectionMenuCell *cell;
        
        if (self.detailModel.data.is_admin.intValue==0) {
            if ([self.detailModel.data.own integerValue] == 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:LiveSectionMenuThreeCellIdentifier];
            }else {
                cell = [tableView dequeueReusableCellWithIdentifier:LiveSectionMenuFourCellIdentifier];
            }
        } else {
            cell = [tableView  dequeueReusableCellWithIdentifier:LiveSectionMenuManagerCellIdentifier] ;
        }
        

        [[cell.menuSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(NSString * text) {

            self.menuIndex = [text intValue];
            
            if (text.integerValue==5) {
                [self  getAllPushExaminationQuestionsDataWithSectionID:self.selectedSectionID finishedBlock:^{
                    [self.tableView  reloadData];
                }] ;
            }
             
            [self.tableView reloadData];
        }];
        return cell;
    } else if (indexPath.section == 3 && self.menuIndex != 1){
        //课程详情、配套资料"
        if (self.menuIndex == 0 || self.menuIndex == 2){
            LiveSectionImgInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:LiveSectionImgInfoCellIdentifier];
            
            if ((self.detailModel.data.details && self.menuIndex == 0) ||
                 (self.detailModel.data.kit && self.menuIndex == 2)) {
                                
                [cell.detailImg sd_setImageWithURL:[NSURL URLWithString:self.menuIndex == 0 ? self.detailModel.data.details : self.detailModel.data.kit] placeholderImage:[UIImage imageNamed:@"news1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                   
                //                    [cell.detailImg mas_updateConstraints:^(MASConstraintMaker *make) {
                //                        make.height.mas_equalTo(image.size.height * URScreenWidth()/image.size.width);
                //                    }];
                }];
            }
             
            return cell;
        } else if (self.menuIndex == 3){
            LiveSectionTextChatTableViewCell  * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:LiveSectionChatTextCellIdentifier] ;
            
            if (self.chatTextArray.count>0) {
                tableViewCell.msgModel = self.chatTextArray[indexPath.row] ;
            }
            return tableViewCell ;
            
        } else if (self.menuIndex == 4){
            LiveSectionPDFTableViewCell  * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:LiveSectionPDFCellIdentifier] ;
            tableViewCell.currentViewController = self ;
            if (self.detailModel.data1.count>0) {
                if (self.detailModel.data1[0].live_section.count>0) {
                   tableViewCell.sectionModel = self.detailModel.data1[0].live_section[0] ;
               }
            }
            
            return tableViewCell ;
        }  else if (self.menuIndex==5){
            if (indexPath.row==0) {
                LiveSectionMenuCell *cell = [tableView  dequeueReusableCellWithIdentifier:LiveSectionOnlineAnswerCellIdentifier];
                [[cell.menuSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(NSString * text) {
                    self.selectedTextTag = text.intValue ;
                    
                    [self.viesAnswerArray  removeAllObjects];
                    
                    [self  getAllPushExaminationQuestionsDataWithSectionID:self.selectedSectionID finishedBlock:^{
                        [self.onlineAnswerArray  removeAllObjects];
                        
                        if (self.selectedTextTag == 6) {
                            //全部
                            [self.onlineAnswerArray addObjectsFromArray:self.questionsModel.data] ;
                            
                        } else {
                            [self.questionsModel.data  enumerateObjectsUsingBlock:^(LiveSectionAllQuestionsDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                if (self.selectedTextTag==7) {
                                    if (obj.is_sel.integerValue==1) {
                                        [self.onlineAnswerArray  addObject:obj];
                                    }
                                } else {
                                    if (obj.is_sel.integerValue==0) {
                                        [self.onlineAnswerArray  addObject:obj];
                                    }
                                }
                            }];
                            
                        }
                        [self.tableView reloadData];
                    }] ;
                    
                }];
                
                return cell ;
            } else {
                LiveSectionSendQuestionCell *cell = [tableView  dequeueReusableCellWithIdentifier:LiveSectionSendQuestionCellIdentifier];
                
                [cell  setAllQuestionsDataModel:self.onlineAnswerArray[indexPath.row-1] index:[NSString  stringWithFormat:@"%ld",(long)indexPath.row-1]] ;
                
                [[[cell.sendBtn  rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
                    
                    self.pushQuestionID = [NSString  stringWithFormat:@"%@",self.onlineAnswerArray[indexPath.row-1].idStr?:@""] ;
                   
                    if (self.onlineAnswerArray[indexPath.row-1].is_sel.integerValue==0) {//未做答
                        
                        [[URCommonApiManager  sharedInstance] sendPushLiveExaminationQuestionsDataWithApi_token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" tag_name:[NSString  stringWithFormat:@"live%@",self.detailModel.data.idStr?:@""] question_id:self.onlineAnswerArray[indexPath.row-1].idStr?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                            
                            [self  getAllPushExaminationQuestionsDataWithSectionID:self.selectedSectionID finishedBlock:^{
                                
                                [self.view  addSubview:self.statisticsAlert1];
                                                                                          
                                [self.statisticsAlert1   showWithStaticsList:@[] commit:^{
                                    [self.view addSubview:self.statisticsAlert2];
                                    [self.statisticsAlert2  showWithQuestionID:self.pushQuestionID cancel:^{
                                          
                                    }];
                               } cancel:^{
                                  
                               }] ;
                                
                                [self.onlineAnswerArray  removeAllObjects];
                                
                                if (self.selectedTextTag == 6) {
                                    //全部
                                    [self.onlineAnswerArray addObjectsFromArray:self.questionsModel.data] ;
                                } else {
                                    [self.questionsModel.data  enumerateObjectsUsingBlock:^(LiveSectionAllQuestionsDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                        if (self.selectedTextTag==7) {
                                            if (obj.is_sel.integerValue==1) {
                                                [self.onlineAnswerArray  addObject:obj];
                                            }
                                        } else {
                                            if (obj.is_sel.integerValue==0) {
                                                [self.onlineAnswerArray  addObject:obj];
                                            }
                                        }
                                    }];
                                }
                                
                                [self.tableView  reloadData];
                                
                               
                            }] ;
                            
                        } requestFailureBlock:^(NSError *error, id response) {
                            
                        }];
                        
                    } else {
                        
                        [self.view addSubview:self.statisticsAlert2];
                        [self.statisticsAlert2  showWithQuestionID:self.onlineAnswerArray[indexPath.row-1].idStr?:@"" cancel:^{
                            
                        }];
                    }
                }];
                
                return cell ;
            }
        } else {
            return [UITableViewCell new];
        }
    } else {
        LiveSectionCatalogCell *cell = [tableView dequeueReusableCellWithIdentifier:LiveSectionCatalogCellIdentifier];
        
        LiveSectionDetailData1Model *sectionModel = self.detailModel.data1[indexPath.section - 3];
        cell.model = sectionModel.live_section[indexPath.row];
        
        return cell;
    }
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.menuIndex==1) {
        if (self.detailModel.data.univalence.floatValue>0) {
            if (self.detailModel.data.own.integerValue == 0) {// 未购买
                if (is_online==0) {
                    [URToastHelper showErrorWithStatus:@"暂不可学习"];
                }else {
                    NSString *tipMsg = [NSString stringWithFormat:@"该视频直播课程为收费课程，你需要支付一定的费用才能观看完整版的视频直播课程！该视频直播课程收费标准为%@元，要学习该视频课程请点击立即预约完成视频直播预约！",self.detailModel.data.univalence];
                    [UIAlertController showAlertControllerWithTitle:@"提示" message:tipMsg cancelButtonTitle:@"暂不预约" otherButtonTitles:@[@"立即预约"] handler:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action) {
                        
                        if ([action.title isEqualToString:@"立即预约"]) {
                            BuyCourseVC *vc = [[BuyCourseVC alloc] init];
                            vc.buyType = 1 ;
                            vc.dataModel = self.detailModel.data ;
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }];
                }
            } else { // 已购买
                self.selectedSectionID  = [NSString  stringWithFormat:@"%@",self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].idStr?:@""] ;
                
                self.selModel = self.detailModel.data1[indexPath.section-3].live_section[indexPath.row];
                
                if (self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].state.integerValue==2) { //已经结束有回放
                    if ([NSString  isBlank:self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].lb]==NO) {
                        [self.videoView.videoView bindVideoUrl:[NSURL  URLWithString:self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].lb]];
                        [self.videoView.videoView  _playVideo];
                        self.videoView.isPlaying = YES;
                        [self.playBtn setHidden:YES];
                    }
                } else if (self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].state.integerValue==1){
                    [self.videoView.videoView bindVideoUrl:[NSURL  URLWithString:self.selModel.sel_bl.integerValue==1? self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].bl_url:self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].pcbl]];
                    [self.videoView.videoView  _playVideo];
                    self.videoView.isPlaying = YES;
                    [self.playBtn setHidden:YES];
                }
            }
        } else { // 免费
            self.selectedSectionID  = [NSString  stringWithFormat:@"%@",self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].idStr?:@""] ;
            
            self.selModel = self.detailModel.data1[indexPath.section-3].live_section[indexPath.row];

            if (self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].state.integerValue==2) {
                if ([NSString  isBlank:self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].lb]==NO) {
                    [self.videoView.videoView bindVideoUrl:[NSURL  URLWithString:self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].lb]];
                    [self.videoView.videoView  _playVideo];
                    self.videoView.isPlaying = YES;
                    [self.playBtn setHidden:YES];
                }
            } else if (self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].state.integerValue==1){
                [self.videoView.videoView bindVideoUrl:[NSURL  URLWithString:self.selModel.sel_bl.integerValue==1? self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].bl_url:self.detailModel.data1[indexPath.section-3].live_section[indexPath.row].pcbl]];
                [self.videoView.videoView  _playVideo];
                self.videoView.isPlaying = YES;
                [self.playBtn setHidden:YES];
            }
        }
    } else if (self.menuIndex ==3) {
        if (indexPath.section==3) {
            [self.view  addSubview:self.managerView];
            
            [self.managerView  showWithData:self.chatTextArray[indexPath.row] commit:^(NSInteger index) {
                if (index==0) {
                    [self  sendLiveSectionBannedWithType:@"jinyan" alias:self.chatTextArray[indexPath.row].from?:@""] ;
                } else if (index==1){
                    [self  sendLiveSectionBannedWithType:@"tichu" alias:self.chatTextArray[indexPath.row].from?:@""] ;
                }
            } cancel:^{
                
            }] ;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.menuIndex == 1 && section >= 3)
    {
        LiveSectionCatalogHeader *header = [[LiveSectionCatalogHeader alloc] init];
        header.model = self.detailModel.data1[section - 3];
        
        [[header.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [self.detailModel.data1 enumerateObjectsUsingBlock:^(LiveSectionDetailData1Model * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx == section - 3)
                {
                    obj.open = !obj.open;
//                    self.currentChapterIndex = idx;
//                    self.curriculumIndex = -1;
                }else {
                    obj.open = NO;
                }
            }];
            [self.tableView reloadData]; 
        }];
//        return header;
        return [UIView new];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.menuIndex == 1 && section >= 3) {
        return 0.01;//43*AUTO_WIDTH;
    }else {
        return 0.01;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footerView = [[UIView  alloc] init];
    footerView.backgroundColor = UR_ColorFromValue(0xEEEEEE);
    return footerView ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section < 2 ? 9 * AUTO_WIDTH : 0.01;
}

#pragma mark  -- Lazy Init
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView  alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = UR_ColorFromValue(0xEEEEEE) ;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.separatorColor = UR_COLOR_LINE;
        _tableView.estimatedRowHeight = 44.0f;
        
        [_tableView  registerClass:[LiveSectionCourseTitleTableViewCell  class] forCellReuseIdentifier:LiveSectionCourseTitleTableViewCellIdentifier];
        
        [_tableView  registerClass:[LiveSectionTeacherInforTableViewCell  class] forCellReuseIdentifier:LiveSectionTeacherInforTableViewCellIdentifier] ;
        
        [_tableView  registerClass:[LiveSectionMenuCell class] forCellReuseIdentifier:LiveSectionMenuThreeCellIdentifier] ;
        [_tableView  registerClass:[LiveSectionMenuCell class] forCellReuseIdentifier:LiveSectionMenuFourCellIdentifier] ;
        [_tableView  registerClass:[LiveSectionMenuCell class] forCellReuseIdentifier:LiveSectionMenuManagerCellIdentifier] ;
        [_tableView  registerClass:[LiveSectionMenuCell class] forCellReuseIdentifier:LiveSectionOnlineAnswerCellIdentifier] ;


        [_tableView  registerClass:[LiveSectionImgInfoCell class] forCellReuseIdentifier:LiveSectionImgInfoCellIdentifier] ;
        
        [_tableView  registerClass:[LiveSectionCatalogCell class] forCellReuseIdentifier:LiveSectionCatalogCellIdentifier] ;
        
        [_tableView  registerClass:[LiveSectionTextChatTableViewCell   class] forCellReuseIdentifier:LiveSectionChatTextCellIdentifier];
        
        [_tableView  registerClass:[LiveSectionPDFTableViewCell  class] forCellReuseIdentifier:LiveSectionPDFCellIdentifier] ;
        
        [_tableView  registerClass:[LiveSectionSendQuestionCell  class] forCellReuseIdentifier:LiveSectionSendQuestionCellIdentifier] ;


        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
    }
    return _tableView ;
}
-(UIImageView *)teacherImage{
    if (!_teacherImage) {
        _teacherImage = [[UIImageView  alloc] init];
        _teacherImage.layer.cornerRadius = 10.0f;
        _teacherImage.layer.masksToBounds = YES ;
    }
    return _teacherImage ;
}

-(UILabel *)teacherNameLabel{
    if (!_teacherNameLabel) {
        _teacherNameLabel = [UILabel   normalLabelWithTitle:@"" titleColor:[UIColor whiteColor] font:RegularFont(FontSize12) textAlignment:NSTextAlignmentLeft numberLines:1] ;
    }
    return _teacherNameLabel ;
}

-(UILabel *)onLineNumLabel{
    if (!_onLineNumLabel) {
        _onLineNumLabel = [UILabel   normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0xFFFDFA) font:RegularFont(FontSize12) textAlignment:NSTextAlignmentLeft numberLines:1] ;
        _onLineNumLabel.backgroundColor = UR_ColorFromValue(0x1F3952);
        _onLineNumLabel.layer.cornerRadius = 8.0f;
        _onLineNumLabel.layer.masksToBounds = YES;
    }
    return _onLineNumLabel ;
}
-(LiveSecionBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LiveSecionBottomView  alloc] init];
        _bottomView.backgroundColor = UR_ColorFromValue(0xffffff) ;
        [_bottomView.subject  subscribeNext:^(NSNumber * x) {
            NSLog(@"点击的按钮的tag----%ld",(long)x.integerValue) ;
            if (x.integerValue==3) {
                BuyCourseVC *vc = [[BuyCourseVC alloc] init];
                vc.buyType = 1 ;
                vc.dataModel = self.detailModel.data ;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }
    return _bottomView ;
}

- (NELCInputView *)inputView
{
    if (!_inputView) {
        _inputView = [[NSBundle mainBundle] loadNibNamed:@"NELCInputView" owner:self options:nil][0];
//        _inputView.textView.returnKeyType = UIReturnKeyDone;
    }
    return _inputView;
}

- (GiftAlertView *)giftAler {
    if (!_giftAler) {
        _giftAler = [[GiftAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _giftAler.currentViewController = self ;
    }
    return _giftAler;
}

-(NELiveDetailVideoView *)videoView {
    if (!_videoView) {
        CGFloat videoViewH = (URScreenWidth() / 16.0 * 9.0);
        _videoView = [[NELiveDetailVideoView alloc] initWithFrame:CGRectMake(0, URSafeAreaNavHeight(), URScreenWidth() , videoViewH)];
        _videoView.isPlaying = NO ;
        [_videoView.playButton setHidden:YES];
    }
    return _videoView;
}
-(UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton ImgBtnWithImageName:@"未开始"];
    }
    return _playBtn;
}

-(UILabel *)playTimeLb {
    if (!_playTimeLb) {
        _playTimeLb = [UILabel normalLabelWithTitle:@"直播时间：2020-3-17 20:00" titleColor:UR_ColorFromValue(0xFFFDFA) font:RegularFont(FontSize12) textAlignment:NSTextAlignmentLeft numberLines:1] ;
        _playTimeLb.backgroundColor = UR_ColorFromValueA(0x1F3952, 0.7);
        _playTimeLb.layer.cornerRadius = 8.0f;
        _playTimeLb.layer.masksToBounds = YES;
    }
    return _playTimeLb;
}

-(UIButton *)signBtn {
    if (!_signBtn) {
        _signBtn = [UIButton ImgBtnWithImageName:@"打卡1"];
        [_signBtn setHidden:YES];
    }
    
    return _signBtn;
}

-(StatisticsAlert1 *)statisticsAlert1{
    if (!_statisticsAlert1) {
        _statisticsAlert1 = [[StatisticsAlert1  alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _statisticsAlert1 ;
}

-(StatisticsAlert2 *)statisticsAlert2{
    if (!_statisticsAlert2) {
        _statisticsAlert2 = [[StatisticsAlert2  alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _statisticsAlert2 ;
}

-(LiveSectionManagerView *)managerView{
    if (!_managerView) {
        _managerView = [[LiveSectionManagerView  alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
    }
    return _managerView ;
}

#pragma mark - Action
- (void)receiveUserMessage:(NSNotification *)noti {

    NSDictionary * userInfo = noti.userInfo;
    
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:[userInfo[@"content"]  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"--------------------转换之后的收到透传消息---%@-----%@",userInfo,responseDict) ;
    
    if ([[responseDict objectForKey:@"type"] isEqualToString:@"jinchu"]|| [[responseDict objectForKey:@"type"] isEqualToString:@"xiaoxi"]) { // 普通消息
        
        LivePenetrateMsgModel * msgModel = [LivePenetrateMsgModel   yy_modelWithDictionary:responseDict] ;
        
        [self.chatTextArray  addObject:msgModel];
        
        if (self.chatTextArray.count>0) {
            
            [self.tableView  reloadData];

//            [self.tableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.chatTextArray.count-1 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
    } else if ([[responseDict objectForKey:@"type"] isEqualToString:@"dati"]){ // 答题
        
        if (self.detailModel.data.is_admin.integerValue==0) {
            NSDictionary *fromDict = [NSJSONSerialization JSONObjectWithData:[responseDict[@"from"]  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            
                   LiveSectionAnswerQuestionsFromModel * fromModel = [LiveSectionAnswerQuestionsFromModel   yy_modelWithDictionary:fromDict];
                   
                   fromModel.options = [NSMutableArray array];
                   
                   if (fromModel.option1.length > 0) {
                       [fromModel.options addObject:fromModel.option1];
                   }
                   if (fromModel.option2.length > 0) {
                       [fromModel.options addObject:fromModel.option2];
                   }
                   if (fromModel.option3.length > 0) {
                       [fromModel.options addObject:fromModel.option3];
                   }
                   if (fromModel.option4.length > 0) {
                       [fromModel.options addObject:fromModel.option4];
                   }
                   if (fromModel.option5.length > 0) {
                       [fromModel.options addObject:fromModel.option5];
                   }
                   if (fromModel.option6.length > 0) {
                       [fromModel.options addObject:fromModel.option6];
                   }
                   
                   for (int i = 0; i < fromModel.options.count; i++)
                   {
                       OptionsModel *option = [[OptionsModel alloc] init];
                       option.optionName = fromModel.options[i];
                       option.selected = NO;
                       [fromModel.options replaceObjectAtIndex:i withObject:option];
                   }
                   
                   GrabAnswerView *grabAlert = [[GrabAnswerView alloc] initWithFrame:CGRectMake(0, 0, URScreenWidth(), URScreenHeight())];
                   [self.view addSubview:grabAlert];
                   
                   [grabAlert showWithData:fromModel commit:^(id) {
                       
                   } cancel:^{
                       
                   }];
        }
       
    }  else if ([[responseDict objectForKey:@"type"] isEqualToString:@"jinyan"]){ // 禁言
        if (self.detailModel.data.is_admin.integerValue==0) {
             [self.inputView  handlePerBanned:YES allBanned:YES];
        } else {
            [self.inputView  handlePerBanned:NO allBanned:NO];
        }
    }  else if ([[responseDict objectForKey:@"type"] isEqualToString:@"jiechujinyan"]){ // 解除禁言
         [self.inputView  handlePerBanned:NO allBanned:NO];

    } else if ([[responseDict objectForKey:@"type"] isEqualToString:@"xianlu"]){ // 线切换线
        [self.videoView.videoView bindVideoUrl:[NSURL  URLWithString:[NSString  stringWithFormat:@"%@",responseDict[@"from"]]]];
        [self.videoView.videoView  _playVideo];
        self.videoView.isPlaying = YES;
        [self.playBtn setHidden:YES];
    } else if ([[responseDict objectForKey:@"type"] isEqualToString:@"tichu"]) { // 踢人
        if (self.detailModel.data.is_admin.integerValue==0) {
            [self  getUserLiveRoomStatusWithType:@"2"] ;
            
            [self.videoView.videoView _deallocPlayer];
            
            NSSet * set = [NSSet  setWithObject:[NSString  stringWithFormat:@"live%@",self.detailModel.data.idStr?:@""]];
            
            [JPUSHService  deleteTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                
            } seq:0] ;
            
            //恢复右滑返回
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
                        
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if ([[responseDict objectForKey:@"type"] isEqualToString:@"liveqiangda"]) { // 抢答
        if (self.detailModel.data.is_admin.integerValue==1) {
            NSDictionary *fromDict = [NSJSONSerialization JSONObjectWithData:[responseDict[@"from"]  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            
            LiveSectionViesAnswerModel * fromModel = [LiveSectionViesAnswerModel   yy_modelWithDictionary:fromDict];
            
            self.statisticsAlert1.titleLb.text = [NSString  stringWithFormat:@"已有%@人抢答",fromModel.all?:@""] ;
            self.statisticsAlert1.correctNumberLb.text = [NSString  stringWithFormat:@"答对%@人",fromModel.trueStr?:@""] ;
            
            [self.viesAnswerArray  addObject:fromModel.contentStr?:@""];

            self.statisticsAlert1.personalList = self.viesAnswerArray ;
        }
        
    } else if ([[responseDict objectForKey:@"type"] isEqualToString:@"qiandao"]) { //签到
           NSDictionary *fromDict = [NSJSONSerialization JSONObjectWithData:[responseDict[@"from"]  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
           self.stateStr = fromDict[@"state"];
           NSString *idStr = fromDict[@"id"];
           
           if ([self.selectedSectionID isEqualToString:idStr]) {
               NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
               LiveSectionCourseTitleTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
               [cell.signBtn setHidden:NO];
               [self.signBtn setHidden:NO];
               if ([self.stateStr isEqualToString:@"1"]) {
                   [cell.signBtn setImage:[UIImage imageNamed:@"签到1"] forState:UIControlStateNormal];
                   [self.signBtn setImage:[UIImage imageNamed:@"签到1"] forState:UIControlStateNormal];
               } else if ([self.stateStr isEqualToString:@"2"]) {
                   [cell.signBtn setImage:[UIImage imageNamed:@"下课1"] forState:UIControlStateNormal];
                   [self.signBtn setImage:[UIImage imageNamed:@"下课1"] forState:UIControlStateNormal];
               } else if ([self.stateStr isEqualToString:@"3"]) {
                   [cell.signBtn setImage:[UIImage imageNamed:@"打卡1"] forState:UIControlStateNormal];
                   [self.signBtn setImage:[UIImage imageNamed:@"打卡1"] forState:UIControlStateNormal];
               }
           }
       }
}

#pragma mark -- Request Method
-(void)getLiveSectionDetailData{
    
    [[URCommonApiManager  sharedInstance] getLiveSectionDetailDataWithCurriculum:self.idStr requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        self.detailModel = response ;
        [self.videoView.videoImgView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.data.thumbnail]];
        [self.teacherImage sd_setImageWithURL:[NSURL URLWithString:self.detailModel.data.teacher_info.thumbnail]];
        self.teacherNameLabel.text = self.detailModel.data.teacher_info.name;
        self.onLineNumLabel.text = [NSString stringWithFormat:@"%@人正在看",self.detailModel.data.num];
        self.sourceTag = 1 ;
        LiveSectionDetailData1Model *sectionModel = self.detailModel.data1[0];
        if (sectionModel.live_section.count > 1) {
            [sectionModel.live_section enumerateObjectsUsingBlock:^(LiveSectionDetailData1SectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LiveSectionDetailData1SectionModel *model2;
                if (idx == sectionModel.live_section.count - 1) {
                    model2 = sectionModel.live_section[idx];
                } else {
                    model2 = sectionModel.live_section[idx + 1];
                }
                LiveSectionDetailData1SectionModel *model1 = obj;
                if ([model1.state isEqualToString:@"0"]) {
                    self.playTimeLb.text = [NSString stringWithFormat:@"直播时间:%@",model2.time_describe];
                    [self.playBtn setImage:[UIImage imageNamed:@"未开始"] forState:UIControlStateNormal];
                    *stop = YES;
                } else {
                    if (![model1.state isEqualToString:model2.state]) {
                        self.playTimeLb.text = [NSString stringWithFormat:@"直播时间:%@",model2.time_describe];
                        if ([model2.state isEqualToString:@"0"]) { //未开始
                            [self.playBtn setImage:[UIImage imageNamed:@"未开始"] forState:UIControlStateNormal];
                        } else if ([model2.state isEqualToString:@"1"]) { //直播中
                            [self.playBtn setImage:[UIImage imageNamed:@"直播中"] forState:UIControlStateNormal];
                            self.judgeValue = 1;
                        } else if ([model2.state isEqualToString:@"2"]) { //已结束
                            [self.playBtn setImage:[UIImage imageNamed:@"已结束"] forState:UIControlStateNormal];
                            [self.playTimeLb setHidden:YES];
                        }
                        *stop = YES;
                    } else {
                        LiveSectionDetailData1SectionModel *model = sectionModel.live_section[sectionModel.live_section.count - 1];
                        self.playTimeLb.text = [NSString stringWithFormat:@"直播时间:%@",model.time_describe];
                        if ([model.state isEqualToString:@"0"]) { //未开始
                            [self.playBtn setImage:[UIImage imageNamed:@"未开始"] forState:UIControlStateNormal];
                        } else if ([model.state isEqualToString:@"1"]) { //直播中
                            [self.playBtn setImage:[UIImage imageNamed:@"直播中"] forState:UIControlStateNormal];
                            self.judgeValue = 1;
                        } else if ([model.state isEqualToString:@"2"]) { //已结束
                            [self.playBtn setImage:[UIImage imageNamed:@"已结束"] forState:UIControlStateNormal];
                            [self.playTimeLb setHidden:YES];
                        }
                    }
                }
            }];
        } else if (sectionModel.live_section.count == 1){
            LiveSectionDetailData1SectionModel *model = sectionModel.live_section[sectionModel.live_section.count - 1];
            self.playTimeLb.text = [NSString stringWithFormat:@"直播时间:%@",model.time_describe];
            if ([model.state isEqualToString:@"0"]) { //未开始
                [self.playBtn setImage:[UIImage imageNamed:@"未开始"] forState:UIControlStateNormal];
            } else if ([model.state isEqualToString:@"1"]) { //直播中
                [self.playBtn setImage:[UIImage imageNamed:@"直播中"] forState:UIControlStateNormal];
                self.judgeValue = 1;
            } else if ([model.state isEqualToString:@"2"]) { //已结束
                [self.playBtn setImage:[UIImage imageNamed:@"已结束"] forState:UIControlStateNormal];
                [self.playTimeLb setHidden:YES];
            }
        } else if (sectionModel.live_section.count == 0) {
            [self.playBtn setImage:[UIImage imageNamed:@"已结束"] forState:UIControlStateNormal];
            [self.playTimeLb setHidden:YES];
        }
        [self  getUserLiveRoomStatusWithType:@"1"] ;
        
        [self.inputView.givingButton  setImage:self.detailModel.data.is_admin.integerValue == 0?[UIImage  imageNamed:@"活动(2)"] : [UIImage  imageNamed:@"更多"] forState:UIControlStateNormal];
        
        if ([self.detailModel.data.state  isEqualToString:@"normal"]) {
            [self.inputView  handlePerBanned:NO allBanned:NO];
        } else {
            [self.inputView  handlePerBanned:YES allBanned:YES];
        }
        
        if (self.detailModel.data.is_admin.intValue==0){
            if ([self.detailModel.data.own integerValue] == 1)//普通用户已购买，默认为直播大厅
            {
                self.menuIndex = 3;
            }else//普通用户未购买，默认为课程详情
            {
                self.menuIndex = 0;
            }
        } else//管理员，默认为直播大厅
        {
            self.menuIndex = 3;
        }
        
        [self.tableView  reloadData];
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

-(void)getUserLiveRoomStatusWithType:(NSString *)type{
    
    NSSet * set = [NSSet  setWithObject:[NSString  stringWithFormat:@"live%@",self.detailModel.data.idStr?:@""]];
    
    [JPUSHService  addTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0] ;
    
    [[URCommonApiManager  sharedInstance] userLogInOutILiveRoomWithType:type api_token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" tag_name:[NSString  stringWithFormat:@"live%@",self.detailModel.data.idStr?:@""] curriculum_id:self.detailModel.data.idStr?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

-(void)getGivingData{
    
    [[URCommonApiManager   sharedInstance] sendRequestGetFlowerDataWithRequestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.givingModel = response ;
                
        [self.view  addSubview:self.giftAler];
        
        self.giftAler.tagName = [NSString  stringWithFormat:@"live%@",self.detailModel.data.idStr?:@""] ;
        self.giftAler.teacherID = [NSString  stringWithFormat:@"%@",self.detailModel.data.teacher?:@""] ;
        [self.giftAler showWithGiftList:self.givingModel.data commit:^(LiveGivingDataModel * _Nonnull model) {
            
        } cancel:^{
            
        }];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

-(void)sendChatTextRequestWithChatText:(NSString *)chatText{
    
    [[URCommonApiManager  sharedInstance] sendLivePushGroupChatRequestWithApi_token:[URUserDefaults   standardUserDefaults].userInforModel.api_token?:@"" tag_name:[NSString  stringWithFormat:@"live%@",self.detailModel.data.idStr?:@""] content:chatText?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        NSLog(@"发送消息成功：%@",responseDict) ;
        
        self.inputView.textView.text = @"" ;
        
        
    } requestFailureBlock:^(NSError *error, id response) {
        
        NSLog(@"发送消息失败：%@",response) ;

    }];
    
}

-(void)sendLiveSectionBannedWithType:(NSString *)type alias:(NSString *)alias{
    
    if ([NSString  isBlank:self.selectedSectionID]) {
        
        self.adminView.bannedBtn.selected = !self.adminView.bannedBtn.isSelected ;
        
        [URToastHelper  showErrorWithStatus:@"请先选择直播课程"] ;
           
       } else {
           
           [[URCommonApiManager  sharedInstance] sendLiveSectionBannedRequestWithApi_token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" tag_name:[NSString  stringWithFormat:@"live%@",self.detailModel.data.idStr?:@""] alias:alias?:@"" type:type?:@"" curriculum:[NSString  stringWithFormat:@"%@",self.detailModel.data.idStr?:@""] requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                if ([type isEqualToString:@"jinyan"]) {
                    self.sourceTag = 2 ;
                    self.bannedStatus = 1 ;
                } else if([type isEqualToString:@"jiechujinyan"]){
                    self.sourceTag = 2 ;
                    self.bannedStatus = 2 ;
                }
                  
              } requestFailureBlock:^(NSError *error, id response) {
                  
              }];
       }
    
}

-(void)sendLiveSectionChangeURLWithURL:(NSString *)url{
    
    if ([NSString  isBlank:self.selectedSectionID]) {
        
        self.adminView.cutoverLineBtn.selected = !self.adminView.cutoverLineBtn.isSelected ;
                
        [URToastHelper  showErrorWithStatus:@"请先选择直播课程"] ;
        
    } else {
        [[URCommonApiManager  sharedInstance] liveSectionManagerSendChangeURLRequestWithApi_token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" section_id:self.selectedSectionID?:@"" url_type:url requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
        } requestFailureBlock:^(NSError *error, id response) {

        }];
    }
}

-(void)teacherLaunchAttendanceWith:(NSString *)state {
    if ([NSString  isBlank:self.selectedSectionID]) {
        
        self.adminView.cutoverLineBtn.selected = !self.adminView.cutoverLineBtn.isSelected ;
                
        [URToastHelper  showErrorWithStatus:@"请先选择直播课程"] ;
        
    } else {
        [[URCommonApiManager sharedInstance] teacherLaunchAttendanceWithApi_token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" section_id:self.selectedSectionID?:@"" state:state requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            [URToastHelper showErrorWithStatus:@"操作成功"];
        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
    }
}

-(void)studentLaunchAttendance {
    if ([NSString  isBlank:self.selectedSectionID]) {
        
        self.adminView.cutoverLineBtn.selected = !self.adminView.cutoverLineBtn.isSelected ;
                
        [URToastHelper  showErrorWithStatus:@"请先选择直播课程"] ;
        
    } else {
        [[URCommonApiManager sharedInstance] studentLaunchAttendanceWithApi_token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" section_id:self.selectedSectionID?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            [URToastHelper showErrorWithStatus:@"操作成功"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            LiveSectionCourseTitleTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if ([self.stateStr isEqualToString:@"1"]) {
                [cell.signBtn setImage:[UIImage imageNamed:@"签到2"] forState:UIControlStateNormal];
                [self.signBtn setImage:[UIImage imageNamed:@"签到2"] forState:UIControlStateNormal];
            } else if ([self.stateStr isEqualToString:@"2"]) {
                [cell.signBtn setImage:[UIImage imageNamed:@"下课2"] forState:UIControlStateNormal];
                [self.signBtn setImage:[UIImage imageNamed:@"下课2"] forState:UIControlStateNormal];
            } else if ([self.stateStr isEqualToString:@"3"]) {
                [cell.signBtn setImage:[UIImage imageNamed:@"打卡2"] forState:UIControlStateNormal];
                [self.signBtn setImage:[UIImage imageNamed:@"打卡2"] forState:UIControlStateNormal];
            }
        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
    }
}

-(void)teacherChangeLiveTimeWith:(NSString *)time type:(NSString *)type {
    [[URCommonApiManager sharedInstance] teacherChangeLiveTimeWithApi_token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" type:type time:time section_id:self.selectedSectionID?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        [URToastHelper showErrorWithStatus:@"操作成功"];
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

-(void)getAllPushExaminationQuestionsDataWithSectionID:(NSString *)sectionID  finishedBlock:(void(^)(void))finishedBlock{
    
    NSString * _Nonnull extractedExpr = [URUserDefaults  standardUserDefaults].userInforModel.api_token;
    [[URCommonApiManager   sharedInstance] getLiveSectionAllPushExaminationQuestionsDataWithApi_token:extractedExpr?:@"" section_id:sectionID?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.questionsModel = response ; 
        
        [self.onlineAnswerArray addObjectsFromArray:self.questionsModel.data];
        
        finishedBlock();
                                
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
