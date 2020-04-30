//
//  CoursePayViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/18.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CoursePayViewController.h"
#import "CoursePayViewTableViewCell.h"
#import "CourseCombinationDetailTopTableViewCell.h"
#import "CourseBottomView.h"
#import "WXApi.h"

@interface CoursePayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic ,strong) CourseBottomView * bottomView ;
@property (nonatomic,assign) NSInteger  selectedIndex;

@end

@implementation CoursePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"精品课程" ;
    [self.cBtnRight setImage:[UIImage imageNamed:@"kefuu"] forState:UIControlStateNormal];
     
    self.cBtnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -44 * AUTO_WIDTH) ;
    
    [self.view  addSubview:self.tableView];
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(URSafeAreaNavHeight());
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()-49 * AUTO_WIDTH));
    }];
    
    self.bottomView = [[CourseBottomView  alloc] init];
    self.bottomView.priceLabel.text = [NSString  stringWithFormat:@"¥%@元",self.univalence?:@""];
    [self.view  addSubview:self.bottomView];
    [self.bottomView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 49 * AUTO_WIDTH));
    }];
    self.bottomView.courseCardButton.hidden = YES ;
    [self.bottomView.payButton setBackgroundImage:[UIImage gradientBackImgWithFrame:CGRectMake(0, 0, URScreenWidth()/2.0, 49 * AUTO_WIDTH) startColor:UR_ColorFromValue(0xA9A6FF) endColor:UR_ColorFromValue(0x57A2FF) direction:0] forState:UIControlStateNormal];
    [self.bottomView.payButton  mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(URScreenWidth()/2.0) ;
    }];
    
    [self configTarget];
    
   
}

- (void)configTarget
{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"PaySuccessNoti" object:nil] subscribeNext:^(id x) {
        
        [URToastHelper showErrorWithStatus:@"购买成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });
   }];
    
    @weakify(self);
    self.bottomView.selectedButtonBlock = ^(NSInteger tag) {
        @strongify(self);
        
        if (tag==1)
        {
            // choice 微信：wx ,支付宝：ali，余额：yue
            NSString *choice = @"";
            switch (self.selectedIndex) {
                case 1:
                    choice = @"ali";
                    break;
                case 2:
                    choice = @"wx";
                    break;
                case 3:
                    choice = @"yue";
                    break;
                default:
                    break;
            }
            if (choice.length == 0) {
                [URToastHelper showErrorWithStatus:@"请选择支付方式"];
                return ;
            }
            [[URCommonApiManager  sharedInstance] sendPayCoursewareRequestWithUserToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" type:self.buyType value:self.idStr?:@"" choice:choice requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                if (self.selectedIndex==1)//支付宝
                {
                    [[AlipaySDK  defaultService] payOrder:responseDict[@"data"] fromScheme:@"EducationAliPaySchme" callback:^(NSDictionary *resultDic) {
                        NSLog(@"支付宝支付成功");
                    }];
                } else if (self.selectedIndex ==2)//微信
                {
                    NSDictionary *dic = responseDict[@"data"];
                    if (dic != nil && [dic isKindOfClass:[NSDictionary class]])
                    {
                        PayReq * request = [[PayReq alloc]init];
                        request.partnerId = dic[@"partnerid"];
                        request.prepayId = dic[@"prepayid"];;
                        request.package = dic[@"package"];;
                        request.nonceStr = dic[@"noncestr"];;
                        request.timeStamp = (UInt32)[dic[@"timestamp"] integerValue];
                        request.sign = dic[@"sign"];
//                        [WXApi sendReq:request];
                        [WXApi sendReq:request completion:^(BOOL success) {
                            NSLog(@"发送微信支付%d",success);
                        }];
                    }
                }
                else if (self.selectedIndex == 3)// 余额
                {
                    [URToastHelper showErrorWithStatus:@"购买成功"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
                
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        }
    } ;
    
    self.selectedIndex = 1 ;
}

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
    return 4 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return self.stage.count + 1;
    } else if (section==3){
        return 4 ;
    } else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        UITableViewCell * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"tableViewCellID"];
        
        if (!tableViewCell) {
            tableViewCell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableViewCellID"];
            tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
        }
        
        tableViewCell.textLabel.text = @"购课账号" ;
        tableViewCell.textLabel.font = RegularFont(15.0f * AUTO_WIDTH);
        tableViewCell.textLabel.textColor = UR_ColorFromValue(0x333333);
        
        tableViewCell.detailTextLabel.text = [NSString  stringWithFormat:@"%@",[URUserDefaults  standardUserDefaults].userInforModel.phone?:@""] ;
        tableViewCell.detailTextLabel.textColor = UR_ColorFromValue(0xFF773A);
        tableViewCell.detailTextLabel.font = RegularFont(15.0f * AUTO_WIDTH);
        
        return tableViewCell ;
    }
    else if(indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            UITableViewCell * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"TableViewCellID"];
            
            if (!tableViewCell) {
                tableViewCell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableViewCellID"];
                tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
            }
            
            tableViewCell.textLabel.text = @"课程信息" ;
            tableViewCell.textLabel.font = RegularFont(15.0f * AUTO_WIDTH);
            tableViewCell.textLabel.textColor = UR_ColorFromValue(0x333333);
            return tableViewCell ;
        } else
        {
            CourseCombinationDetailTopTableViewCell * combinationTopCell = [tableView  dequeueReusableCellWithIdentifier:@"CourseCombinationDetailCourseViewCellID"] ;
            
            if (!combinationTopCell) {
                combinationTopCell = [[NSBundle  mainBundle] loadNibNamed:@"CourseCombinationDetailTopTableViewCell" owner:self options:nil][3] ;
            }
            combinationTopCell.dataModel =  self.stage[indexPath.row-1];
            return combinationTopCell ;
        }
    }
    else if(indexPath.section==2)
    {
        UITableViewCell * couponsTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"couponsTableViewCellID"];
        
        if (!couponsTableViewCell) {
            couponsTableViewCell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"couponsTableViewCellID"];
            couponsTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
            couponsTableViewCell.accessoryType =UITableViewCellAccessoryDisclosureIndicator ;
        }
        
        couponsTableViewCell.textLabel.text = @"优惠抵扣";
        couponsTableViewCell.textLabel.font = RegularFont(15.0f * AUTO_WIDTH);
        couponsTableViewCell.textLabel.textColor = UR_ColorFromValue(0x333333);
        
        couponsTableViewCell.detailTextLabel.text =@"-￥20元" ;
        couponsTableViewCell.detailTextLabel.textColor = UR_ColorFromValue(0xFF773A);
        couponsTableViewCell.detailTextLabel.font = RegularFont(15.0f * AUTO_WIDTH);
        
        return couponsTableViewCell ;
    } else
    {
        if (indexPath.row==0)
        {
            CoursePayViewTableViewCell * topTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"CoursePayTopViewTableViewCellID"] ;
            if (!topTableViewCell) {
                topTableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"CoursePayViewTableViewCell" owner:self options:nil][0] ;
            }
            return topTableViewCell ;
        } else
        {
            CoursePayViewTableViewCell * payTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"CoursePayViewTableViewCellID"] ;
            if (!payTableViewCell) {
                payTableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"CoursePayViewTableViewCell" owner:self options:nil][1] ;
            }
            
            NSArray * dataArray = @[
                                    @[@"zhifubao",@"支付宝"],
                                    @[@"wechat",@"微信"],
                                    @[@"dfk",@"余额"]
                                    ];
            
            payTableViewCell.iconImageView.image = [UIImage  imageNamed:dataArray[indexPath.row-1][0]];
            
            payTableViewCell.titleLabel.text = [NSString  stringWithFormat:@"%@",dataArray[indexPath.row-1][1]];
            
            [payTableViewCell.chooseButton setImage:[UIImage imageNamed:indexPath.row == self.selectedIndex ? @"select" : @"unselect"] forState:UIControlStateNormal];
            
            return payTableViewCell ;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * footerView = [[UIView  alloc] init];
    footerView.backgroundColor = [UIColor clearColor] ;
    
    return footerView ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==4) {
        return 0.01 ;
    } else {
        return 8 ;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3 && indexPath.row > 0)
    {
        self.selectedIndex = indexPath.row;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = UR_COLOR_LINE;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.estimatedRowHeight = 44.0f;
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

