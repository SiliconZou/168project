

//
//  GrabAnswerView.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/18.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "GrabAnswerView.h"
#import "UnitPracticeDetailImgOrVideoCell.h"
#import "UnitPracticeDetailQuestionContentCell.h"
#import "UnitPracticeDetailOptionsCell.h"
#import "UILabel+DateCountdown.h"

static NSString * const UnitPracticeDetailImgOrVideoCellIdentifier = @"UnitPracticeDetailImgOrVideoCellIdentifier";
static NSString * const UnitPracticeDetailQuestionContentCellIdentifier = @"UnitPracticeDetailQuestionContentCellIdentifier";
static NSString * const UnitPracticeDetailOptionsCellIdentifier = @"UnitPracticeDetailOptionsCellIdentifier";

@interface GrabAnswerView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *alertView;
@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic,strong) UIButton *timeDownBtn;//提交、倒计时按钮
@property (nonatomic,strong) NSArray *noTitles;
@property (nonatomic,strong) LiveSectionAnswerQuestionsFromModel * dataModel;


@property (nonatomic,copy) void (^__nullable commitBlock) (id);
@property (nonatomic,copy) void (^__nullable cancelBlock) (void);

@end

@implementation GrabAnswerView

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
            [self dismiss];
        }
    }
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.alertView.alpha = 0;
        self.alertView.transform = CGAffineTransformMakeScale(0.6, 0.6);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.commitBlock = nil;
        self.cancelBlock = nil;
    }];
}

- (void)showWithData:(id)model commit:(void(^)(id))commit cancel:(void(^)(void))cancel
{
    self.commitBlock = commit;
    self.cancelBlock = cancel;
    self.dataModel = model;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        self.alertView.alpha = 1;
        self.alertView.transform = CGAffineTransformMakeScale(1, 1);
    }];    
    [self.tableView reloadData];
    
    __block NSInteger time = 10;
    @weakify(self);
    [[RACSignal interval:1 onScheduler:[RACScheduler scheduler]] subscribeNext:^(id x) {
        @strongify(self);
        time--;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.timeDownBtn setTitle:[NSString stringWithFormat:@"立即提交 %zds",time] forState:UIControlStateNormal];
            
            if (time == 0) {
                [self dismiss];
            }
        }) ;
        
    }];
}

- (void)createUI
{
    self.noTitles = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"抢答"]];
    
    [self addSubview:self.alertView];
    [self.alertView addSubview:bgImg];
    [self.alertView  addSubview:self.tableView];
    
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(320 * AUTO_WIDTH, (352+181/2.0) * AUTO_WIDTH));
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).multipliedBy(0.9);
    }];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(254/2.0 * AUTO_WIDTH, 181/2.0 * AUTO_WIDTH));
        make.top.mas_offset(0);
        make.left.mas_offset(0*AUTO_WIDTH);
    }];
     
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(bgImg.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(320*AUTO_WIDTH, 352*AUTO_WIDTH));
    }];
    
    UIView *tableFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, URScreenWidth(), 77*AUTO_WIDTH)];
    tableFooter.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton cornerBtnWithRadius:37/2.0*AUTO_WIDTH title:@"立即提交 10s" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize16) backColor:UR_ColorFromValue(0x59A2FF)];
    [tableFooter addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(139*AUTO_WIDTH, 37*AUTO_WIDTH));
        make.center.mas_equalTo(tableFooter);
    }];
    
    self.timeDownBtn = btn;
    [[self.timeDownBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self commitResult];
    }];
    
    self.tableView.tableFooterView = tableFooter;
    
    self.alertView.alpha = 0;
    self.alertView.transform = CGAffineTransformMakeScale(0.6, 0.6);
}
 
//提交结果
- (void)commitResult
{
    //数据处理
    NSMutableArray *resultArr = [NSMutableArray array];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // id：题id
    dic[@"id"] = self.dataModel.idStr;
    
    //option：选择的答案
    NSString *optionStr = @"";
    for (int j = 0; j < self.dataModel.options.count; j++)
    {
        OptionsModel *option = self.dataModel.options[j];
        
        if (option.selected == YES) {
            optionStr = [NSString stringWithFormat:@"%@%d",optionStr,j+1];
        }
    }
    
    if (optionStr.length == 0) {
        [URToastHelper showErrorWithStatus:@"请选择答案"];
        return;
    }
    
    dic[@"option"] = optionStr;
    
    // wrong 1正确2错误
    dic[@"wrong"] = [optionStr isEqualToString:self.dataModel.answer] ? @"1" : @"2";
    
    [resultArr addObject:dic];
    
    //数组转json
//    NSError *error;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:resultArr options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *recordId = [[NSString alloc] initWithData: jsonData encoding:NSUTF8StringEncoding];
    
    [[URCommonApiManager  sharedInstance] sendLiveSectionSubmitAnswerRequestWithApi_token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" question_id:self.dataModel.idStr answer:optionStr requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        [URToastHelper showErrorWithStatus:@"提交成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self  dismiss] ;
            
        });
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [NSString isBlankString:self.dataModel.picture] == NO ? 2 : 1;
    }
    return section == 1 ? self.dataModel.options.count : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if ([NSString isBlankString:self.dataModel.picture] == NO && indexPath.row == 0)
        {
            //图片和视频的cell
            UnitPracticeDetailImgOrVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];
            
            cell.currentPicURL = self.dataModel.picture;

            return cell;
        }else
        {
            UnitPracticeDetailQuestionContentCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
            cell.questionContentLb.text = self.dataModel.title ?: @"";
            
            //目前抢答 只有单选。
            cell.questionContentLb.attributedText = [NSMutableAttributedString ur_changeColorWithColor:UR_ColorFromValue(0xFF9600) totalString:[NSString stringWithFormat:@"\n【单选】%@",self.dataModel.title ?: @""] subStringArray:@[@"【单选】"]];
            
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        UnitPracticeDetailOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:UnitPracticeDetailOptionsCellIdentifier];
        cell.noLb.text = self.noTitles[indexPath.row];
        
        OptionsModel *option = self.dataModel.options[indexPath.row];
        cell.optionsLb.text = option.optionName;
        cell.optionsLb.textColor = option.selected ? UR_ColorFromValue(0x9B89FF) : UR_ColorFromValue(0x333333);
        cell.noLb.textColor = option.selected ? UR_ColorFromValue(0xFFFFFF) : UR_ColorFromValue(0x333333);
        cell.noLb.backgroundColor = option.selected ? UR_ColorFromValue(0x9B89FF) : UR_ColorFromValue(0xFFFFFF);
        cell.noLb.layer.borderColor = option.selected ? UR_ColorFromValue(0x9B89FF).CGColor : UR_ColorFromValue(0xCCCCCC).CGColor;
        [cell.selectBtn setImage:[UIImage imageNamed:option.selected ? @"select" : @"unselect"] forState:UIControlStateNormal];
        return cell;
    }
   
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        //抢答里面只有单选题
        for (int i = 0; i < self.dataModel.options.count; i++)
        {
            OptionsModel *option = self.dataModel.options[i];
            option.selected = indexPath.row == i ? YES : NO;
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (UIView *)alertView
{
    if (!_alertView) {
        _alertView = [UIView new];
    }
    return _alertView;
}
 
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.layer.cornerRadius = 29*AUTO_WIDTH;
        _tableView.layer.borderColor = UR_ColorFromValue(0x59A2FF).CGColor;
        _tableView.layer.borderWidth = 5*AUTO_WIDTH;
        _tableView.layer.shadowColor = UR_ColorFromValue(0x656BE2).CGColor;
        _tableView.layer.shadowRadius = 90*AUTO_WIDTH;
        _tableView.layer.shadowOffset = CGSizeMake(0, 3);
        _tableView.layer.shadowOpacity = 1;

        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 44.0f;
         
        [_tableView registerClass:[UnitPracticeDetailImgOrVideoCell class] forCellReuseIdentifier:UnitPracticeDetailImgOrVideoCellIdentifier];

        [_tableView registerClass:[UnitPracticeDetailQuestionContentCell class] forCellReuseIdentifier:UnitPracticeDetailQuestionContentCellIdentifier];
         
        [_tableView registerClass:[UnitPracticeDetailOptionsCell class] forCellReuseIdentifier:UnitPracticeDetailOptionsCellIdentifier];
    }
    return _tableView;
}

@end
