//
//  LiveSectionTextChatTableViewCell.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/17.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionTextChatTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView * personImageView;

@property (nonatomic,strong) UILabel * personInfor;

@property (nonatomic,strong) UIImageView * textChatBgImageView;

@property (nonatomic,strong) UILabel * textChatLabel;

@property (nonatomic,strong) LivePenetrateMsgModel * msgModel;

@end

NS_ASSUME_NONNULL_END
