//
//  ReleaseClassLifeViewController.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "ReleaseClassLifeViewController.h"

@interface ReleaseClassLifeTopCell : UICollectionViewCell

@property (nonatomic,strong) EaseTextView * feedTextView;


@end

@implementation ReleaseClassLifeTopCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.contentView.backgroundColor = UR_ColorFromValue(0xffffff);
    
    self.feedTextView = [EaseTextView new];
    self.feedTextView.textColor = UR_ColorFromValue(0x999999);
    self.feedTextView.font = RegularFont(FontSize14);
    self.feedTextView.placeHolder = @"这一刻的想法. . .";
    self.feedTextView.layer.borderWidth = .5f ;
    self.feedTextView.layer.borderColor = UR_ColorFromValue(0xCCCCCC).CGColor ;
    [self.contentView  addSubview:self.feedTextView];
    [self.feedTextView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(337 * AUTO_WIDTH, 134 * AUTO_WIDTH));
        make.top.mas_equalTo(23 * AUTO_WIDTH);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    UILabel * numberLabel = [UILabel  normalLabelWithTitle:@"最长可输入200字" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1] ;
    [self.contentView  addSubview:numberLabel];
    [numberLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * AUTO_WIDTH) ;
        make.top.mas_equalTo(self.feedTextView.mas_bottom).mas_offset(7 * AUTO_WIDTH);
    }];
}

@end



@interface ReleaseClassLifeImgCell : UICollectionViewCell

@property (nonatomic,strong) UIButton * imgBtn;

@end

@implementation ReleaseClassLifeImgCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.contentView.backgroundColor = UR_ColorFromValue(0xffffff);
    
    self.imgBtn = [UIButton ImgBtnWithImageName:@"tjtp"];
    self.imgBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:self.imgBtn];
    [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

@end



@interface ReleaseClassLifeCommitCell : UICollectionViewCell

@property (nonatomic,strong) UIButton * commitBtn;

@end

@implementation ReleaseClassLifeCommitCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.contentView.backgroundColor = UR_ColorFromValue(0xffffff);
    
    self.commitBtn = [UIButton cornerBtnWithRadius:18 * AUTO_WIDTH title:@"发表" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0x5AA2FF)];
    [self.contentView addSubview:self.commitBtn];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(309 * AUTO_WIDTH, 37 * AUTO_WIDTH));
        make.center.mas_equalTo(self.contentView);
    }];
}

@end



static NSString * const ReleaseClassLifeTopCellIdentfier = @"ReleaseClassLifeTopCellIdentfier";
static NSString * const ReleaseClassLifeImgCellIdentfier = @"ReleaseClassLifeImgCellIdentfier";
static NSString * const ReleaseClassLifeCommitCellIdentfier = @"ReleaseClassLifeCommitCellIdentfier";


@interface ReleaseClassLifeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,strong) NSMutableArray *imgsArr;
@property (nonatomic,strong) NSMutableArray * imagesURLArray;


@end

@implementation ReleaseClassLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cSuperTitle = @"班级生活";

    self.imgsArr = [NSMutableArray array];
    self.imagesURLArray = [NSMutableArray  array] ;
    
    [self.view addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(URSafeAreaNavHeight(), 0, 0, 0));
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  section == 1 ? MIN(self.imgsArr.count + 1, 9) : 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        ReleaseClassLifeTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReleaseClassLifeTopCellIdentfier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        ReleaseClassLifeImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReleaseClassLifeImgCellIdentfier forIndexPath:indexPath];
        
        if (indexPath.row < self.imgsArr.count)
        {
            [cell.imgBtn setImage:self.imgsArr[indexPath.row] forState:UIControlStateNormal];
        }else
        {
            [cell.imgBtn setImage:[UIImage imageNamed:@"tjtp"] forState:UIControlStateNormal];
        }
        return cell;
    }
    else
    {
        ReleaseClassLifeCommitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReleaseClassLifeCommitCellIdentfier forIndexPath:indexPath];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(URScreenWidth(), 193 * AUTO_WIDTH);
    }else if (indexPath.section == 1) {
        return CGSizeMake(106 * AUTO_WIDTH, 106 * AUTO_WIDTH);
    }else {
        return CGSizeMake(URScreenWidth(), 99 * AUTO_WIDTH);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        return 9 * AUTO_WIDTH;
    }else {
        return 0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        return 9 * AUTO_WIDTH;
    }else {
        return 0;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 19 * AUTO_WIDTH, 0, 19 * AUTO_WIDTH);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        
        [self  selectImageWithAllowsEditing:YES title:@"请选择要上传的图片" completeBlock:^(UIImage *  images) {
            
            [[URCommonApiManager  sharedInstance] sendUploadImageRequestWithFile:images requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                [self.imagesURLArray  addObject:responseDict[@"data"]?:@""];
                
                if (indexPath.row >= self.imgsArr.count) {
                    [self.imgsArr  addObject:images];
                }else {
                    [self.imgsArr replaceObjectAtIndex:indexPath.row withObject:images];
                }
                [self.collection  reloadSections:[NSIndexSet indexSetWithIndex:1]];
                
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
        }] ;
    }
}

- (UICollectionView *)collection
{
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.delegate = self;
        _collection.dataSource = self;
        
        [_collection registerClass:[ReleaseClassLifeTopCell class] forCellWithReuseIdentifier:ReleaseClassLifeTopCellIdentfier];
        [_collection registerClass:[ReleaseClassLifeImgCell class] forCellWithReuseIdentifier:ReleaseClassLifeImgCellIdentfier];
        [_collection registerClass:[ReleaseClassLifeCommitCell class] forCellWithReuseIdentifier:ReleaseClassLifeCommitCellIdentfier];
    }
    return _collection;
}

@end
