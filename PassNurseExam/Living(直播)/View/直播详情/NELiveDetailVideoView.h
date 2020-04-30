//
//  NELiveDetailVideoView.h
//  PassTheNurseExam
//
//  Created by Best on 2019/2/19.
//  Copyright © 2019 LeFu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"

///高度
#define NELiveDetailVideoViewH (ScreenWidth / 16.0 * 9.0)

NS_ASSUME_NONNULL_BEGIN

@interface NELiveDetailVideoView : UIView

@property (strong, nonatomic) SelVideoPlayer *videoView;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIImageView *videoImgView;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, copy) void(^playBlock)(void);



@end

NS_ASSUME_NONNULL_END
