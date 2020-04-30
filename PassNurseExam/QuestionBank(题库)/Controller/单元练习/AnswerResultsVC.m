//
//  AnswerResultsVC.m
//  PassNurseExam
//
//  Created by qc on 2019/9/18.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "AnswerResultsVC.h"
#import "AnswerSheetCollectionCell.h"
#import "AnswerSheetTitleCell.h"
#import "AnswerSheetSingleQuestionDetailVC.h"

static NSString * const AnswerSheetCollectionCellIdentifier = @"AnswerSheetCollectionCellIdentifier";
static NSString * const AnswerSheetTitleCellIdentifier = @"AnswerSheetTitleCellIdentifier";


@interface AnswerResultsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *sheetCollection;
@property (nonatomic,strong) UIButton *commitBnt;


@end

@implementation AnswerResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cSuperTitle = @"答题结果";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)navLeftPressed
{
    [self hm_popToViewController:@"UnitPracticeViewController"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section == 0 ? 1 : self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        AnswerSheetTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AnswerSheetTitleCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    AnswerSheetCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AnswerSheetCollectionCellIdentifier forIndexPath:indexPath];
    
    UnitPracticeDetailDataModel *model = self.dataArr[indexPath.row];
    
    //1正确 2错误
    cell.noLb.backgroundColor = model.isAnswered == NO ? UR_ColorFromValue(0xFFFFFF) : [model.wrong integerValue] == 1 ? UR_ColorFromValue(0x59A2FF) : UR_ColorFromValue(0xFF6161) ;
    cell.noLb.textColor = model.isAnswered ? UR_ColorFromValue(0xFFFFFF) : UR_ColorFromValue(0x333333);
    cell.noLb.text = [NSString stringWithFormat:@"%zd",indexPath.row + 1];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(URScreenWidth(), 50 * AUTO_WIDTH);
    }
    return CGSizeMake(URScreenWidth()/5.0, URScreenWidth()/5.0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && [kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerIdentifier" forIndexPath:indexPath];
        
        if ([footer.subviews containsObject:self.commitBnt] == NO)
        {
            [footer addSubview:self.commitBnt];
            
            [self.commitBnt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(100 * AUTO_WIDTH, 40 * AUTO_WIDTH));
                make.right.mas_offset(-12 * AUTO_WIDTH);
                make.centerY.mas_offset(0);
            }];
            
            @weakify(self);
            [[self.commitBnt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self);
                [self hm_popToViewController:@"UnitPracticeViewController"];
            }];
        }
        return footer;
    }else {
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(URScreenWidth(), 50 * AUTO_WIDTH);
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerSheetSingleQuestionDetailVC *vc = [[AnswerSheetSingleQuestionDetailVC alloc] init];
    vc.unitQuestionModel = self.dataArr[indexPath.row];
    [vc show];
}

- (void)createUI
{
    [self.view addSubview:self.sheetCollection];
   
    [self.sheetCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];
}


- (UICollectionView *)sheetCollection
{
    if (!_sheetCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(URScreenWidth()/5.0, URScreenWidth()/5.0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _sheetCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _sheetCollection.delegate = self;
        _sheetCollection.dataSource = self;
        _sheetCollection.backgroundColor = [UIColor whiteColor];
        _sheetCollection.showsVerticalScrollIndicator = NO;
        _sheetCollection.showsHorizontalScrollIndicator = NO;
        _sheetCollection.layer.borderWidth = 0.5;
        _sheetCollection.layer.borderColor = UR_COLOR_LINE.CGColor;
        
        [_sheetCollection registerClass:[AnswerSheetTitleCell class] forCellWithReuseIdentifier:AnswerSheetTitleCellIdentifier];
        [_sheetCollection registerClass:[AnswerSheetCollectionCell class] forCellWithReuseIdentifier:AnswerSheetCollectionCellIdentifier];
        [_sheetCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerIdentifier"];
    }
    return _sheetCollection;
}

- (UIButton *)commitBnt
{
    if (!_commitBnt) {
        _commitBnt = [UIButton cornerBtnWithRadius:5 title:@"返回" titleColor:[UIColor whiteColor] titleFont:RegularFont(16) backColor:UR_ColorFromValue(0x59A2FF)];
    }
    return _commitBnt;
}

@end
