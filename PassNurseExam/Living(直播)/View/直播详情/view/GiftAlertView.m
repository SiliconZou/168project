//
//  GiftAlertView.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "GiftAlertView.h"
#import "RechargeVC.h"

#define item_w (URScreenWidth()/5)
#define item_h (103*AUTO_WIDTH)
#define collection_w (item_w *5)
#define alert_h (257*AUTO_WIDTH)

@interface GiftItemCollectionCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *giftImgV;
@property (nonatomic,strong) UILabel *giftNameLb;
@property (nonatomic,strong) UILabel *giftMoneyLb;

@end

@implementation GiftItemCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.giftImgV];
        [self.contentView addSubview:self.giftNameLb];
        [self.contentView addSubview:self.giftMoneyLb];
        
        [self.giftImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40*AUTO_WIDTH, 40*AUTO_WIDTH));
            make.top.mas_offset(15*AUTO_WIDTH);
            make.centerX.mas_equalTo(self.contentView);
        }];
        [self.giftNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(self.giftImgV.mas_bottom).offset(5*AUTO_WIDTH);
        }];
        [self.giftMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(self.giftNameLb.mas_bottom).offset(1*AUTO_WIDTH);
        }];
    }
    return self;
}

- (UIImageView *)giftImgV
{
    if (!_giftImgV) {
        _giftImgV = [UIImageView new];
    }
    return _giftImgV;
}

- (UILabel *)giftNameLb
{
    if (!_giftNameLb) {
        _giftNameLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _giftNameLb;
}

- (UILabel *)giftMoneyLb
{
    if (!_giftMoneyLb) {
        _giftMoneyLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x999999) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _giftMoneyLb;
}

@end

@interface GiftAlertView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIButton *myMoney;//我的积分
@property (nonatomic,strong) UIButton *chargeBtn;//充值按钮
@property (nonatomic,strong) UIButton *giveBtn;//赠送按钮
@property (nonatomic,strong) UIButton *cancelBtn;//取消按钮
@property (nonatomic,strong) UITextField * numberTextFiled;// 礼物数量


@property (nonatomic,copy) void (^__nullable commitBlock) (LiveGivingDataModel *model);
@property (nonatomic,copy) void (^__nullable cancelBlock) (void);

@property (nonatomic,strong) NSArray <LiveGivingDataModel *> *dataArr;

@property (nonatomic,strong) URUserInforModel *userInforModel;

// 记录上一次点击的
@property (nonatomic,assign) NSInteger  lastSelectedIndex ;

@end

@implementation GiftAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.delegate = self;
        [tap addTarget:self action:@selector(tapPressInAlertViewGesture:)];
        [self addGestureRecognizer:tap];
        [self createUI];
    }
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.alertView]) {
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
        
        if (![self.alertView pointInside:[self.alertView convertPoint:location fromView:self] withEvent:nil])
        {
            self.cancelBlock();
            self.isShow = NO;
            [self dismiss];
        }
    }
}

- (void)showWithGiftList:(NSArray *)list commit:(void(^)(LiveGivingDataModel *model))commit cancel:(void(^)(void))cancel
{
    self.lastSelectedIndex = -1 ;

    [self  getUserInformationData] ;
    
    self.dataArr = list;
    self.commitBlock = commit;
    self.cancelBlock = cancel;
    self.pageControl.numberOfPages = list.count / 10 + (list.count % 10 > 0 ? 1 : 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.alertView.frame = CGRectMake(0, URScreenHeight()-alert_h, URScreenWidth(), alert_h);
    }];

    [self.collection reloadData];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.alertView.frame = CGRectMake(0, URScreenHeight(), URScreenWidth(), alert_h);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.commitBlock = nil;
        self.cancelBlock = nil;
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GiftItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GiftItemCollectionCellIdentifier" forIndexPath:indexPath];
   
    LiveGivingDataModel *model = self.dataArr[indexPath.item];
    [cell.giftImgV sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
    cell.giftNameLb.text = model.name ?: @"";
    
    if ([model.univalence floatValue] == 0) {
        cell.giftMoneyLb.textColor = UR_ColorFromValue(0xFF773A);
        cell.giftMoneyLb.text = @"免费";
    }else {
        cell.giftMoneyLb.textColor = UR_ColorFromValue(0x999999);
        cell.giftMoneyLb.text = [NSString stringWithFormat:@"%@积分",model.univalence ?: @"0"];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GiftItemCollectionCell *cell = (GiftItemCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath] ;
    GiftItemCollectionCell *lastSelectedCell = (GiftItemCollectionCell *)[collectionView  cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.lastSelectedIndex inSection:0]] ;
    
    if (self.lastSelectedIndex != indexPath.item) {
        cell.layer.borderColor = UR_ColorFromValue(0xFFDD00).CGColor ;
        cell.layer.borderWidth = 1 ;
        cell.layer.cornerRadius = 2;
        cell.layer.masksToBounds = YES;
        
        lastSelectedCell.layer.borderWidth = 0 ;
        lastSelectedCell.layer.cornerRadius = 0;
        lastSelectedCell.layer.masksToBounds = YES;
        lastSelectedCell.layer.masksToBounds = NO ;
        
        self.lastSelectedIndex = indexPath.item ;
    }
}

- (void)createUI
{
    UIButton *lb1 = [UIButton normalBtnWithTitle:@"充值" titleColor:UR_ColorFromValue(0xFF773A) titleFont:RegularFont(FontSize13)];
    [[lb1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [self  dismiss] ;
        
        RechargeVC * chargeViewController = [[RechargeVC  alloc] init] ;
        
        [self.currentViewController.navigationController  pushViewController:chargeViewController animated:YES];
    }];

    UIView *btnBgView = [UIView new];
    btnBgView.layer.cornerRadius = 35/2.0 * AUTO_WIDTH;
    btnBgView.layer.borderColor = UR_ColorFromValue(0xFFDD00).CGColor;
    btnBgView.layer.borderWidth = 1;
    btnBgView.layer.masksToBounds = YES;
    
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.collection];
    [self.alertView addSubview:self.pageControl];
    [self.alertView addSubview:self.myMoney];
    [self.alertView addSubview:lb1];
    [self.alertView addSubview:btnBgView];
    [btnBgView addSubview:self.chargeBtn];
    [btnBgView addSubview:self.numberTextFiled];
    [btnBgView addSubview:self.giveBtn];

    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.height.mas_equalTo(item_h*2);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertView);
        make.bottom.mas_equalTo(self.collection);
        make.size.mas_equalTo(CGSizeMake(100*AUTO_WIDTH, 30*AUTO_WIDTH));
    }];
    
    [self.myMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12*AUTO_WIDTH);
        make.top.mas_equalTo(self.collection.mas_bottom);
        make.bottom.mas_offset(0);
    }];
    
    [self.myMoney  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:5*AUTO_WIDTH];
    
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.myMoney);
        make.right.mas_equalTo(btnBgView.mas_left).offset(-12*AUTO_WIDTH);
    }];
    [btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140*AUTO_WIDTH, 35*AUTO_WIDTH));
        make.right.mas_offset(-12*AUTO_WIDTH);
        make.centerY.mas_equalTo(self.myMoney);
    }];
//    [self.chargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.mas_equalTo(btnBgView);
//        make.width.mas_equalTo(btnBgView.mas_width).multipliedBy(0.5);
//    }];
    
    [self.numberTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(btnBgView);
        make.width.mas_equalTo(btnBgView.mas_width).multipliedBy(0.5);
    }];
    
    [self.giveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(btnBgView);
        make.width.mas_equalTo(btnBgView.mas_width).multipliedBy(0.5);
    }];
}

- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, URScreenHeight(), URScreenWidth(), alert_h)];
        _alertView.backgroundColor = UR_ColorFromValue(0xEEEEEE);
    }
    return _alertView;
}

- (UICollectionView *)collection
{
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(item_w,item_h);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.backgroundColor = [UIColor whiteColor];
        
        [_collection registerClass:[GiftItemCollectionCell class] forCellWithReuseIdentifier:@"GiftItemCollectionCellIdentifier"];
    }
    return _collection;
}

- (UIButton *)myMoney
{
    if (!_myMoney) {
        _myMoney = [UIButton normalBtnWithTitle:@"已有0积分" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize13)];
        [_myMoney setImage:[UIImage imageNamed:@"jifen"] forState:UIControlStateNormal];
        _myMoney.userInteractionEnabled = NO;
        
    }
    return _myMoney;
}

- (UIButton *)chargeBtn
{
    if (!_chargeBtn) {
        _chargeBtn = [UIButton normalBtnWithTitle:@"1" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize14)];
    }
    return _chargeBtn;
}

-(UITextField *)numberTextFiled{
    if (!_numberTextFiled) {
        _numberTextFiled = [[UITextField  alloc] init];
        _numberTextFiled.textColor = UR_ColorFromValue(0x333333) ;
        _numberTextFiled.font = RegularFont(FontSize14) ;
        _numberTextFiled.text = @"1";
        _numberTextFiled.textAlignment = NSTextAlignmentCenter ;
    }
    return _numberTextFiled ;
}

- (UIButton *)giveBtn
{
    if (!_giveBtn) {
        _giveBtn = [UIButton normalBtnWithTitle:@"赠送" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize14)];
        [_giveBtn setBackgroundColor:UR_ColorFromValue(0xFFDD00)];
        [[_giveBtn  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if (self.lastSelectedIndex==-1) {
                  [URToastHelper  showErrorWithStatus:@"请输入要赠送的礼物"];
            } else {
                if (self.numberTextFiled.text.integerValue>0) {
                    
                    [[URCommonApiManager   sharedInstance] sendGiftGivingRequestWithApi_token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" tag_name:self.tagName?:@"" flower:self.dataArr[self.lastSelectedIndex].idStr?:@"" number:self.numberTextFiled.text?:@"" teacher_id:self.teacherID?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                        
                        [URToastHelper showErrorWithStatus:@"感谢给老师赠送礼物"] ;
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self  dismiss];
                         });
                       } requestFailureBlock:^(NSError *error, id response) {
                        
                    }];
                    
                } else {
                    [URToastHelper  showErrorWithStatus:@"请输入要赠送的礼物数量"];
                }
            }
        }];
    }
    return _giveBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton normalBtnWithTitle:@"取消" titleColor:UR_ColorFromValue(0xFF773A) titleFont:RegularFont(FontSize13)];
    }
    return _cancelBtn;
}

-(void)getUserInformationData{
    
    [[URCommonApiManager  sharedInstance]  getUserInformationDataWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.userInforModel = [URUserInforModel   yy_modelWithDictionary:responseDict[@"data"]] ;
        
        [self.myMoney setTitle:[NSString  stringWithFormat:@"已有%@积分",self.userInforModel.integral?:@"0"] forState:UIControlStateNormal] ;
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

@end
