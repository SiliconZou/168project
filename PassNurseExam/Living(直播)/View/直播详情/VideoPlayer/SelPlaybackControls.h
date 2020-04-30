//
//  SelBackControl.h
//  SelVideoPlayer
//
//  Created by zhuku on 2018/1/26.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelVideoSlider.h"
#import "SelPlayerConfiguration.h"

/** 播放器控制面板代理 */
@protocol SelPlaybackControlsDelegate <NSObject>

@required
/** 全屏切换按钮点击事件 */
- (void)fullScreenButtonAction;

@optional
/** 控制面板单击事件 */
- (void)tapGesture;

@end

@interface SelPlaybackControls : UIView

/** 底部控制栏 */
@property (nonatomic, strong)UIView *bottomControlsBar;
/** 全屏切换按钮 */
@property (nonatomic, strong) UIButton *fullScreenButton;
/** 播放器控制面板代理 */
@property (nonatomic, weak) id<SelPlaybackControlsDelegate> delegate;
/** 隐藏控制面板延时时间 缺省5s */
@property (nonatomic, assign) NSTimeInterval hideInterval;
/** 是否处于全屏状态 */
@property (nonatomic, assign) BOOL isFullScreen;
/** 全屏状态下状态栏显示方式 */
@property (nonatomic, assign) SelStatusBarHideState statusBarHideState;
/** 加载指示器 */
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
/** 直播页面，不能暂停 */
@property (nonatomic, assign) BOOL isLive;


/** 显示或隐藏控制面板 */
- (void)_playerShowOrHidePlaybackControls;
/** 显示或隐藏状态栏 */
- (void)_showOrHideStatusBar;
/** 取消延时隐藏playbackControls */
- (void)_playerCancelAutoHidePlaybackControls;
/** 延时自动隐藏控制面板 */
- (void)_playerAutoHidePlaybackControls;
/** 显示或隐藏加载指示器 */
- (void)_activityIndicatorViewShow:(BOOL)show;

@end
