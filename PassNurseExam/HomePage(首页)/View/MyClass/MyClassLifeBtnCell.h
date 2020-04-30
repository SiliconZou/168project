//
//  MyClassLifeBtnCell.h
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClassLifeBtnCell : UITableViewCell

@property (nonatomic,strong) UIView *contentBgView;//背景
@property (nonatomic,strong) UIButton *zanBtn;//点赞
@property (nonatomic,strong) UIButton *commentBtn;//评论

@end

NS_ASSUME_NONNULL_END
