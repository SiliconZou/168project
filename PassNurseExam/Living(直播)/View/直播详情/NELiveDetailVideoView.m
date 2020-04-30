//
//  NELiveDetailVideoView.m
//  PassTheNurseExam
//
//  Created by Best on 2019/2/19.
//  Copyright © 2019 LeFu. All rights reserved.
//

#import "NELiveDetailVideoView.h"

@implementation NELiveDetailVideoView

/** 播放按钮 */
- (UIButton *)playButton
{
	if (!_playButton){
		_playButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_playButton.frame = CGRectMake(0, 0, 50, 50);
		[_playButton setImage:[UIImage imageNamed:@"视频(1)"] forState:UIControlStateNormal];
		[_playButton addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _playButton;
}

- (UIImageView *)videoImgView
{
	if (!_videoImgView){
		_videoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news2"]];
	}
	return _videoImgView;
}

-(instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.videoView.frame = self.bounds;
		[self addSubview:self.videoView];
		[self addSubview:self.videoImgView];
		[self addSubview:self.playButton];
	}
	return self;
}

-(void)layoutSubviews {
	[super layoutSubviews];

	self.videoImgView.frame = self.bounds;
	self.playButton.center = CGPointMake(self.width / 2, self.height / 2);
}

- (void)playBtnClick:(id)sender {
	if (_playBlock) {
		_playBlock();
	}
}

#pragma mark - setter
-(void)setIsPlaying:(BOOL)isPlaying {
	_isPlaying = isPlaying;

    self.videoImgView.hidden = isPlaying;
    self.playButton.hidden = YES;
}

- (SelVideoPlayer *)videoView {
	if (!_videoView) {
		SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
		configuration.shouldAutoPlay = NO;     //自动播放
		configuration.supportedDoubleTap = NO;     //支持双击播放暂停
		configuration.shouldAutorotate = NO;   //自动旋转
		configuration.repeatPlay = NO;     //重复播放
		configuration.videoGravity = SelVideoGravityResizeAspect;   //拉伸方式
		configuration.isLive = YES;

		_videoView = [[SelVideoPlayer alloc] initWithFrame:CGRectZero configuration:configuration];

        @weakify(self);
		_videoView.finishBlock = ^{
            @strongify(self);
			self.isPlaying = NO;
		};

		_videoView.failBlock = ^{
            @strongify(self);

			self.isPlaying = NO;
		};

		_videoView.pauseBlock = ^{
            @strongify(self);

			self.isPlaying = NO;
		};
        
        _videoView.fullScreenChangedBlock = ^(BOOL isFullScreen) {
            @strongify(self);

            if (!isFullScreen) {
                [self sendSubviewToBack:self.videoView];
            }
        };

	}
	return _videoView;
}


@end
