//
//  MyClassLifeTopCell.h
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClassLifeTopCell : UITableViewCell


@property (nonatomic,strong) UIImageView *header;//头像
@property (nonatomic,strong) UIImageView *userVip;//vip角标
@property (nonatomic,strong) UILabel *nameLb;//名称
@property (nonatomic,strong) UIImageView *vipLevel;//vip等级
@property (nonatomic,strong) UILabel *timeLb;//时间
@property (nonatomic,strong) UILabel *contentLb;//发表的内容


@end

NS_ASSUME_NONNULL_END
