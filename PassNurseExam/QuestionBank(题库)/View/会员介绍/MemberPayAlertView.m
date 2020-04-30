//
//  MemberPayAlertView.m
//  PassNurseExam
//
//  Created by qc on 2019/9/25.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "MemberPayAlertView.h"
#import "MemberPayTableViewCell.h"
#import "BuyCourseVC.h"
@interface MemberPayAlertView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) void (^finishBlock)(void);
@property (nonatomic,assign) NSInteger selectedIndex;//支付方式索引
@property (nonatomic,strong) NSDictionary * dataDict;//
@property (nonatomic,assign) NSInteger buyType;//购买类型 1：开通会员 2：课程章节付费

@end

@implementation MemberPayAlertView

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.selectedIndex = 1;
        [self initContentView];
        
        @weakify(self);
        // 支付宝、微信支付成功回调 通知
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"PaySuccessNoti" object:nil] subscribeNext:^(id x) {
             @strongify(self);
            [self paySuccess];
        }];
    }
    return self;
}

//支付成功处理
- (void)paySuccess
{
    if (self.buyType == 1)
    {
        [[URCommonApiManager  sharedInstance] getUserInformationDataWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
            [[URUserDefaults  standardUserDefaults].userInforModel setIs_vip:responseDict[@"data"][@"is_vip"]];
            [[URUserDefaults standardUserDefaults] saveAllPropertyAction];

            //要刷新个人中心页的会员展示信息
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshUserCenterNoti" object:nil];
            
        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
        
       
    }else {}
    
    [URToastHelper showErrorWithStatus:@"购买成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.finishBlock) {
            self.finishBlock();
            [self dismiss];
        }
    });
}

#pragma mark 支付
- (void)payMoney
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
    
    if (self.buyType == 1)//开通会员
    {
        [[URCommonApiManager  sharedInstance] sendBuyMemeberRequestWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" type:choice requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
            [self paySuccessWithDic:responseDict];
            
        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
    }else//课程章节付费
    {
        [[URCommonApiManager  sharedInstance] sendPayCoursewareRequestWithUserToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" type:self.dataDict[@"courseBuyType"] ?: @"" value:self.dataDict[@"idStr"] ?: @"" choice:choice requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
            [self paySuccessWithDic:responseDict];

        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
    }
}

//调起第三方支付
- (void)paySuccessWithDic:(NSDictionary *)responseDict
{
    if (self.selectedIndex==1){//支付宝
        [[AlipaySDK  defaultService] payOrder:responseDict[@"data"] fromScheme:@"EducationAliPaySchme" callback:^(NSDictionary *resultDic) {
            NSLog(@"支付宝支付成功");
        }];
    } else if (self.selectedIndex ==2)//微信
    {
        NSDictionary *dic = responseDict[@"data"];
        if (dic != nil && [dic isKindOfClass:[NSDictionary class]]){
            PayReq * request = [[PayReq alloc]init];
            request.partnerId = dic[@"partnerid"];
            request.prepayId = dic[@"prepayid"];;
            request.package = dic[@"package"];;
            request.nonceStr = dic[@"noncestr"];;
            request.timeStamp = (UInt32)[dic[@"timestamp"] integerValue];
            request.sign = dic[@"sign"];
//            [WXApi sendReq:request];
            [WXApi sendReq:request completion:^(BOOL success) {
                NSLog(@"发送微信支付%d",success);
            }];
        }
    } else if (self.selectedIndex == 3){// 余额
        [self paySuccess];
    }
}

//弹起
- (void)showAlertView:(NSDictionary *)infoDic finish:(void (^)(void))clickBlock
{
    self.buyType = [infoDic[@"buyType"] integerValue];
    
    if (self.buyType == 1)//开通会员
    {
        [[URCommonApiManager  sharedInstance] getAppConfigDataSuccessBlock:^(id response, NSDictionary *responseDict) {
            self.dataDict = responseDict[@"data"] ;
            [self.tableView  reloadData];
        } requestFailureBlock:^(NSError *error, id response) {
        }];
    }
    else//课程章节付费
    {
        self.dataDict = infoDic;
        [self.tableView  reloadData];
    }
    
    self.finishBlock = clickBlock;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }];
}

- (void)dismiss
{
    [self removeFromSuperview];
    self.finishBlock = nil;
}

#pragma mark UI
- (void)initContentView
{
    self.backgroundColor = [UIColor clearColor];
    
    [self  addSubview:self.tableView];
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.mas_equalTo(0) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 55*5)) ;
    }];
    
    _tableView.transform = CGAffineTransformMakeScale(1, 1);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.delegate = self;
    [tap addTarget:self action:@selector(tapPressInAlertViewGesture:)];
    [self addGestureRecognizer:tap];
}


//手势代理
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }
    return YES;
}

// 点击其他区域关闭弹窗
- (void)tapPressInAlertViewGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [sender locationInView:nil];
        
        if (![self.tableView pointInside:[self.tableView convertPoint:location fromView:self] withEvent:nil])
        {
            [self dismiss];
        }
    }
}


#pragma mark table 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  5 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        MemberPayTableViewCell * topTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"MemberPayTableViewCellID"];
        
        if (!topTableViewCell) {
            topTableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"MemberPayTableViewCell" owner:self options:nil][0] ;
        }
        
        return topTableViewCell ;
    }
    else if (indexPath.row==4)
    {
        MemberPayTableViewCell * payTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"MemberPayButtonTableViewCellID"];
        
        if (!payTableViewCell) {
            payTableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"MemberPayTableViewCell" owner:self options:nil][2] ;
        }
        
        payTableViewCell.payButton.layer.cornerRadius = 15.0f ;
        payTableViewCell.payButton.layer.masksToBounds = YES ;
        
        if (self.buyType == 1) {
            payTableViewCell.moneyLabel.text = [NSString  stringWithFormat:@"¥%@",self.dataDict[@"vip_price"] ?: @""];
        }else {
            payTableViewCell.moneyLabel.text = [NSString  stringWithFormat:@"¥%@",self.dataDict[@"univalence"] ?: @""];
        }
        [[[payTableViewCell.payButton  rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:payTableViewCell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            [self payMoney];
        }];
        return payTableViewCell ;
    }
    else
    {
        MemberPayTableViewCell * payWayTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"MemberPayWayTableViewCellID"] ;
        
        if (!payWayTableViewCell) {
            payWayTableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"MemberPayTableViewCell" owner:self options:nil][1] ;
        }
        
        NSArray * dataArray = @[
                                @[@"zhifubao",@"支付宝"],
                                @[@"wechat",@"微信"],
                                @[@"dfk",@"余额"]
                                ];
        
        payWayTableViewCell.iconImage.image = [UIImage  imageNamed:dataArray[indexPath.row-1][0]] ;
        
        payWayTableViewCell.iconTitle.text = [NSString  stringWithFormat:@"%@",dataArray[indexPath.row-1][1]] ;
        
        payWayTableViewCell.selectedImage.image = [UIImage imageNamed:indexPath.row == self.selectedIndex ? @"select" : @"unselect"];

        return payWayTableViewCell ;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>0 && indexPath.row<4)
    {
        self.selectedIndex = indexPath.row;
        [self.tableView reloadData];
    }
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine ;
        _tableView.separatorColor = UR_COLOR_LINE;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0) ;
        _tableView.rowHeight = 55;
        _tableView.scrollEnabled = NO ;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _tableView;
}

@end
