//
//  FmousTeacherBroadcastCell.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FmousTeacherBroadcastCell : UITableViewCell

@property (nonatomic,strong) FmousTeacherBroadcastDataModel *model;

@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIButton *reservationButton;

@end

NS_ASSUME_NONNULL_END
