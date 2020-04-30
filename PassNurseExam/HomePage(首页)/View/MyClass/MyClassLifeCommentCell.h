//
//  MyClassLifeCommentCell.h
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClassLifeCommentCell : UITableViewCell

@property (nonatomic,strong) UIView *contentBgView;//背景
@property (nonatomic,strong) UIImageView *plImg;
@property (nonatomic,strong) UILabel *commentLb;//评论内容
@property (nonatomic,strong) UIButton *checkMoreBtn;//查看更多

@end

NS_ASSUME_NONNULL_END
