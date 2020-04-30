//
//  BuyCourseVC.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "BuyCourseVC.h"

@interface BuyCourseTeacherInfoCell : UITableViewCell

@property (nonatomic,strong) LiveSectionDetailDataModel * dataModel ;

@property (nonatomic,strong) UIView *bgView;//
@property (nonatomic,strong) UIImageView *header;//头像
@property (nonatomic,strong) UILabel *teacherNameLb;//老师名字
@property (nonatomic,strong) UILabel *nameLb;//名称
@property (nonatomic,strong) UILabel *timeLb;//时间
@property (nonatomic,strong) UILabel *moneyLb;//价格

@end

@implementation BuyCourseTeacherInfoCell

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
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.header];
    [self.bgView addSubview:self.teacherNameLb];
    [self.bgView addSubview:self.nameLb];
    [self.bgView addSubview:self.timeLb];
    [self.bgView addSubview:self.moneyLb];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(350 * AUTO_WIDTH, 140 * AUTO_WIDTH));
        make.top.mas_offset(9 * AUTO_WIDTH);
        make.bottom.mas_offset(-9 * AUTO_WIDTH);
        make.centerX.mas_equalTo(self.contentView);
    }];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(81 * AUTO_WIDTH, 81 * AUTO_WIDTH));
        make.left.mas_offset(23 * AUTO_WIDTH);
        make.top.mas_offset(17 * AUTO_WIDTH);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.header.mas_right).offset(15 * AUTO_WIDTH);
        make.top.mas_equalTo(self.header);
        make.right.mas_offset(-20 * AUTO_WIDTH);
    }];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLb);
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(8 * AUTO_WIDTH);
    }];
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLb);
        make.bottom.mas_equalTo(self.header);
    }];
    [self.teacherNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.header.mas_bottom).offset(10 * AUTO_WIDTH);
        make.centerX.mas_equalTo(self.header);
        make.height.mas_equalTo(20 * AUTO_WIDTH);
    }];

}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = UR_ColorFromValue(0xEAF4FF);
        _bgView.layer.cornerRadius = 6 * AUTO_WIDTH;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIImageView *)header
{
    if (!_header) {
        _header = [UIImageView new];
        _header.backgroundColor = [UIColor lightGrayColor];
        _header.layer.cornerRadius = 40.5 * AUTO_WIDTH;
        _header.layer.masksToBounds = YES;
    }
    return _header;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"直播课程标题标题" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _nameLb;
}

- (UILabel *)timeLb
{
    if (!_timeLb) {
        _timeLb = [UILabel normalLabelWithTitle:@"19:30-21:30" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _timeLb;
}

- (UILabel *)moneyLb
{
    if (!_moneyLb) {
        _moneyLb = [UILabel normalLabelWithTitle:@"￥40" titleColor:UR_ColorFromValue(0xFF8500) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _moneyLb;
}

- (UILabel *)teacherNameLb
{
    if (!_teacherNameLb) {
        _teacherNameLb = [UILabel normalLabelWithTitle:@"晓明老师" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _teacherNameLb;
}

@end


#pragma mark  ===============================



@interface BuyCourseInfoCell : UITableViewCell

@property (nonatomic,strong) UIImageView *courseImg;//课程图片
@property (nonatomic,strong) UILabel *nameLb;//名称
@property (nonatomic,strong) UIImageView *timeImg;//时间图片
@property (nonatomic,strong) UILabel *timeLb;//时间
@property (nonatomic,strong) UILabel *moneyLb;//价格
@property (nonatomic,strong) UIImageView *header;//头像
@property (nonatomic,strong) UILabel *teacherNameLb;//老师名字


@end

@implementation BuyCourseInfoCell

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
    
    [self.contentView addSubview:self.courseImg];
    [self.contentView addSubview:self.header];
    [self.contentView addSubview:self.teacherNameLb];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.timeImg];
    [self.contentView addSubview:self.moneyLb];
    
    [self.courseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(111 * AUTO_WIDTH, 82 * AUTO_WIDTH));
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_offset(29 * AUTO_WIDTH);
        make.bottom.mas_offset(-29 * AUTO_WIDTH);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.courseImg.mas_right).offset(15 * AUTO_WIDTH);
        make.top.mas_equalTo(self.courseImg);
        make.right.mas_offset(-12 * AUTO_WIDTH);
    }];
    [self.timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(12 * AUTO_WIDTH, 12 * AUTO_WIDTH));
        make.left.mas_equalTo(self.nameLb);
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(12 * AUTO_WIDTH);
    }];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.nameLb);
        make.left.mas_equalTo(self.timeImg.mas_right).offset(3 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.timeImg);
    }];
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLb);
        make.top.mas_equalTo(self.timeLb.mas_bottom).offset(10 * AUTO_WIDTH);
    }];
    [self.teacherNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.moneyLb);
        make.height.mas_equalTo(20 * AUTO_WIDTH);
    }];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25 * AUTO_WIDTH, 25 * AUTO_WIDTH));
        make.right.mas_equalTo(self.teacherNameLb.mas_left).offset(-2 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.teacherNameLb);
    }];
    
}

- (UIImageView *)courseImg
{
    if (!_courseImg) {
        _courseImg = [UIImageView new];
        _courseImg.backgroundColor = UR_ColorFromValue(0xEAF4FF);
        _courseImg.layer.cornerRadius = 4 * AUTO_WIDTH;
        _courseImg.layer.masksToBounds = YES;
    }
    return _courseImg;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"直播课程标题标题" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _nameLb;
}

- (UIImageView *)timeImg
{
    if (!_timeImg) {
        _timeImg = [UIImageView new];
        _timeImg.image = [UIImage imageNamed:@"时间(3)"];
    }
    return _timeImg;
}

- (UILabel *)timeLb
{
    if (!_timeLb) {
        _timeLb = [UILabel normalLabelWithTitle:@"19:30-21:30" titleColor:UR_ColorFromValue(0xF9A768) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _timeLb;
}

- (UILabel *)moneyLb
{
    if (!_moneyLb) {
        _moneyLb = [UILabel normalLabelWithTitle:@"￥40" titleColor:UR_ColorFromValue(0xFF8500) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _moneyLb;
}

- (UILabel *)teacherNameLb
{
    if (!_teacherNameLb) {
        _teacherNameLb = [UILabel normalLabelWithTitle:@"晓明老师" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _teacherNameLb;
}

- (UIImageView *)header
{
    if (!_header) {
        _header = [UIImageView new];
        _header.backgroundColor = [UIColor lightGrayColor];
        _header.layer.cornerRadius = 12.5 * AUTO_WIDTH;
        _header.layer.masksToBounds = YES;
    }
    return _header;
}

@end



#pragma mark  ===============================


@interface BuyCoursePayCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLb;//标题

@property (nonatomic,strong) UIImageView *weixinImg;//微信
@property (nonatomic,strong) UILabel *weixinLb;//
@property (nonatomic,strong) UIButton *weixinBtn;//

@property (nonatomic,strong) UIImageView *zhifubaoImg;//支付宝
@property (nonatomic,strong) UILabel *zhifubaoLb;//
@property (nonatomic,strong) UIButton *zhifubaoBtn;//


@end

@implementation BuyCoursePayCell

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
    
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.weixinImg];
    [self.contentView addSubview:self.weixinLb];
    [self.contentView addSubview:self.weixinBtn];
    [self.contentView addSubview:self.zhifubaoImg];
    [self.contentView addSubview:self.zhifubaoLb];
    [self.contentView addSubview:self.zhifubaoBtn];
    
    [self.contentView addLineWithStartPoint:CGPointMake(0, 60 * AUTO_WIDTH) endPoint:CGPointMake(URScreenWidth(), 60 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
    
    [self.contentView addLineWithStartPoint:CGPointMake(0, 110 * AUTO_WIDTH) endPoint:CGPointMake(URScreenWidth(), 110 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_offset(20 * AUTO_WIDTH);
    }];
    
    [self.weixinImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30 * AUTO_WIDTH, 30 * AUTO_WIDTH));
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_offset(70 * AUTO_WIDTH);
    }];
    [self.weixinLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.weixinImg.mas_right).offset(15 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.weixinImg);
    }];
    [self.weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.height.mas_equalTo(50 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.weixinImg);
    }];
    
    [self.zhifubaoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30 * AUTO_WIDTH, 30 * AUTO_WIDTH));
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_offset(120 * AUTO_WIDTH);
    }];
    [self.zhifubaoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.zhifubaoImg.mas_right).offset(15 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.zhifubaoImg);
    }];
    [self.zhifubaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.height.mas_equalTo(50 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.zhifubaoImg);
        make.bottom.mas_offset(0);
    }];    
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"选择支付方式" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _titleLb;
}

- (UIImageView *)weixinImg
{
    if (!_weixinImg) {
        _weixinImg = [UIImageView new];
        _weixinImg.image = [UIImage imageNamed:@"wechat"];
    }
    return _weixinImg;
}

- (UILabel *)weixinLb
{
    if (!_weixinLb) {
        _weixinLb = [UILabel normalLabelWithTitle:@"微信支付" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _weixinLb;
}

- (UIButton *)weixinBtn
{
    if (!_weixinBtn) {
        _weixinBtn = [UIButton ImgBtnWithImageName:@"unselect"];
        [_weixinBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        _weixinBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _weixinBtn;
}

- (UIImageView *)zhifubaoImg
{
    if (!_zhifubaoImg) {
        _zhifubaoImg = [UIImageView new];
        _zhifubaoImg.image = [UIImage imageNamed:@"zhifubao"];
    }
    return _zhifubaoImg;
}

- (UILabel *)zhifubaoLb
{
    if (!_zhifubaoLb) {
        _zhifubaoLb = [UILabel normalLabelWithTitle:@"支付宝支付" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _zhifubaoLb;
}

- (UIButton *)zhifubaoBtn
{
    if (!_zhifubaoBtn) {
        _zhifubaoBtn = [UIButton ImgBtnWithImageName:@"unselect"];
        [_zhifubaoBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        _zhifubaoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _zhifubaoBtn;
}

@end

#pragma mark  ===============================


static NSString * const BuyCourseTeacherInfoCellIdentifier = @"BuyCourseTeacherInfoCellIdentifier";
static NSString * const BuyCourseInfoCellIdentifier = @"BuyCourseInfoCellIdentifier";
static NSString * const BuyCoursePayCellIdentifier = @"BuyCoursePayCellIdentifier";


@interface BuyCourseVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *buyBtn;
@property (nonatomic,strong) UILabel *totalPriceLb;
@property (nonatomic,copy) NSString *payType;//支付方式

@end

@implementation BuyCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cSuperTitle = @"确认订单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.totalPriceLb];
    [self.view addSubview:self.buyBtn];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
        make.bottom.mas_equalTo(self.buyBtn.mas_top);
    }];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(120 * AUTO_WIDTH, 50 * AUTO_WIDTH));
        make.bottom.mas_offset(0);
    }];
    [self.totalPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.buyBtn);
        make.right.mas_equalTo(self.buyBtn.mas_left).offset(-15 * AUTO_WIDTH);
    }];
    
    NSString * userIDStr ;
    
    if ([self.dataModel  isKindOfClass:[LiveSectionDetailDataModel  class]]) {
        LiveSectionDetailDataModel * detailDataModel = self.dataModel ;
        
        //总价、数量
        NSString *totalString = [NSString stringWithFormat:@"共￥%@元",detailDataModel.univalence?:@""];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
        
        [attributedStr addAttribute:NSForegroundColorAttributeName value:UR_ColorFromValue(0xFF7A3E) range:[totalString rangeOfString:[NSString stringWithFormat:@"￥%@元",detailDataModel.univalence?:@""]]];
        
        [attributedStr addAttribute:NSFontAttributeName value:RegularFont(FontSize14) range:[totalString rangeOfString:@"￥"]];
        [attributedStr addAttribute:NSFontAttributeName value:BoldFont(FontSize21) range:[totalString rangeOfString:[NSString stringWithFormat:@"%@",detailDataModel.univalence?:@""]]];
        [attributedStr addAttribute:NSFontAttributeName value:RegularFont(FontSize14) range:[totalString rangeOfString:@"元"]];
        
        self.totalPriceLb.attributedText = attributedStr;
        
        userIDStr = [NSString   stringWithFormat:@"%@",detailDataModel.idStr?:@""] ;

    } else if ([self.dataModel  isKindOfClass:[LiveHomeFamousTeacherModel  class]]) {
        
        LiveHomeFamousTeacherModel * detailDataModel = self.dataModel ;
        
        //总价、数量
        NSString *totalString = [NSString stringWithFormat:@"共￥%@元",detailDataModel.univalence?:@""];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
        
        [attributedStr addAttribute:NSForegroundColorAttributeName value:UR_ColorFromValue(0xFF7A3E) range:[totalString rangeOfString:[NSString stringWithFormat:@"￥%@元",detailDataModel.univalence?:@""]]];
        
        [attributedStr addAttribute:NSFontAttributeName value:RegularFont(FontSize14) range:[totalString rangeOfString:@"￥"]];
        [attributedStr addAttribute:NSFontAttributeName value:BoldFont(FontSize21) range:[totalString rangeOfString:[NSString stringWithFormat:@"%@",detailDataModel.univalence?:@""]]];
        [attributedStr addAttribute:NSFontAttributeName value:RegularFont(FontSize14) range:[totalString rangeOfString:@"元"]];
        
        self.totalPriceLb.attributedText = attributedStr;
        
        userIDStr = [NSString   stringWithFormat:@"%@",detailDataModel.idStr?:@""] ;
        
    } else if ([self.dataModel  isKindOfClass:[LiveHomeBroadcastNoticeListModel  class]]){
        
        LiveHomeBroadcastNoticeListModel * detailDataModel = self.dataModel ;
        
        //总价、数量
        NSString *totalString = [NSString stringWithFormat:@"共￥%@元",detailDataModel.univalence?:@""];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
        
        [attributedStr addAttribute:NSForegroundColorAttributeName value:UR_ColorFromValue(0xFF7A3E) range:[totalString rangeOfString:[NSString stringWithFormat:@"￥%@元",detailDataModel.univalence?:@""]]];
        
        [attributedStr addAttribute:NSFontAttributeName value:RegularFont(FontSize14) range:[totalString rangeOfString:@"￥"]];
        [attributedStr addAttribute:NSFontAttributeName value:BoldFont(FontSize21) range:[totalString rangeOfString:[NSString stringWithFormat:@"%@",detailDataModel.univalence?:@""]]];
        [attributedStr addAttribute:NSFontAttributeName value:RegularFont(FontSize14) range:[totalString rangeOfString:@"元"]];
        
        self.totalPriceLb.attributedText = attributedStr;
        
        userIDStr = [NSString   stringWithFormat:@"%@",detailDataModel.idStr?:@""] ;
        
    } else if ([self.dataModel isKindOfClass:[FmousTeacherBroadcastDataModel class]]) {
        FmousTeacherBroadcastDataModel *detailDataModel = self.dataModel;
        //总价、数量
        NSString *totalString = [NSString stringWithFormat:@"共￥%@元",detailDataModel.univalence?:@""];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
        
        [attributedStr addAttribute:NSForegroundColorAttributeName value:UR_ColorFromValue(0xFF7A3E) range:[totalString rangeOfString:[NSString stringWithFormat:@"￥%@元",detailDataModel.univalence?:@""]]];
        
        [attributedStr addAttribute:NSFontAttributeName value:RegularFont(FontSize14) range:[totalString rangeOfString:@"￥"]];
        [attributedStr addAttribute:NSFontAttributeName value:BoldFont(FontSize21) range:[totalString rangeOfString:[NSString stringWithFormat:@"%@",detailDataModel.univalence?:@""]]];
        [attributedStr addAttribute:NSFontAttributeName value:RegularFont(FontSize14) range:[totalString rangeOfString:@"元"]];
        
        self.totalPriceLb.attributedText = attributedStr;
        
        userIDStr = [NSString   stringWithFormat:@"%@",detailDataModel.idStr?:@""] ;
    }
    
    
    [[self.buyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        if ([NSString  isBlank:self.payType]) {
            
            [URToastHelper  showErrorWithStatus:@"请选择支付方式"];
        } else {
            [[URCommonApiManager  sharedInstance] sendPayCoursewareRequestWithUserToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" type:@"live" value:userIDStr choice:self.payType.integerValue==1?@"wx":@"ali" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                if (self.payType.integerValue == 1) {
                    NSDictionary *dic = responseDict[@"data"];
                    if (dic != nil && [dic isKindOfClass:[NSDictionary class]]){
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
                } else {
                    [[AlipaySDK  defaultService] payOrder:responseDict[@"data"] fromScheme:@"EducationAliPaySchme" callback:^(NSDictionary *resultDic) {
                        NSLog(@"支付宝支付成功");
                    }];
                }
                
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        }
        
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"PaySuccessNoti" object:nil] subscribeNext:^(id x) {
        [URToastHelper  showErrorWithStatus:@"预约成功"] ;
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 0 ? (self.buyType == 1 ? 0.01 : 9 * AUTO_WIDTH) : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (self.buyType == 1) //购买视频
        {
            BuyCourseTeacherInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:BuyCourseTeacherInfoCellIdentifier];
            
            if ([self.dataModel  isKindOfClass:[LiveSectionDetailDataModel  class]]) {
                LiveSectionDetailDataModel * detailDataModel = self.dataModel ;
                
                cell.nameLb.text = [NSString  stringWithFormat:@"%@",detailDataModel.title?:@""] ;
                cell.timeLb.text = [NSString  stringWithFormat:@"%@",detailDataModel.start_date?:@""] ;
                cell.moneyLb.text = [NSString  stringWithFormat:@"¥%@",detailDataModel.univalence?:@""] ;
                cell.teacherNameLb.text =  [NSString  stringWithFormat:@"%@",detailDataModel.teacher_info.name?:@""] ;
                [cell.header  sd_setImageWithURL:[NSURL   URLWithString:detailDataModel.teacher_info.thumbnail]] ;
                
            } else if ([self.dataModel  isKindOfClass:[LiveHomeFamousTeacherModel  class]]) {
                LiveHomeFamousTeacherModel * detailDataModel = self.dataModel ;
                
                cell.nameLb.text = [NSString  stringWithFormat:@"%@",detailDataModel.title?:@""] ;
                cell.timeLb.text = [NSString  stringWithFormat:@"%@",detailDataModel.start_date?:@""] ;
                cell.moneyLb.text = [NSString  stringWithFormat:@"¥%@",detailDataModel.univalence?:@""] ;
                cell.teacherNameLb.text =  [NSString  stringWithFormat:@"%@",detailDataModel.teacher_info.name?:@""] ;
                [cell.header  sd_setImageWithURL:[NSURL   URLWithString:detailDataModel.teacher_info.thumbnail]] ;
            } else if([self.dataModel  isKindOfClass:[LiveHomeBroadcastNoticeListModel  class]]){
                
                LiveHomeBroadcastNoticeListModel * detailDataModel = self.dataModel ;
                
                cell.nameLb.text = [NSString  stringWithFormat:@"%@",detailDataModel.title?:@""] ;
                cell.timeLb.text = [NSString  stringWithFormat:@"%@",detailDataModel.start_date?:@""] ;
                cell.moneyLb.text = [NSString  stringWithFormat:@"¥%@",detailDataModel.univalence?:@""] ;
                cell.teacherNameLb.text =  [NSString  stringWithFormat:@"%@",detailDataModel.teacher_info[0].name?:@""] ;
                [cell.header  sd_setImageWithURL:[NSURL   URLWithString:detailDataModel.thumbnail]] ;
                
            } else if ([self.dataModel isKindOfClass:[FmousTeacherBroadcastDataModel class]]) {
                FmousTeacherBroadcastDataModel *detailDataModel = self.dataModel;
                cell.nameLb.text = [NSString  stringWithFormat:@"%@",detailDataModel.title?:@""] ;
                cell.timeLb.text = [NSString  stringWithFormat:@"%@",detailDataModel.start_date?:@""] ;
                cell.moneyLb.text = [NSString  stringWithFormat:@"¥%@",detailDataModel.univalence?:@""] ;
                cell.teacherNameLb.text =  [NSString  stringWithFormat:@"%@",detailDataModel.teacher_info[0].name?:@""] ;
                [cell.header  sd_setImageWithURL:[NSURL   URLWithString:detailDataModel.thumbnail]] ;
            }
            
            return cell;
        }
        else//购买课程
        {
            BuyCourseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:BuyCourseInfoCellIdentifier];
            
            NSString *totalString = [NSString stringWithFormat:@"￥%@起",@"128"];
            cell.moneyLb.attributedText = [NSMutableAttributedString ur_changeFontAndColor:BoldFont(FontSize18) Color:UR_ColorFromValue(0xFF773A) TotalString:totalString SubStringArray:@[@"128"]];
            
            return cell;
        }
    }else
    {
        BuyCoursePayCell *cell = [tableView dequeueReusableCellWithIdentifier:BuyCoursePayCellIdentifier];
       
        [[[cell.weixinBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            // 微信支付
            cell.weixinBtn.selected = YES;
            cell.zhifubaoBtn.selected = NO;
            self.payType = @"1";
        }];
        
        [[[cell.zhifubaoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            // 支付宝支付
            cell.zhifubaoBtn.selected = YES;
            cell.weixinBtn.selected = NO;
            self.payType = @"2";
        }];
        
        return cell;
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
        [_tableView registerClass:[BuyCourseTeacherInfoCell class] forCellReuseIdentifier:BuyCourseTeacherInfoCellIdentifier];
        [_tableView registerClass:[BuyCourseInfoCell class] forCellReuseIdentifier:BuyCourseInfoCellIdentifier];
        [_tableView registerClass:[BuyCoursePayCell class] forCellReuseIdentifier:BuyCoursePayCellIdentifier];
    }
    return _tableView;
}

- (UILabel *)totalPriceLb
{
    if (!_totalPriceLb) {
        _totalPriceLb = [UILabel normalLabelWithTitle:@"共1件商品" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _totalPriceLb;
}

- (UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [UIButton backcolorBtnWithTitle:@"立即支付" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0xFFAF57)];
    }
    return _buyBtn;
}

@end
