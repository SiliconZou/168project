//
//  CourseHomeMenuView.m
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "CourseHomeMenuView.h"

@implementation CourseHomeMenuViewCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.sline];

        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_greaterThanOrEqualTo(5);
            make.right.mas_lessThanOrEqualTo(-5);
            make.center.mas_equalTo(self.contentView);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(self.name).mas_offset(10);
            make.bottom.mas_equalTo(self.name).mas_offset(4);
            make.height.mas_equalTo(3 * AUTO_WIDTH);
            make.width.mas_equalTo(28 * AUTO_WIDTH);
            make.centerX.mas_equalTo(self.name);
        }];
        [self.sline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(0.5, 18 * AUTO_WIDTH));
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel *)name
{
    if (!_name) {
        _name = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentCenter numberLines:2];
        _name.adjustsFontSizeToFitWidth = YES;
    }
    return _name;
}
- (UIView *)line
{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = UR_ColorFromValue(0xFF6D58);
    }
    return _line;
}

- (UIView *)sline
{
    if (!_sline) {
        _sline = [UIView new];
        _sline.backgroundColor = UR_COLOR_LINE;
    }
    return _sline;
}

@end
@implementation CourseMenuTwoViewCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.sline];

        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(5);
            make.right.mas_equalTo(self.contentView).mas_offset(-5);
            make.center.mas_equalTo(self.contentView);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(self.name).mas_offset(10);
            make.bottom.mas_equalTo(self.name).mas_offset(4);
            make.height.mas_equalTo(3 * AUTO_WIDTH);
            make.width.mas_equalTo(28 * AUTO_WIDTH);
            make.centerX.mas_equalTo(self.name);
        }];
        [self.sline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(0.5, 18 * AUTO_WIDTH));
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel *)name
{
    if (!_name) {
        _name = [UILabel normalLabelWithTitle:@"" titleColor:[UIColor whiteColor] font:RegularFont(FontSize16) textAlignment:NSTextAlignmentCenter numberLines:2];
        _name.backgroundColor = NORMAL_COLOR;
        _name.adjustsFontSizeToFitWidth = YES;
    }
    return _name;
}
- (UIView *)line
{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = UR_ColorFromValue(0xFF6D58);
    }
    return _line;
}

- (UIView *)sline
{
    if (!_sline) {
        _sline = [UIView new];
        _sline.backgroundColor = UR_COLOR_LINE;
    }
    return _sline;
}

@end

static NSString * const CourseHomeMenuViewCollectionCellIdentifier = @"CourseHomeMenuViewCollectionCellIdentifier";
static NSString * const CourseMenuTwoViewCollectionCellIdentifier = @"CourseMenuViewCollectionCellIdentifier";
@implementation CourseHomeMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.menu1Index = self.menu2Index = 0;
        [self createUI];
    }
    return self;
}

- (void)setMenuArr:(NSArray *)menuArr
{
    _menuArr = menuArr;
    [self.menu1 reloadData];
    [self.menu2 reloadData];
    
    if ([menuArr[self.menu1Index]  isKindOfClass:[CourseClassificationDataModel class]]) {
        CourseClassificationDataModel *menu1Model = menuArr[self.menu1Index];
        self.menu2.hidden = menu1Model.courses.count == 0 ? YES : NO;
        
    } else if ([menuArr[self.menu1Index]  isKindOfClass:[QuestionClassificationTitleModel class]]) {
        QuestionClassificationTitleModel *menu1Model = menuArr[self.menu1Index];
        self.menu2.hidden = menu1Model.subjects.count == 0 ? YES : NO;
        
    } else if ([menuArr[self.menu1Index]  isKindOfClass:[LiveClassificationDataModel class]]) {
        LiveClassificationDataModel *menu1Model = self.menuArr[self.menu1Index];
        self.menu2.hidden = menu1Model.courses.count == 0 ? YES : NO;
    }
}


- (void)createUI
{
    self.backgroundColor = UR_COLOR_BACKGROUND_ALL;
    
    [self addSubview:self.menu1];
    [self addSubview:self.menu2];
    [self.menu1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(50 * AUTO_WIDTH);
    }];
    [self.menu2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.menu1.mas_bottom).offset(1);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(50 * AUTO_WIDTH);
    }];
    
    UILabel * bottomView = [[UILabel  alloc] init];
    bottomView.backgroundColor = [UIColor clearColor] ;
    [self  addSubview:bottomView];
    [bottomView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(self.menu2.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 3));
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.menu1) {
        return self.menuArr.count;
    }
    
    if ([self.menuArr[self.menu1Index]  isKindOfClass:[CourseClassificationDataModel class]]) {
        CourseClassificationDataModel *menu1Model = self.menuArr[self.menu1Index];
        return menu1Model.courses.count;
        
    } else  if ([self.menuArr[self.menu1Index]  isKindOfClass:[QuestionClassificationTitleModel class]]) {
       QuestionClassificationTitleModel *menu1Model = self.menuArr[self.menu1Index];
       return menu1Model.subjects.count ;
        
    }else if ([self.menuArr[self.menu1Index]  isKindOfClass:[LiveClassificationDataModel class]]) {
        LiveClassificationDataModel *menu1Model = self.menuArr[self.menu1Index];
        return menu1Model.courses.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (collectionView == self.menu1)
    {
        CourseHomeMenuViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CourseHomeMenuViewCollectionCellIdentifier forIndexPath:indexPath];
        CourseClassificationDataModel *menu1Model = self.menuArr[indexPath.row];
        cell.name.text = menu1Model.name;
        cell.line.hidden = !(self.menu1Index == indexPath.row);
        return cell;
    }else
    {
        CourseMenuTwoViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CourseMenuTwoViewCollectionCellIdentifier forIndexPath:indexPath];
        cell.name.font = RegularFont(FontSize14);
        cell.line.hidden = YES;//!(self.menu2Index == indexPath.row);
        cell.name.backgroundColor = self.menu2Index == indexPath.row ? NORMAL_COLOR : [UIColor whiteColor];
        cell.name.textColor = self.menu2Index == indexPath.row ? [UIColor whiteColor] : [UIColor blackColor];
        if ([self.menuArr[self.menu1Index]  isKindOfClass:[CourseClassificationDataModel class]])
        {
            CourseClassificationDataModel *menu1Model = self.menuArr[self.menu1Index];
            CourseClassificationCoursesModel *menu2Model = menu1Model.courses[indexPath.row];
            cell.name.text = menu2Model.name;
//            cell.name.font = RegularFont(FontSize14);
//            cell.line.hidden = YES;//!(self.menu2Index == indexPath.row);
//            cell.name.backgroundColor = self.menu2Index == indexPath.row ? NORMAL_COLOR : [UIColor whiteColor];
//            cell.name.textColor = self.menu2Index == indexPath.row ? [UIColor whiteColor] : [UIColor blackColor];
        }
        else  if ([self.menuArr[self.menu1Index]  isKindOfClass:[QuestionClassificationTitleModel class]])
        {
            QuestionClassificationTitleModel *menu1Model = self.menuArr[self.menu1Index];
            QuestionClassificationSubTitleModel *menu2Model = menu1Model.subjects[indexPath.row];
            cell.name.text = menu2Model.name;
//            cell.name.font = RegularFont(FontSize14);
//            cell.line.hidden = YES;//!(self.menu2Index == indexPath.row);
//            cell.name.backgroundColor = self.menu2Index == indexPath.row ? NORMAL_COLOR : [UIColor whiteColor];
//            cell.name.textColor = self.menu2Index == indexPath.row ? [UIColor whiteColor] : [UIColor blackColor];
        }
        else if ([self.menuArr[self.menu1Index]  isKindOfClass:[LiveClassificationDataModel class]])
        {
            LiveClassificationDataModel *menu1Model = self.menuArr[self.menu1Index];
            LiveClassificationCoursesModel *menu2Model = menu1Model.courses[indexPath.row];
            cell.name.text = menu2Model.name;
//            cell.name.font = RegularFont(FontSize14);
//            cell.line.hidden = YES;//!(self.menu2Index == indexPath.row);
//            cell.name.backgroundColor = self.menu2Index == indexPath.row ? NORMAL_COLOR : [UIColor whiteColor];
//            cell.name.textColor = self.menu2Index == indexPath.row ? [UIColor whiteColor] : [UIColor blackColor];
            
        }
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.menu1)
    {
        self.menu1Index = indexPath.row;
        self.menu2Index = 0;
        [self.menu1 reloadData];
        [self.menu2 reloadData];
//        [self.menu1 scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        [self.menu1 setContentOffset:CGPointMake(URScreenWidth()/3.5 * indexPath.row, 0) animated:NO];
    }else
    {
        self.menu2Index = indexPath.row;
        [self.menu2 reloadData];
        [self.menu2 setContentOffset:CGPointMake(URScreenWidth()/3.5 * indexPath.row, 0) animated:NO];
    }
    
    if ([self.menuArr[self.menu1Index]  isKindOfClass:[CourseClassificationDataModel class]]) {
        CourseClassificationDataModel *menu1Model = self.menuArr[self.menu1Index];
        CourseClassificationCoursesModel *menu2Model = nil;
        
        if (menu1Model.courses.count > 0) {
            menu2Model = menu1Model.courses[self.menu2Index];
        }
        
        if (self.selectMenuBlcok) {
            self.selectMenuBlcok(menu1Model, menu2Model);
        }
        
    } else if ([self.menuArr[self.menu1Index]  isKindOfClass:[QuestionClassificationTitleModel class]]){
        QuestionClassificationTitleModel *menu1Model = self.menuArr[self.menu1Index];
        
        QuestionClassificationSubTitleModel *menu2Model = nil;
        
        if (menu1Model.subjects.count > 0) {
            
            menu2Model = menu1Model.subjects[self.menu2Index];
        }
        
        if (self.selectMenuBlcok) {
            self.selectMenuBlcok(menu1Model, menu2Model);
        }
    } else if ([self.menuArr[self.menu1Index]  isKindOfClass:[LiveClassificationDataModel class]]){
        LiveClassificationDataModel *menu1Model = self.menuArr[self.menu1Index];
        
        LiveClassificationCoursesModel *menu2Model = nil;
        
        if (menu1Model.courses.count > 0) {
            
            menu2Model = menu1Model.courses[self.menu2Index];
        }
        
        if (self.selectMenuBlcok) {
            self.selectMenuBlcok(menu1Model, menu2Model);
        }
    }
}

- (UICollectionView *)menu1
{
    if (!_menu1) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(URScreenWidth()/3.0, 50 * AUTO_WIDTH);
//        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _menu1 = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _menu1.backgroundColor = [UIColor whiteColor];
        _menu1.delegate = self;
        _menu1.dataSource = self;
        _menu1.showsHorizontalScrollIndicator = NO;
        [_menu1 registerClass:[CourseHomeMenuViewCollectionCell class] forCellWithReuseIdentifier:CourseHomeMenuViewCollectionCellIdentifier];
    }
    return _menu1;
}

- (UICollectionView *)menu2
{
    if (!_menu2) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(URScreenWidth()/2.5, 50 * AUTO_WIDTH);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _menu2 = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _menu2.backgroundColor = [UIColor whiteColor];
        _menu2.delegate = self;
        _menu2.dataSource = self;
        _menu2.showsHorizontalScrollIndicator = NO;
        [_menu2 registerClass:[CourseMenuTwoViewCollectionCell class] forCellWithReuseIdentifier:CourseMenuTwoViewCollectionCellIdentifier];
    }
    return _menu2;
}


@end
