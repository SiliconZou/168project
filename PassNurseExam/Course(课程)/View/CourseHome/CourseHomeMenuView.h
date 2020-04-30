//
//  CourseHomeMenuView.h
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseClassificationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseHomeMenuViewCollectionCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *sline;

@end

@interface CourseMenuTwoViewCollectionCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *sline;

@end

@interface CourseHomeMenuView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *menu1;
@property (nonatomic,strong) UICollectionView *menu2;

@property (nonatomic,strong) NSArray *menuArr; ;

@property (nonatomic,assign) NSInteger menu1Index;
@property (nonatomic,assign) NSInteger menu2Index;

@property (nonatomic,copy) void (^selectMenuBlcok) (id menu1Model, id menu2Model);

@end

NS_ASSUME_NONNULL_END
