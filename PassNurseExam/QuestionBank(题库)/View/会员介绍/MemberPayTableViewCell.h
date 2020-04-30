//
//  MemberPayTableViewCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/25.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberPayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *iconTitle;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;
@end

NS_ASSUME_NONNULL_END
