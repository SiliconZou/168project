//
//  RechargeVC.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "RechargeVC.h"

@interface RechargeTopCell : UITableViewCell

@property (nonatomic,strong) UIImageView *bgImg;//
@property (nonatomic,strong) UIImageView *header;//头像
@property (nonatomic,strong) UILabel *nameLb;//账户名称
@property (nonatomic,strong) UILabel *moneyLb;//余额
@property (nonatomic,strong) UIButton *helpBtn;//充值助手

@end

@implementation RechargeTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createView];
    }
    return  self;
}

- (void)createView
{
    self.contentView.backgroundColor = UR_ColorFromValue(0xffffff);
    
    [self.contentView addSubview:self.bgImg];
    [self.contentView addSubview:self.header];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.moneyLb];
//    [self.contentView addSubview:self.helpBtn];
    
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(112 * AUTO_WIDTH);
    }];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60 * AUTO_WIDTH, 60 * AUTO_WIDTH));
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.bgImg.mas_bottom).offset(30 * AUTO_WIDTH);
        make.bottom.mas_offset(-30*AUTO_WIDTH);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.header.mas_right).offset(15 * AUTO_WIDTH);
        make.top.mas_equalTo(self.header.mas_top).offset(5 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
    }];
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLb);
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(5 * AUTO_WIDTH);
    }];
//    [self.helpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-12 * AUTO_WIDTH);
//        make.centerY.mas_equalTo(self.moneyLb);
//        make.height.mas_equalTo(20 * AUTO_WIDTH);
//    }];
}

- (UIImageView *)bgImg
{
    if (!_bgImg) {
        _bgImg = [UIImageView new];
        _bgImg.image = [UIImage imageNamed:@"rechargeTop"];
    }
    return _bgImg;
}

- (UIImageView *)header
{
    if (!_header) {
        _header = [UIImageView new];
        _header.backgroundColor = [UIColor lightGrayColor];
        _header.layer.cornerRadius = 30 * AUTO_WIDTH;
        _header.layer.masksToBounds = YES;
    }
    return _header;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"账户：小客阿宁（1234rt789987）" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _nameLb;
}

- (UILabel *)moneyLb
{
    if (!_moneyLb) {
        _moneyLb = [UILabel normalLabelWithTitle:@"余额：1000.00" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _moneyLb;
}

- (UIButton *)helpBtn
{
    if (!_helpBtn) {
        _helpBtn = [UIButton normalBtnWithTitle:@"充值助手" titleColor:UR_ColorFromValue(0x78BDFF) titleFont:RegularFont(FontSize13)];
    }
    return _helpBtn;
}
@end



@interface RechargeBottomCell : UITableViewCell

@property (nonatomic,copy) NSString * moneyStr;

@property (nonatomic,copy) NSString * payTypeStr;

@end

@implementation RechargeBottomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.payTypeStr = @"wx" ;
        [self createView];
    }
    return  self;
}

- (void)createView
{
    self.contentView.backgroundColor = UR_ColorFromValue(0xffffff);
    
    UILabel *title1 = [UILabel normalLabelWithTitle:@"请选择充值面额" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentLeft numberLines:1];
    UILabel *title2 = [UILabel normalLabelWithTitle:@"请选择充值方式" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentLeft numberLines:1];
    
    [self.contentView addSubview:title1];
    [self.contentView addSubview:title2];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15*AUTO_WIDTH);
        make.top.mas_offset(22*AUTO_WIDTH);
    }];
    
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15*AUTO_WIDTH);
        make.top.mas_offset(180*AUTO_WIDTH);
    }];
    
    NSMutableArray *viewArr = [NSMutableArray array];
    NSArray *money_arr1 = @[@[@"10积分",@"1"],@[@"100积分",@"10"],@[@"500积分",@"50"],@[@"1000积分",@"100"],@[@"5000积分",@"500"],@[]];
    for (int i = 0; i < money_arr1.count; i++)
    {
        if (i == money_arr1.count - 1)
        {
            UITextField *tf = [UITextField new];
            tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"其他金额" attributes:@{NSFontAttributeName:RegularFont(FontSize16),NSForegroundColorAttributeName:UR_ColorFromValue(0x333333)}];
            tf.textAlignment = NSTextAlignmentCenter;
            tf.textColor = UR_ColorFromValue(0x333333);
            tf.font = RegularFont(FontSize16);
            tf.layer.cornerRadius = 2;
            tf.layer.masksToBounds = YES;
            tf.layer.borderColor = UR_COLOR_LINE.CGColor;
            tf.layer.borderWidth = 1;
            
            [self.contentView addSubview:tf];
            
            [tf mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(105*AUTO_WIDTH, 45*AUTO_WIDTH));
                make.top.mas_offset(55*AUTO_WIDTH+(45+15)*(i/3)*AUTO_WIDTH);
                make.left.mas_offset(15*AUTO_WIDTH+(105+15)*(i%3)*AUTO_WIDTH);
            }];
            
            UIImageView *jb_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiaobiao"]];
            [tf addSubview:jb_img];
            [jb_img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.bottom.mas_offset(0);
                make.size.mas_equalTo(CGSizeMake(20*AUTO_WIDTH, 20*AUTO_WIDTH));
            }];
            jb_img.tag = 100;
            jb_img.hidden = YES;
            
            [[tf rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(id x) {
                                
                [viewArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    UIImageView *jb = (UIImageView *)[obj viewWithTag:100];
                    
                    if (idx == viewArr.count-1) {
                        jb.hidden = NO;
                        obj.layer.borderColor = UR_ColorFromValue(0xFAC200).CGColor;
                    }else {
                        jb.hidden = YES;
                        obj.layer.borderColor = UR_COLOR_LINE.CGColor;
                    }
                }];
            }];
            
            [[tf rac_textSignal] subscribeNext:^(NSString * moneyText) {
                
                self.moneyStr = moneyText ;
            }];
            
            [viewArr addObject:tf];
            
        }else
        {
            NSString *title = [NSString stringWithFormat:@"%@\n%@元",money_arr1[i][0],money_arr1[i][1]];
            NSAttributedString *atrStr = [NSMutableAttributedString ur_changeFontAndColor:RegularFont(FontSize12) Color:UR_ColorFromValue(0x666666) TotalString:title SubStringArray:@[money_arr1[i][1]]];
            
            UIButton *btn = [UIButton borderBtnWithBorderColor:UR_COLOR_LINE borderWidth:1 cornerRadius:2 title:title titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize13)];
            btn.titleLabel.numberOfLines = 2;
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn setAttributedTitle:atrStr forState:UIControlStateNormal];
            
            [self.contentView addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(105*AUTO_WIDTH, 45*AUTO_WIDTH));
                make.top.mas_offset(55*AUTO_WIDTH+(45+15)*(i/3)*AUTO_WIDTH);
                make.left.mas_offset(15*AUTO_WIDTH+(105+15)*(i%3)*AUTO_WIDTH);
            }];
            
            UIImageView *jb_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiaobiao"]];
            [btn addSubview:jb_img];
            [jb_img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.bottom.mas_offset(0);
                make.size.mas_equalTo(CGSizeMake(20*AUTO_WIDTH, 20*AUTO_WIDTH));
            }];
            jb_img.tag = 100;
            jb_img.hidden = YES;
            
            [viewArr addObject:btn];
            
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                              
                self.moneyStr = [NSString  stringWithFormat:@"%@",money_arr1[i][1]] ;
                [viewArr enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    UIImageView *jb = (UIImageView *)[obj viewWithTag:100];
                    
                    if (idx == i) {
                        jb.hidden = NO;
                        obj.layer.borderColor = UR_ColorFromValue(0xFAC200).CGColor;
                    }else {
                        jb.hidden = YES;
                        obj.layer.borderColor = UR_COLOR_LINE.CGColor;
                    }
                }];
            }];
        }
    }
    
    NSMutableArray *payBtnArr = [NSMutableArray array];
    NSArray *pay_arr1 = @[@[@"支付宝",@"支付宝",@"ali"],@[@"微信",@"微信",@"wx"]]; //,@[@"QQ钱包",@"QQ"]
    
    for (int i = 0; i < pay_arr1.count; i++)
    {
        UIButton *btn = [UIButton borderBtnWithBorderColor:UR_COLOR_LINE borderWidth:1 cornerRadius:2 title:pay_arr1[i][0] titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize16)];
        [btn setImage:[UIImage imageNamed:pay_arr1[i][1]] forState:UIControlStateNormal];
        
        [self.contentView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(105*AUTO_WIDTH, 45*AUTO_WIDTH));
            make.top.mas_offset(212*AUTO_WIDTH+(45+15)*(i/3)*AUTO_WIDTH);
            make.left.mas_offset(15*AUTO_WIDTH+(105+15)*(i%3)*AUTO_WIDTH);
        }];
        [btn layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:3];
        
        UIImageView *jb_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiaobiao"]];
        [btn addSubview:jb_img];
        [jb_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(20*AUTO_WIDTH, 20*AUTO_WIDTH));
        }];
        jb_img.tag = 100;
        jb_img.hidden = YES;
        
        [payBtnArr addObject:btn];
        
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            self.payTypeStr = [NSString  stringWithFormat:@"%@",pay_arr1[i][2]] ;
                        
            [payBtnArr enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                UIImageView *jb = (UIImageView *)[obj viewWithTag:100];
                
                if (idx == i) {
                    jb.hidden = NO;
                    obj.layer.borderColor = UR_ColorFromValue(0xFAC200).CGColor;
                }else {
                    jb.hidden = YES;
                    obj.layer.borderColor = UR_COLOR_LINE.CGColor;
                }
            }];
        }];
        
        if (i == 1) {
            UIImageView *hotImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hot"]];
            [btn addSubview:hotImg];
            [hotImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(25*AUTO_WIDTH, 11*AUTO_WIDTH));
                make.top.mas_offset(3*AUTO_WIDTH);
                make.right.mas_offset(-3*AUTO_WIDTH);
            }];
            
            //默认微信
            btn.layer.borderColor = UR_ColorFromValue(0xFAC200).CGColor;
            UIImageView *jb = (UIImageView *)[btn viewWithTag:100];
            jb.hidden = NO;
        }
    }
    
    UIButton *chargeBtn = [UIButton cornerBtnWithRadius:25*AUTO_WIDTH title:@"确认充值" titleColor:UR_ColorFromValue(0xFFFFFF) titleFont:RegularFont(FontSize21) backColor:NORMAL_COLOR];
    
    [self.contentView addSubview:chargeBtn];
    [[chargeBtn  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([NSString  isBlank:self.moneyStr]) {
            [URToastHelper  showErrorWithStatus:@"请选择或者输入要充值的金额"] ;
        } else {
            if ([NSString  isBlank:self.payTypeStr]) {
                
                [URToastHelper  showErrorWithStatus:@"请选择支付方式"] ;
                
            } else {
                
                [[URCommonApiManager  sharedInstance] sendPayCoursewareRequestWithUserToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" type:@"recharge" value:self.moneyStr?:@"" choice:self.payTypeStr?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                    
                    if ([self.payTypeStr isEqualToString:@"wx"]) {
                        NSDictionary *dic = responseDict[@"data"];
                        if (dic != nil && [dic isKindOfClass:[NSDictionary class]]){
                            PayReq * request = [[PayReq alloc]init];
                            request.partnerId = dic[@"partnerid"];
                            request.prepayId = dic[@"prepayid"];;
                            request.package = dic[@"package"];;
                            request.nonceStr = dic[@"noncestr"];;
                            request.timeStamp = (UInt32)[dic[@"timestamp"] integerValue];
                            request.sign = dic[@"sign"];
//                            [WXApi sendReq:request];
                            [WXApi sendReq:request completion:^(BOOL success) {
                                NSLog(@"发送微信支付%d",success);
                            }];
                        }
                    } else if ([self.payTypeStr isEqualToString:@"ali"]){
                        [[AlipaySDK  defaultService] payOrder:responseDict[@"data"] fromScheme:@"EducationAliPaySchme" callback:^(NSDictionary *resultDic) {
                            NSLog(@"支付宝支付成功");
                        }];
                    }
                    
                } requestFailureBlock:^(NSError *error, id response) {
                    
                }];
                
            }
        }
    }];
    
    [chargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(315*AUTO_WIDTH, 50*AUTO_WIDTH));
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_offset(320*AUTO_WIDTH);
        make.bottom.mas_offset(-30*AUTO_WIDTH);
    }];
}

@end

static NSString * const RechargeTopCellIdentifier = @"RechargeTopCellIdentifier";
static NSString * const RechargeBottomCellIdentifier = @"RechargeBottomCellIdentifier";

@interface RechargeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) URUserInforModel *userInforModel;

@end

@implementation RechargeVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self  getUserInformationData] ;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cSuperTitle = @"充值";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(URSafeAreaNavHeight(), 0, 0, 0));
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0.01 : 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        RechargeTopCell *cell = [tableView dequeueReusableCellWithIdentifier:RechargeTopCellIdentifier];
        [cell.header  sd_setImageWithURL:[NSURL  URLWithString:self.userInforModel.thumbnail]];
        cell.nameLb.text = [NSString   stringWithFormat:@"账户:%@",self.userInforModel.username?:@""] ;
        cell.moneyLb.text = [NSString   stringWithFormat:@"余额:%@",self.userInforModel.balance?:@""] ;

        return cell;
    }else
    {
        RechargeBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:RechargeBottomCellIdentifier];
        
        return cell;
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 44.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
        [_tableView registerClass:[RechargeTopCell class] forCellReuseIdentifier:RechargeTopCellIdentifier];
        [_tableView registerClass:[RechargeBottomCell class] forCellReuseIdentifier:RechargeBottomCellIdentifier];
    }
    return _tableView;
}

-(void)getUserInformationData{
    
    [[URCommonApiManager  sharedInstance]  getUserInformationDataWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.userInforModel = [URUserInforModel   yy_modelWithDictionary:responseDict[@"data"]] ;
        
        [self.tableView  reloadData];
                
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

@end
