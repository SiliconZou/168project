//
//  ConfirmPapersViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "ConfirmPapersViewController.h"
#import "AnswerSheetCollectionCell.h"
#import "ConfirmPapersCell.h"
#import "AnswerSheetTitleCell.h"
#import "AnswerSheetSingleQuestionDetailVC.h"

static NSString * const AnswerSheetTitleCellIdentifier = @"AnswerSheetTitleCellIdentifier";
static NSString * const AnswerSheetCollectionCellIdentifier = @"AnswerSheetCollectionCellIdentifier";
static NSString * const ConfirmPapersCellIdentifier = @"ConfirmPapersCellIdentifier";
static NSString * const SheetHederIdentifier = @"SheetHederIdentifier";


@interface ConfirmPapersViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *sheetCollection;
@property (nonatomic,assign) BOOL showSheet;//是否展示答题卡

@end

@implementation ConfirmPapersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.showSheet = NO;
    self.lblTitle.text = self.lbTitleStr ;
    
    [self.view addSubview:self.sheetCollection];
    [self.sheetCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.showSheet ? self.listMdel.data.count + 2 : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section <= 1) {
        return 1;
    }else {
        if (self.listMdel.data[section - 2].showSheet) {
            return self.listMdel.data[section - 2].list.count;
        }
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        ConfirmPapersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ConfirmPapersCellIdentifier forIndexPath:indexPath];
        if (self.type==1) {
            //正确率
            if (self.listMdel.correctCount==0) {
                cell.correctValueLb.text = @"0%" ;
            } else {
                cell.correctValueLb.text = [NSString stringWithFormat:@"%.0f%%",(CGFloat)self.listMdel.correctCount/self.listMdel.finishCount*100];
            }
            
            [cell.timeUsedBtn setTitle:[NSString stringWithFormat:@" %@",self.listMdel.useTime] forState:UIControlStateNormal];
            [cell.timeAllBtn setTitle:[NSString stringWithFormat:@" %@",self.listMdel.allTime] forState:UIControlStateNormal];
            [cell.correctNumBtn setTitle:[NSString stringWithFormat:@" %zd",self.listMdel.correctCount] forState:UIControlStateNormal];
            [cell.allNumBtn1 setTitle:[NSString stringWithFormat:@" %zd",self.listMdel.allCount] forState:UIControlStateNormal];
            [cell.answeredNumBtn setTitle:[NSString stringWithFormat:@" %zd",self.listMdel.finishCount] forState:UIControlStateNormal];
            [cell.allNumBtn2 setTitle:[NSString stringWithFormat:@" %zd",self.listMdel.allCount] forState:UIControlStateNormal];
        } else {
            
            if (self.listMdel.correct_num.integerValue==0) {
                cell.correctValueLb.text = @"0%" ;
            } else {
                cell.correctValueLb.text = [NSString stringWithFormat:@"%.0f%%",(CGFloat)self.listMdel.correct_num.integerValue/self.listMdel.all_num.integerValue*100];
            }
            
            [cell.timeUsedBtn setTitle:[NSString stringWithFormat:@" %@",self.listMdel.useTime?:@""] forState:UIControlStateNormal];
            [cell.timeAllBtn setTitle:[NSString stringWithFormat:@" %@",self.listMdel.allTime?:@""] forState:UIControlStateNormal];
            [cell.correctNumBtn setTitle:[NSString stringWithFormat:@" %zd",self.listMdel.correct_num.integerValue] forState:UIControlStateNormal];
            [cell.allNumBtn1 setTitle:[NSString stringWithFormat:@" %@",self.listMdel.all_num?:@""] forState:UIControlStateNormal];
            [cell.answeredNumBtn setTitle:[NSString stringWithFormat:@" %zd",self.listMdel.all_num.integerValue-self.listMdel.notdone_num.integerValue] forState:UIControlStateNormal];
            [cell.allNumBtn2 setTitle:[NSString stringWithFormat:@" %zd",self.listMdel.all_num.integerValue] forState:UIControlStateNormal];
        }
       


        [[[cell.checkAnswerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            self.showSheet = !self.showSheet;
            [self.sheetCollection reloadData];
        }];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        AnswerSheetTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AnswerSheetTitleCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else
    {
        AnswerSheetCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AnswerSheetCollectionCellIdentifier forIndexPath:indexPath];
        
        TrainingListDataListModel *model = self.listMdel.data[indexPath.section - 2].list[indexPath.row];
        //1正确 2错误
        cell.noLb.backgroundColor = model.isAnswered == NO ? UR_ColorFromValue(0xFFFFFF) : [model.wrong integerValue] == 1 ? UR_ColorFromValue(0x59A2FF) : UR_ColorFromValue(0xFF6161) ;
        cell.noLb.textColor = model.isAnswered ? UR_ColorFromValue(0xFFFFFF) : UR_ColorFromValue(0x333333);
        cell.noLb.text = [NSString stringWithFormat:@"%zd",indexPath.row + 1];
        
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= 2 && kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SheetHederIdentifier forIndexPath:indexPath];
        
        UIButton *btn = [header viewWithTag: 100];
        
        if (btn == nil)
        {
            UIButton *btn = [UIButton backcolorBtnWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0xD2EAFF)];
            btn.layer.borderColor = UR_COLOR_LINE.CGColor;
            btn.layer.borderWidth = 0.5;
            
            [header addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 50 * AUTO_WIDTH));
                make.center.mas_equalTo(header);
            }];
            
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                TrainingListDataModel *model = self.listMdel.data[indexPath.section - 2];
                model.showSheet = !model.showSheet;
                [self.sheetCollection reloadData];
            }];
            
            [btn setTitle:[NSString stringWithFormat:@"第%zd部分",indexPath.section - 1] forState:UIControlStateNormal];
        }else{
            [btn setTitle:[NSString stringWithFormat:@"第%zd部分",indexPath.section - 1] forState:UIControlStateNormal];
        }
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(URScreenWidth(), 546 * AUTO_WIDTH);
    }else if (indexPath.section == 1) {
        return CGSizeMake(URScreenWidth(), 50 * AUTO_WIDTH);
    }else {
        return CGSizeMake(URScreenWidth()/5.0, URScreenWidth()/5.0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section >= 2) {
        return CGSizeMake(URScreenWidth(), 50);
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= 2)
    {
        TrainingListDataListModel *model = self.listMdel.data[indexPath.section - 2].list[indexPath.row];
        
        NSDictionary *dic = [model yy_modelToJSONObject];
        UnitPracticeDetailDataModel *pushModel = [UnitPracticeDetailDataModel yy_modelWithDictionary:dic];
        
        AnswerSheetSingleQuestionDetailVC *vc = [[AnswerSheetSingleQuestionDetailVC alloc] init];
        vc.unitQuestionModel = pushModel;
        [vc show];
    }
}

- (UICollectionView *)sheetCollection
{
    if (!_sheetCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _sheetCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _sheetCollection.delegate = self;
        _sheetCollection.dataSource = self;
        _sheetCollection.backgroundColor = [UIColor whiteColor];
        _sheetCollection.showsVerticalScrollIndicator = NO;
        _sheetCollection.showsHorizontalScrollIndicator = NO;
        
        [_sheetCollection registerClass:[AnswerSheetCollectionCell class] forCellWithReuseIdentifier:AnswerSheetCollectionCellIdentifier];
        [_sheetCollection registerClass:[ConfirmPapersCell class] forCellWithReuseIdentifier:ConfirmPapersCellIdentifier];
        [_sheetCollection registerClass:[AnswerSheetTitleCell class] forCellWithReuseIdentifier:AnswerSheetTitleCellIdentifier];

        [_sheetCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SheetHederIdentifier];

    }
    return _sheetCollection;
}

@end
