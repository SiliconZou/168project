//
//  MyClassLifeImgCell.h
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClassLifeImgCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collection;

@property (nonatomic,strong) NSArray *imgsArr;

@end

NS_ASSUME_NONNULL_END
