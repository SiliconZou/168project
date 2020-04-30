//
//  UnitPracticeDetailImgOrVideoCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/20.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnitPracticeDetailImgOrVideoCell : UITableViewCell


//图片题
@property (nonatomic,strong) UIImageView *picImgView;

//赋值：图片地址
@property (nonatomic, copy) NSString *currentPicURL;

//视频题
@property (nonatomic,strong) UIButton *playBtn;//播放按钮
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;//占位图
@property (nonatomic, strong) ZFPlayerControlView *controlView;

//赋值：视频地址
@property (nonatomic, copy) NSString *currentPlayURL;
//控制VC 
@property (nonatomic,strong) UIViewController *currentViewControlller;


@end

NS_ASSUME_NONNULL_END
