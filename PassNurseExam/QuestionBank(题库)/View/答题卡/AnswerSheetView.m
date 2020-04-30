//
//  AnswerSheetView.m
//  PassNurseExam
//
//  Created by qc on 2019/9/14.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "AnswerSheetView.h"
#import "AnswerSheetCollectionCell.h"

@interface AnswerSheetView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UIImageView *iconImg;
@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UIView *answerdTag;
@property (nonatomic,strong) UILabel *answerdTagLb;
@property (nonatomic,strong) UIView *unAnswerdTag;
@property (nonatomic,strong) UILabel *unAnswerdTagLb;
@property (nonatomic,strong) UICollectionView *sheetCollection;
@property (nonatomic,strong) UIButton *commitBnt;

@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,copy) void (^linkBlock) (NSInteger nowIndex);
@property (nonatomic,copy) void (^commitBlock) (void);

@end


@implementation AnswerSheetView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.delegate = self;
        [tap addTarget:self action:@selector(tapPressInAlertViewGesture:)];
        [self addGestureRecognizer:tap];
        [self createUI];
    }
    return self;
}

- (void)alertWithDataArr:(NSArray *)data linkQuestion:(void(^)(NSInteger nowIndex))linkBlock commit:(void(^)(void))commitBlock
{
    self.dataArr = data;
    [self.sheetCollection reloadData];
    self.commitBlock = commitBlock;
    self.linkBlock = linkBlock;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        self.alertView.frame = CGRectMake(0, URScreenHeight() - 350 - URSafeAreaTabBarIncreaseHeight(), URScreenWidth(), 350);
    }];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.sheetCollection]) {
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
            [self dismiss];
        }
    }
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.alertView.frame = CGRectMake(0, URScreenHeight() , URScreenWidth(), 350 + URSafeAreaTabBarIncreaseHeight());
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.linkBlock = nil;
        self.commitBlock = nil;
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerSheetCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnswerSheetCollectionCellIdentifier" forIndexPath:indexPath];
    UnitPracticeDetailDataModel *model = self.dataArr[indexPath.row];
    cell.noLb.backgroundColor = model.isAnswered ? UR_ColorFromValue(0x59A2FF) : UR_ColorFromValue(0x999999);
    cell.noLb.text = [NSString stringWithFormat:@"%zd",indexPath.row + 1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.linkBlock) {
        self.linkBlock(indexPath.row);
        [self dismiss];
    }
}

- (void)createUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.iconImg];
    [self.alertView addSubview:self.titleLb];
    [self.alertView addSubview:self.answerdTag];
    [self.alertView addSubview:self.answerdTagLb];
    [self.alertView addSubview:self.unAnswerdTag];
    [self.alertView addSubview:self.unAnswerdTagLb];
    [self.alertView addSubview:self.sheetCollection];
    [self.alertView addSubview:self.commitBnt];
    
    [self.alertView addLineWithStartPoint:CGPointMake(0, 50 * AUTO_WIDTH) endPoint:CGPointMake(URScreenWidth(), 50 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
//    [self.alertView addLineWithStartPoint:CGPointMake(0, 300 * AUTO_WIDTH) endPoint:CGPointMake(URScreenWidth(), 300 * AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];

    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_offset(12 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(25 * AUTO_WIDTH, 25 * AUTO_WIDTH));
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImg.mas_right).offset(5 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.iconImg);
    }];
    [self.unAnswerdTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImg);
        make.right.mas_offset(-12 * AUTO_WIDTH);
    }];
    [self.unAnswerdTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25 * AUTO_WIDTH, 25 * AUTO_WIDTH));
        make.centerY.mas_equalTo(self.iconImg);
        make.right.mas_equalTo(self.unAnswerdTagLb.mas_left).offset(-10 * AUTO_WIDTH);
    }];
    [self.answerdTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImg);
        make.right.mas_equalTo(self.unAnswerdTag.mas_left).offset(-12 * AUTO_WIDTH);
    }];
    [self.answerdTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25 * AUTO_WIDTH, 25 * AUTO_WIDTH));
        make.centerY.mas_equalTo(self.iconImg);
        make.right.mas_equalTo(self.answerdTagLb.mas_left).offset(-10 * AUTO_WIDTH);
    }];
    [self.sheetCollection mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_offset(0);
        make.top.mas_offset(50 * AUTO_WIDTH);
//        make.height.mas_equalTo(250 * AUTO_WIDTH);
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 250));
    }];
    [self.commitBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100 * AUTO_WIDTH, 40 * AUTO_WIDTH));
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.sheetCollection.mas_bottom).mas_offset(2 * AUTO_WIDTH);
    }];
    
    @weakify(self);
    [[self.commitBnt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.commitBlock) {
            self.commitBlock();
            [self dismiss];
        }
    }];
}


- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, URScreenHeight(), URScreenWidth(), 350)];
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

- (UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"答题卡"]];
    }
    return _iconImg;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"答题卡列表" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _titleLb;
}

- (UIView *)answerdTag
{
    if (!_answerdTag) {
        _answerdTag = [UIView new];
        _answerdTag.backgroundColor = UR_ColorFromValue(0x59A2FF);
        _answerdTag.layer.cornerRadius = 25/2.0 * AUTO_WIDTH;
        _answerdTag.layer.masksToBounds = YES;
        _answerdTag.layer.borderColor = UR_ColorFromValue(0x999999).CGColor;
        _answerdTag.layer.borderWidth = 0.5;
    }
    return _answerdTag;
}

- (UILabel *)answerdTagLb
{
    if (!_answerdTagLb) {
        _answerdTagLb = [UILabel normalLabelWithTitle:@"已答" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _answerdTagLb;
}

- (UIView *)unAnswerdTag
{
    if (!_unAnswerdTag) {
        _unAnswerdTag = [UIView new];
        _unAnswerdTag.backgroundColor = UR_ColorFromValue(0x999999);
        _unAnswerdTag.layer.cornerRadius = 25/2.0 * AUTO_WIDTH;
        _unAnswerdTag.layer.masksToBounds = YES;
        _unAnswerdTag.layer.borderColor = UR_ColorFromValue(0x999999).CGColor;
        _unAnswerdTag.layer.borderWidth = 0.5;
    }
    return _unAnswerdTag;
}

- (UILabel *)unAnswerdTagLb
{
    if (!_unAnswerdTagLb) {
        _unAnswerdTagLb = [UILabel normalLabelWithTitle:@"未答" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _unAnswerdTagLb;
}

- (UICollectionView *)sheetCollection
{
    if (!_sheetCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(375/5.0, 375/5.0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _sheetCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _sheetCollection.delegate = self;
        _sheetCollection.dataSource = self;
        _sheetCollection.backgroundColor = [UIColor whiteColor];
        _sheetCollection.showsVerticalScrollIndicator = NO;
        _sheetCollection.showsHorizontalScrollIndicator = NO;
        [_sheetCollection registerClass:[AnswerSheetCollectionCell class] forCellWithReuseIdentifier:@"AnswerSheetCollectionCellIdentifier"];
    }
    return _sheetCollection;
}

- (UIButton *)commitBnt
{
    if (!_commitBnt) {
        _commitBnt = [UIButton cornerBtnWithRadius:5 title:@"提交" titleColor:[UIColor whiteColor] titleFont:RegularFont(16) backColor:UR_ColorFromValue(0x59A2FF)];
    }
    return _commitBnt;
}

@end
