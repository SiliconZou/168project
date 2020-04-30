//
//  FamousTeacherBroadcastCollectionViewCell.h
//  PassNurseExam
//
//  Created by quchao on 2019/10/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FamousTeacherBroadcastCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) id model;
@property (weak, nonatomic) IBOutlet UIButton *reservationButton;
@property (weak, nonatomic) IBOutlet UIImageView *reserve;


@end

NS_ASSUME_NONNULL_END
