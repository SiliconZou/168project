//
//  LiveSectionMenuCell.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionMenuCell : UITableViewCell

@property (nonatomic,strong) RACSubject *menuSubject;

@end

NS_ASSUME_NONNULL_END
