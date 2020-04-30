//
//  WrongTopicCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WrongTopicCell : UITableViewCell

@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UIButton *wrongrateBtn;//错误率
@property (nonatomic,strong) UIButton *finishedNumberBtn;//几人已做
@property (nonatomic,strong) UIButton *collectBtn;//收藏

@end

NS_ASSUME_NONNULL_END
