//
//  SelBackControl.m
//  SelVideoPlayer
//
//  Created by zhuku on 2018/1/26.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SelPlaybackControls.h"
#import <Masonry.h>

static const CGFloat PlaybackControlsAutoHideTimeInterval = 0.3f;
@interface SelPlaybackControls()

/** 控制面板是否显示 */
@property (nonatomic, assign) BOOL isShowing;
/** 加载指示器是否显示 */
@property (nonatomic, assign) BOOL isActivityShowing;
/** 重新加载是否显示 */
@property (nonatomic, assign) BOOL isRetryShowing;
/** 播放或暂停 */
@property (nonatomic, assign) BOOL isSelected;


@end

@implementation SelPlaybackControls

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


/** 重置控制面板 */
- (void)_resetPlaybackControls
{
    self.bottomControlsBar.alpha = 0;
    self.isShowing = NO;
    [self _activityIndicatorViewShow:YES];
}

/** 显示或隐藏加载指示器 */
- (void)_activityIndicatorViewShow:(BOOL)show
{
    self.isActivityShowing = show;
    if (show) {
        [self.activityIndicatorView startAnimating];
    }
    else
    {
        [self.activityIndicatorView stopAnimating];
    }
}

/** 显示或隐藏控制面板 */
- (void)_playerShowOrHidePlaybackControls
{
    if (self.isShowing) {
        [self _playerHidePlaybackControls];
    } else {
        [self _playerShowPlaybackControls];
    }
}

/** 显示控制面板 */
- (void)_playerShowPlaybackControls
{
    [self _playerCancelAutoHidePlaybackControls];
    [UIView animateWithDuration:PlaybackControlsAutoHideTimeInterval animations:^{
        [self _showPlaybackControls];
    } completion:^(BOOL finished) {
        self.isShowing = YES;
        [self _playerAutoHidePlaybackControls];
    }];
}

/** 隐藏控制面板 */
- (void)_playerHidePlaybackControls
{
    [self _playerCancelAutoHidePlaybackControls];
    [UIView animateWithDuration:PlaybackControlsAutoHideTimeInterval animations:^{
        [self _hidePlaybackControls];
    } completion:^(BOOL finished) {
        self.isShowing = NO;
    }];
}

/** 显示控制面板 */
- (void)_showPlaybackControls
{
    self.isShowing = YES;
    self.bottomControlsBar.alpha = 1;
    [self _showOrHideStatusBar];
}

/** 隐藏控制面板 */
- (void)_hidePlaybackControls
{
    self.isShowing = NO;
    self.bottomControlsBar.alpha = 0;
    if (self.isFullScreen) {
        [self _showOrHideStatusBar];
    }
}

/** 延时自动隐藏控制面板 */
- (void)_playerAutoHidePlaybackControls
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_playerHidePlaybackControls) object:nil];
    [self performSelector:@selector(_playerHidePlaybackControls) withObject:nil afterDelay:_hideInterval];
}

/** 显示或隐藏状态栏 */
- (void)_showOrHideStatusBar
{
    switch (_statusBarHideState) {
        case SelStatusBarHideStateFollowControls:
        {
            [[UIApplication sharedApplication] setStatusBarHidden:!self.isShowing];
        }
            break;
        case SelStatusBarHideStateNever:
        {
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
        }
            break;
        case SelStatusBarHideStateAlways:
        {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }
            break;
        default:
            break;
    }
}

/** 是否处于全屏状态 */
- (void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    self.fullScreenButton.selected = _isFullScreen;
}

/** 取消延时隐藏playbackControls */
- (void)_playerCancelAutoHidePlaybackControls
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

/** 创建UI */
- (void)setupUI
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomControlsBar];
    [self addSubview:self.activityIndicatorView];

    [_bottomControlsBar addSubview:self.fullScreenButton];
    
    [self makeConstraints];
    [self _resetPlaybackControls];
    [self addGesture];
}

/** 添加手势 */
- (void)addGesture
{
    //单击手势
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:singleTapGesture];

}

/** 添加约束 */
- (void)makeConstraints
{

    @weakify(self);
    [_bottomControlsBar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@50);
    }];
    
    [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);

        make.center.equalTo(self);
    }];

	[_fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
		make.right.bottom.equalTo(self.bottomControlsBar).offset(-10);
		make.width.height.equalTo(@40);
	}];

}

/** 加载指示器 */
- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityIndicatorView;
}

/** 底部控制栏 */
- (UIView *)bottomControlsBar
{
    if (!_bottomControlsBar) {
        _bottomControlsBar = [[UIView alloc]init];
        _bottomControlsBar.userInteractionEnabled = YES;
    }
    return _bottomControlsBar;
}

/** 全屏切换按钮 */
- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"全屏(1)"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"最小化"] forState:UIControlStateSelected];
        [_fullScreenButton addTarget:self action:@selector(fullScreenAction) forControlEvents:UIControlEventTouchUpInside];

		_fullScreenButton.clipsToBounds = YES;
		_fullScreenButton.layer.cornerRadius = 20.0;
		_fullScreenButton.backgroundColor = UIColor.lightGrayColor;
    }
    return _fullScreenButton;
}

/** 全屏切换按钮点击事件 */
- (void)fullScreenAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(fullScreenButtonAction)]) {
        [_delegate fullScreenButtonAction];
    }
}


/** 控制面板单击事件 */
- (void)tap:(UIGestureRecognizer *)gesture
{
	if (_delegate && [_delegate respondsToSelector:@selector(tapGesture)]) {
		[_delegate tapGesture];
	}
}

@end
