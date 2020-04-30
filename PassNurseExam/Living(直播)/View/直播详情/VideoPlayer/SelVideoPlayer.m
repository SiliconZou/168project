    //
//  SelVideoPlayer.m
//  SelVideoPlayer
//
//  Created by zhuku on 2018/1/26.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SelVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "SelPlayerConfiguration.h"
#import "SelPlaybackControls.h"

/** 播放器的播放状态 */
typedef NS_ENUM(NSInteger, SelVideoPlayerState) {
    SelVideoPlayerStateFailed,     // 播放失败
    SelVideoPlayerStateBuffering,  // 缓冲中
    SelVideoPlayerStatePlaying,    // 播放中
    SelVideoPlayerStatePause,      // 暂停播放
};

@interface SelVideoPlayer()<SelPlaybackControlsDelegate>

@property (nonatomic, strong) AliVcMediaPlayer *mediaPlayer;
@property (nonatomic, strong) UIView *videoView;

/** 是否播放完毕 */
@property (nonatomic, assign) BOOL isFinish;
/** 是否处于全屏状态 */
@property (nonatomic, assign) BOOL isFullScreen;
/** 播放器配置信息 */
@property (nonatomic, strong) SelPlayerConfiguration *playerConfiguration;
/** 视频播放控制面板 */
@property (nonatomic, strong) SelPlaybackControls *playbackControls;
/** 非全屏状态下播放器 superview */
@property (nonatomic, strong) UIView *originalSuperview;
/** 非全屏状态下播放器 frame */
@property (nonatomic, assign) CGRect originalRect;
/** 时间监听器 */
@property (nonatomic, strong) id timeObserve;
/** 播放器的播放状态 */
@property (nonatomic, assign) SelVideoPlayerState playerState;
/** 是否结束播放 */
@property (nonatomic, assign) BOOL playDidEnd;

@end

@implementation SelVideoPlayer

/**
 初始化播放器
 @param configuration 播放器配置信息
 */
- (instancetype)initWithFrame:(CGRect)frame configuration:(SelPlayerConfiguration *)configuration
{
    self = [super initWithFrame:frame];
    if (self) {
		[self addObserver];

        _playerConfiguration = configuration;
        [self _setupPlayer];
        [self _setupPlayControls];

    }
    return self;
}

-(void)bindVideoUrl:(NSURL *)videoUrl {
	self.playerConfiguration.sourceUrl = videoUrl;

	[self.mediaPlayer prepareToPlay:videoUrl];
}

/** 屏幕翻转监听事件 */
- (void)orientationChanged:(NSNotification *)notify
{
    if (_playerConfiguration.shouldAutorotate) {
        [self orientationAspect];
    }
}

/** 根据屏幕旋转方向改变当前视频屏幕状态 */
- (void)orientationAspect
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft){
        if (!_isFullScreen){
           [self _videoZoomInWithDirection:UIInterfaceOrientationLandscapeRight];
        }
    }
    else if (orientation == UIDeviceOrientationLandscapeRight){
        if (!_isFullScreen){
           [self _videoZoomInWithDirection:UIInterfaceOrientationLandscapeLeft];
        }
    }
    else if(orientation == UIDeviceOrientationPortrait){
        if (_isFullScreen){
            [self _videoZoomOut];
        }
    }
}

/**
 视频放大全屏幕
 @param orientation 旋转方向
 */
- (void)_videoZoomInWithDirection:(UIInterfaceOrientation)orientation
{
    _originalSuperview = self.superview;
    _originalRect = self.frame;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    
    [UIView animateWithDuration:duration animations:^{
        if (orientation == UIInterfaceOrientationLandscapeLeft){
            self.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }else if (orientation == UIInterfaceOrientationLandscapeRight) {
            self.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
    }completion:^(BOOL finished) {
        
    }];
    
    self.frame = keyWindow.bounds;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.isFullScreen = YES;
    //显示或隐藏状态栏
    [self.playbackControls _showOrHideStatusBar];
}

/** 视频退出全屏幕 */
- (void)_videoZoomOut
{
    //退出全屏时强制取消隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
    }completion:^(BOOL finished) {
        
    }];
    self.frame = _originalRect;
    [_originalSuperview addSubview:self];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.isFullScreen = NO;
}

/** 播放视频 */
- (void)_playVideo
{
    if (self.playDidEnd) {
        //若播放已结束重新播放
        [self _replayVideo];
    }else
    {
        [self.mediaPlayer play];
        if (self.playerState == SelVideoPlayerStatePause) {
            self.playerState = SelVideoPlayerStatePlaying;
        }
    }
}

/** 暂停播放 */
- (void)_pauseVideo
{
    [self.mediaPlayer pause];
    if (self.playerState == SelVideoPlayerStatePlaying) {
        self.playerState = SelVideoPlayerStatePause;
    }
}

/** 重新播放 */
- (void)_replayVideo
{
    self.playDidEnd = NO;
	[self.mediaPlayer seekTo:0];
//    [_player seekToTime:CMTimeMake(0, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self _playVideo];
}


- (void)addObserver{
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(appDidEnterBackground:)
												 name:UIApplicationWillResignActiveNotification
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(appDidEnterPlayground:)
												 name:UIApplicationDidBecomeActiveNotification
											   object:nil];
	
	//一、播放器初始化视频文件完成通知，调用prepareToPlay函数，会发送该通知，代表视频文件已经准备完成，此时可以在这个通知中获取到视频的相关信息，如视频分辨率，视频时长等
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(OnVideoPrepared:)
												 name:AliVcMediaPlayerLoadDidPreparedNotification object:self.mediaPlayer];
	//二、播放完成通知。视频正常播放完成时触发。
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(OnVideoFinish:)
												 name:AliVcMediaPlayerPlaybackDidFinishNotification object:self.mediaPlayer];

	//三、播放器播放失败发送该通知，并在该通知中可以获取到错误码。
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(OnVideoError:)
												 name:AliVcMediaPlayerPlaybackErrorNotification object:self.mediaPlayer];


	//五、播放器开始缓冲视频时发送该通知，当播放网络文件时，网络状态不佳或者调用seekTo时，此通知告诉用户网络下载数据已经开始缓冲。
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(OnStartCache:)
												 name:AliVcMediaPlayerStartCachingNotification object:self.mediaPlayer];

	//七、播放器主动调用Stop功能时触发。
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(onVideoStop:)
												 name:AliVcMediaPlayerPlaybackStopNotification object:self.mediaPlayer];

}

- (void)OnVideoPrepared:(NSNotification *)noti {
	NSLog(@"\n>>>>>>>>OnVideoPrepared>>>>>>>>>>\n%@\n<<<<<<<<<<<<<<<<<<",noti.userInfo);
	self.playerState = SelVideoPlayerStatePlaying;
}

- (void)OnVideoError:(NSNotification *)noti {
	NSLog(@"\n>>>>>>>>OnVideoError>>>>>>>>>>\n%@\n<<<<<<<<<<<<<<<<<<",noti.userInfo);
    
    [URToastHelper   showErrorWithStatus:@"视频直播还未开始或者资源出错！"] ;
    self.playerState = SelVideoPlayerStateFailed;
}

- (void)OnStartCache:(NSNotification *)noti {
	NSLog(@"\n>>>>>>>>OnStartCache>>>>>>>>>>\n%@\n<<<<<<<<<<<<<<<<<<",noti.userInfo);
    [URToastHelper   showErrorWithStatus:@"视频缓冲中"] ;

}

- (void)OnVideoFinish:(NSNotification *)noti
{
	NSLog(@"\n>>>>>>>>OnVideoFinish>>>>>>>>>>\n%@\n<<<<<<<<<<<<<<<<<<",noti.userInfo);
    [URToastHelper   showErrorWithStatus:@"视频直播已结束"] ;

	self.playDidEnd = YES;
	if (_playerConfiguration.repeatPlay) {
		[self _replayVideo];
	}else
	{
		[self _pauseVideo];
	}

	if (_finishBlock) {
		_finishBlock();
	}
}

- (void)onVideoStop:(NSNotification *)noti
{
	NSLog(@"\n>>>>>>>>OnVideoFinish>>>>>>>>>>\n%@\n<<<<<<<<<<<<<<<<<<",noti.userInfo);
    [URToastHelper   showErrorWithStatus:@"视频直播已停止"] ;

	if (_stopBlock) {
		_stopBlock();
	}
}

/** 应用进入后台 */
- (void)appDidEnterBackground:(NSNotification *)notify
{
    [self _pauseVideo];
}

/** 应用进入前台 */
- (void)appDidEnterPlayground:(NSNotification *)notify
{
    
}

/** 创建播放器 以及控制面板*/
- (void)_setupPlayer
{
	if (_playerConfiguration.sourceUrl) {
		[self.mediaPlayer prepareToPlay:_playerConfiguration.sourceUrl];
	}
    [self _setVideoGravity:_playerConfiguration.videoGravity];
    self.backgroundColor = [UIColor blackColor];

    if (_playerConfiguration.shouldAutoPlay) {
        [self _playVideo];
    }

}


/** 添加播放器控制面板 */
- (void)_setupPlayControls
{
	[self addSubview:self.videoView];
    [self addSubview:self.playbackControls];
}

/**
 配置playerLayer拉伸方式
 @param videoGravity 拉伸方式
 */
- (void)_setVideoGravity:(SelVideoGravity)videoGravity
{
    NSString *fillMode = AVLayerVideoGravityResize;
    switch (videoGravity) {
        case SelVideoGravityResize:
            fillMode = AVLayerVideoGravityResize;
            break;
        case SelVideoGravityResizeAspect:
            fillMode = AVLayerVideoGravityResizeAspect;
            break;
        case SelVideoGravityResizeAspectFill:
            fillMode = AVLayerVideoGravityResizeAspectFill;
            break;
        default:
            break;
    }
//    self.mediaPlayer.scalingMode = scalingModeAspectFit;
}


/**
 @param playerState 播放器的播放状态
 */
- (void)setPlayerState:(SelVideoPlayerState)playerState
{
    _playerState = playerState;
    switch (_playerState) {
        case SelVideoPlayerStateBuffering:
        {
            [_playbackControls _activityIndicatorViewShow:YES];
        }
            break;
        case SelVideoPlayerStatePlaying:
        {
            [_playbackControls _activityIndicatorViewShow:NO];
        }
            break;
        case SelVideoPlayerStateFailed:
        {
			if (_failBlock) {
				_failBlock();
			}
            [_playbackControls _activityIndicatorViewShow:NO];
		}
			break;

		case SelVideoPlayerStatePause: {
				if (_pauseBlock) {
					_pauseBlock();
				}
			[self _videoZoomOut];
			}
            break;
        default:
            break;
    }
}

/** 改变全屏切换按钮状态 */
- (void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    _playbackControls.isFullScreen = isFullScreen;
    
    if (_fullScreenChangedBlock) {
        _fullScreenChangedBlock(_isFullScreen);
    }
}

/** 播放器控制面板 */
- (SelPlaybackControls *)playbackControls
{
    if (!_playbackControls) {
        _playbackControls = [[SelPlaybackControls alloc]init];
        _playbackControls.delegate = self;
        _playbackControls.hideInterval = _playerConfiguration.hideControlsInterval;
        _playbackControls.statusBarHideState = _playerConfiguration.statusBarHideState;
		_playbackControls.isLive = self.playerConfiguration.isLive;
    }
    return _playbackControls;
}


-(UIView *)videoView {
	if (!_videoView) {
		_videoView = [[UIView alloc] init];
		_videoView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
	}
	return _videoView;
}

-(AliVcMediaPlayer *)mediaPlayer {
	if (!_mediaPlayer) {
		_mediaPlayer = [[AliVcMediaPlayer alloc] init];
		[_mediaPlayer create:self.videoView];

		//		_mediaPlayer.mediaType = MediaType_LIVE;
		_mediaPlayer.mediaType = MediaType_AUTO;
		_mediaPlayer.timeout = 25000;
		_mediaPlayer.dropBufferDuration = 8000;
	}
	return _mediaPlayer;
}

- (void)layoutSubviews{
    [super layoutSubviews];

	self.videoView.frame = self.bounds;
//    self.playerLayer.frame = self.bounds;
    self.playbackControls.frame = self.bounds;
}

/** 释放播放器 */
- (void)_deallocPlayer
{
    [self _pauseVideo];
    
//    [self.playerLayer removeFromSuperlayer];
    [self removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

/** 释放Self */
- (void)dealloc
{
    [self.playbackControls _playerCancelAutoHidePlaybackControls];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
	[self.mediaPlayer destroy];
}

#pragma mark 播放器控制面板代理
/**
 播放按钮点击事件
 @param selected 播放按钮选中状态
 */
- (void)playButtonAction:(BOOL)selected
{
    if (selected){
        [self _pauseVideo];
    }else{
        [self _playVideo];
    }
}

/** 全屏切换按钮点击事件 */
- (void)fullScreenButtonAction
{
    if (!_isFullScreen) {
        [self _videoZoomInWithDirection:UIInterfaceOrientationLandscapeRight];
    }else
    {
        [self _videoZoomOut];
    }
}

/** 控制面板单击事件 */
- (void)tapGesture
{
    [_playbackControls _playerShowOrHidePlaybackControls];
}

/** 控制面板双击事件 */
- (void)doubleTapGesture
{
    if (_playerConfiguration.supportedDoubleTap) {
        if (self.playerState == SelVideoPlayerStatePlaying) {
            [self _pauseVideo];
        }
        else if (self.playerState == SelVideoPlayerStatePause)
        {
            [self _playVideo];
        }
    }
}

/** 重新加载视频 */
- (void)retryButtonAction
{
    [_playbackControls _activityIndicatorViewShow:YES];
    [self _setupPlayer];
    [self _playVideo];
}


@end
