//
//  MyClassLifeVC.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "MyClassLifeVC.h"
#import "MyClassLifeTopCell.h"
#import "MyClassLifeImgCell.h"
#import "MyClassLifeBtnCell.h"
#import "MyClassLifeZanCell.h"
#import "MyClassLifeCommentCell.h"

static NSString * const MyClassLifeTopCellIdentifier = @"MyClassLifeTopCellIdentifier";
static NSString * const MyClassLifeImgCellIdentifier = @"MyClassLifeImgCellIdentifier";
static NSString * const MyClassLifeBtnCellIdentifier = @"MyClassLifeBtnCellIdentifier";
static NSString * const MyClassLifeZanCellIdentifier = @"MyClassLifeZanCellIdentifier";
static NSString * const MyClassLifeCommentCellIdentifier = @"MyClassLifeCommentCellIdentifier";


@interface MyClassLifeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *publishBtn;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *list;

@end

@implementation MyClassLifeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cSuperTitle = @"班级生活";
    
    self.list = [NSMutableArray array];
    for (int x = 0; x < 10; x ++) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < arc4random() % 9 + 1; i++) {
            [arr addObject:@"1"];
        }
        [self.list addObject:arr];
    }


    [self.view addSubview:self.tableView];
    [self.view addSubview:self.publishBtn];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(URSafeAreaNavHeight(), 0, 49 * AUTO_WIDTH, 0));
    }];
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_equalTo(49 * AUTO_WIDTH);
    }];
    
    [[self.publishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self pushViewControllerWithString:@"ReleaseClassLifeViewController" withModel:nil];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        MyClassLifeTopCell *cell = [tableView dequeueReusableCellWithIdentifier:MyClassLifeTopCellIdentifier];
        
        return cell;
    }
    else if (indexPath.row == 1)
    {
        MyClassLifeImgCell *cell = [tableView dequeueReusableCellWithIdentifier:MyClassLifeImgCellIdentifier];
        
        cell.imgsArr = self.list[indexPath.section];
        return cell;
    }
    else if (indexPath.row == 2)
    {
        MyClassLifeBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:MyClassLifeBtnCellIdentifier];
        
        [[[cell.zanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            //点赞
        }];
        
        [[[cell.zanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            //评论
        }];
        return cell;
    }
    else if (indexPath.row == 3)
    {
        MyClassLifeZanCell *cell = [tableView dequeueReusableCellWithIdentifier:MyClassLifeZanCellIdentifier];
        return cell;
    }
    else
    {
        MyClassLifeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:MyClassLifeCommentCellIdentifier];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //要计算高度
        NSString *str = @"今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识今天学习了初级护理知识";
        CGFloat height = [str ur_sizeContraintToSize:CGSizeMake(URScreenWidth()-24 * AUTO_WIDTH, 230 * AUTO_WIDTH) font:RegularFont(FontSize14) lineSpacing:5].height;
        return 88 * AUTO_WIDTH + height;
    }
    else if (indexPath.row == 1) {
        
        NSArray *imgsArr = self.list[indexPath.section];
        NSInteger row = imgsArr.count/3  + (imgsArr.count%3 == 0 ? 0 : 1);
        
        return 113 * AUTO_WIDTH * row + 4 * AUTO_WIDTH * (row-1) + 12 * AUTO_WIDTH;
    }
    else if (indexPath.row == 2) {
        return (50+8) * AUTO_WIDTH;
    }
    else if (indexPath.row == 3) {
        return 43 * AUTO_WIDTH;
    }
    else {
        NSString *str = @"一花一言：赞\n一只皮皮匠：👍👍👍👍\n不可一世：棒棒哒";
        CGFloat height = [str ur_sizeContraintToSize:CGSizeMake(URScreenWidth()-(24+12+15+10) * AUTO_WIDTH, MAXFLOAT) font:RegularFont(FontSize14) lineSpacing:5].height;
        return 58 * AUTO_WIDTH + height;
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
        _tableView.estimatedRowHeight = 44.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
        [_tableView registerClass:[MyClassLifeTopCell class] forCellReuseIdentifier:MyClassLifeTopCellIdentifier];
        [_tableView registerClass:[MyClassLifeImgCell class] forCellReuseIdentifier:MyClassLifeImgCellIdentifier];
        [_tableView registerClass:[MyClassLifeBtnCell class] forCellReuseIdentifier:MyClassLifeBtnCellIdentifier];
        [_tableView registerClass:[MyClassLifeZanCell class] forCellReuseIdentifier:MyClassLifeZanCellIdentifier];
        [_tableView registerClass:[MyClassLifeCommentCell class] forCellReuseIdentifier:MyClassLifeCommentCellIdentifier];
    }
    return _tableView;
}

- (UIButton *)publishBtn
{
    if (!_publishBtn) {
        _publishBtn = [UIButton backcolorBtnWithTitle:@"发表我的班级生活 +" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0x9B89FF)];
    }
    return _publishBtn;
}


@end
