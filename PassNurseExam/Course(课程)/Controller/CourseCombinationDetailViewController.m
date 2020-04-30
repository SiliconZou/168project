//
//  CourseCombinationDetailViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseCombinationDetailViewController.h"
#import "CourseCombinationDetailTopTableViewCell.h"
#import "CourseDetailViewController.h"
#import "CourseBottomView.h"

@interface CourseCombinationDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) CourseCombinationDetailModel * detailModel ;

@property (nonatomic,strong) NSArray * explainArray ;

@property (nonatomic ,assign) BOOL  isShow ;

@property (nonatomic ,strong) CourseBottomView * bottomView ;


@end

@implementation CourseCombinationDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestPackageDetail];
}

- (void)requestPackageDetail
{
    @weakify(self) ;
    
    [[URCommonApiManager  sharedInstance] getSetmealStageDataWithSetmealID:self.stageID?:@"" userToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self) ;
        
        self.detailModel = response ;
        
        if (self.detailModel.data.explain.length > 0)
        {
            NSData * explainData = [self.detailModel.data.explain   dataUsingEncoding:NSUTF8StringEncoding];
            
            id jsonObj = [NSJSONSerialization JSONObjectWithData:explainData options:NSJSONReadingAllowFragments error:nil];
            
            self.explainArray = (NSArray *)jsonObj;
        }
        
        if (is_online==0) {
            self.bottomView.priceLabel.text = @"";

        } else {
            self.bottomView.priceLabel.text = [NSString  stringWithFormat:@"¥%@元",self.detailModel.data.univalence?:@""];

        }
        

        if ([self.detailModel.data.own integerValue] == 1) {
            if (is_online == 0) {//未上线
                [self.bottomView.payButton setTitle:@"可立即学习" forState:UIControlStateNormal];
                self.bottomView.payButton.userInteractionEnabled = NO;
            }else {
                if (is_online==0) {
                    [self.bottomView.payButton setTitle:@"已激活" forState:UIControlStateNormal];
                } else {
                    [self.bottomView.payButton setTitle:@"已购买" forState:UIControlStateNormal];
                }
            }
            self.bottomView.courseCardButton.hidden = YES;
        }else {
            if (is_online == 0) {//未上线
                [self.bottomView.payButton setTitle:@"暂不可学习" forState:UIControlStateNormal];
                self.bottomView.payButton.userInteractionEnabled = NO;
                self.bottomView.courseCardButton.hidden = YES;
            }else {
                [self.bottomView.payButton setTitle:@"立即支付" forState:UIControlStateNormal];
                self.bottomView.courseCardButton.hidden = NO;
            }
        }
        
        [self.tableView reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"精品课程" ;
    [self.cBtnRight setImage:[UIImage imageNamed:@"kefuu"] forState:UIControlStateNormal];
    [[self.cBtnRight  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    self.cBtnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -44 * AUTO_WIDTH) ;
    
    [self.view  addSubview:self.tableView];
    
    if (is_online==0) {
        
        [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0) ;
            make.top.mas_equalTo(URSafeAreaNavHeight());
            make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()));
        }];
        
    } else {
        [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0) ;
            make.top.mas_equalTo(URSafeAreaNavHeight());
            make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()-49*AUTO_WIDTH));
        }];
        
        self.bottomView = [[CourseBottomView  alloc] init];
        [self.view  addSubview:self.bottomView];
        [self.bottomView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 49*AUTO_WIDTH));
        }];
    }
        
    self.isShow = NO;
    self.tableView.contentOffset =CGPointMake(0, 0) ;

    [self configTarget];
}

- (void)configTarget
{
    @weakify(self);
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"LoginSuccessNoti" object:nil] subscribeNext:^(id x) {
        @strongify(self);
           [self requestPackageDetail];
    }];
    
    self.bottomView.selectedButtonBlock = ^(NSInteger tag) {
        @strongify(self);
        
        if (userLoginStatus == 0)
        {
            [self presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
            return ;
        }
        
        if (tag==1)//立即购买
        {
            if ([self.detailModel.data.own integerValue] == 1) {
                if (is_online==0) {
                    [URToastHelper showErrorWithStatus:@"你已激活过该套餐，不可再次激活"];

                } else {
                    [URToastHelper showErrorWithStatus:@"你已购买过该套餐，不可再次购买"];

                }
                return ;
            }
            CoursePayViewController * payViewController = [[CoursePayViewController  alloc] init];
            payViewController.univalence =  self.detailModel.data.univalence;
            payViewController.idStr = self.detailModel.data.idStr;
            payViewController.stage = self.detailModel.data.stage;
            payViewController.buyType = @"setmeal";//套餐

            [self.navigationController pushViewController:payViewController animated:YES];
            
        } else {
            //课程卡激活
            UserActivationViewController *  activationViewController = [[UserActivationViewController  alloc] init];
            [self.navigationController pushViewController:activationViewController animated:YES];
        }
    } ;
}

//客服
-(void)navRightPressed:(id)sender
{
    if ( [UIDevice currentDevice].systemVersion.doubleValue>=10.0) {
        NSString *qq=[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQ];
        NSURL *url = [NSURL URLWithString:qq];
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQ]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //                    webView.delegate = self;
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==1) {
        return self.isShow ? self.explainArray.count : 0 ;
    } else if (section==2){
        return self.detailModel.data.stage.count ;
    } else {
        return 1 ;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        CourseCombinationDetailTopTableViewCell * combinationTopCell = [tableView  dequeueReusableCellWithIdentifier:@"CourseCombinationDetailTopTableViewCellID"] ;
        if (!combinationTopCell) {
            combinationTopCell = [[NSBundle mainBundle] loadNibNamed:@"CourseCombinationDetailTopTableViewCell" owner:self options:nil][0] ;
        }
        combinationTopCell.dataModel = self.detailModel ;
        return combinationTopCell ;
    }
    else if (indexPath.section==1)
    {
        UITableViewCell * imageTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"imageTableViewCellID"];
        
        if (!imageTableViewCell)
        {
            imageTableViewCell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"imageTableViewCellID"];
            imageTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView * iconImageView = [[UIImageView  alloc] init];
            [imageTableViewCell.contentView  addSubview:iconImageView];
            [iconImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.right.mas_equalTo(0);
                make.height.mas_equalTo(URScreenWidth());
            }] ;
            iconImageView.tag = 101;
        }
        
        UIImageView *imgV = (UIImageView *)[imageTableViewCell viewWithTag:101];
        
        [imgV sd_setImageWithURL:self.explainArray[indexPath.row] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [imgV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(image.size.height * URScreenWidth()/image.size.width);
            }];
        }];
        return imageTableViewCell;
    }
    else
    {
        CourseCombinationDetailTopTableViewCell * combinationTopCell = [tableView  dequeueReusableCellWithIdentifier:@"CourseCombinationDetailCourseViewCellID"] ;
        if (!combinationTopCell) {
            combinationTopCell = [[NSBundle  mainBundle] loadNibNamed:@"CourseCombinationDetailTopTableViewCell" owner:self options:nil][3] ;
        }
                
        combinationTopCell.dataModel =  self.detailModel.data.stage[indexPath.row];
        return combinationTopCell ;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView * headerView = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, URScreenWidth(), 38)];

    if (section==1)
    {
        CourseCombinationDetailTopTableViewCell * topHeaderView =[[NSBundle  mainBundle] loadNibNamed:@"CourseCombinationDetailTopTableViewCell" owner:self options:nil][1] ;
        topHeaderView.backgroundColor = [UIColor  whiteColor] ;

        [topHeaderView.directionButton  setImage:[UIImage  imageNamed:self.isShow ? @"jiantous" : @"下"] forState:UIControlStateNormal];

        [[topHeaderView.directionButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            self.isShow = !self.isShow ;
            [self.tableView  reloadData];
        }];
        topHeaderView.frame = CGRectMake(0, 0, URScreenWidth(), 38) ;
        [headerView  addSubview:topHeaderView];
    }
    else if (section==2)
    {
        CourseCombinationDetailTopTableViewCell * topHeaderView =[[NSBundle  mainBundle] loadNibNamed:@"CourseCombinationDetailTopTableViewCell" owner:self options:nil][2] ;
        topHeaderView.backgroundColor = [UIColor  whiteColor] ;
        topHeaderView.contentLabel.text = [NSString  stringWithFormat:@"%@",self.detailModel.data.title?:@""] ;
        topHeaderView.frame = CGRectMake(0, 0, URScreenWidth(), 38) ;
        [headerView  addSubview:topHeaderView];
    }
    return headerView ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01 ;
    } else {
        return 38;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footerView = [[UIView  alloc] init];
    footerView.backgroundColor = [UIColor clearColor] ;
    return footerView ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2) {
        return 0.01 ;
    } else {
        return 8 ;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        if ([self.detailModel.data.own integerValue] == 1)
        {
            CourseDetailViewController * detailViewController = [[CourseDetailViewController  alloc] init];
            BaseCourseModel * commonModel = self.detailModel.data.stage[indexPath.row];
            detailViewController.stageID = [NSString  stringWithFormat:@"%@",commonModel.idStr?:@""] ;
            [self.navigationController pushViewController:detailViewController animated:YES];
        }
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.estimatedRowHeight = 44.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

@end
