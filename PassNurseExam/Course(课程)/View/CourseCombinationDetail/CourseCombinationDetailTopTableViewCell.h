//
//  CourseCombinationDetailTopTableViewCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseCombinationDetailTopTableViewCell : UITableViewCell

@property (nonatomic,strong) id dataModel;

@property (weak, nonatomic) IBOutlet UIButton *directionButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

NS_ASSUME_NONNULL_END
