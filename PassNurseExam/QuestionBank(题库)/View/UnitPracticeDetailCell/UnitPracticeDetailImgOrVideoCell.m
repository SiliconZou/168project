//
//  UnitPracticeDetailImgOrVideoCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/20.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeDetailImgOrVideoCell.h"

@implementation UnitPracticeDetailImgOrVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        
        [self setupPlayer] ;

    }
    return  self;
}

- (void)createUI
{
    [self.contentView addSubview:self.picImgView];
    
    [self.contentView  addSubview:self.containerView];
    [self.containerView addSubview:self.playBtn];
    
    [self.picImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-15 * AUTO_WIDTH);
        make.top.mas_offset(0);
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.height.mas_equalTo(200 * AUTO_WIDTH);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-15 * AUTO_WIDTH);
        make.top.mas_offset(0);
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
        make.height.mas_equalTo(200 * AUTO_WIDTH);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60 * AUTO_WIDTH, 60 * AUTO_WIDTH));
        make.center.mas_equalTo(self.containerView);
    }];
}

#pragma mark 赋值

//图片题
- (void)setCurrentPicURL:(NSString *)currentPicURL
{
    _currentPicURL = currentPicURL;
    
    self.picImgView.hidden = NO;
    self.containerView.hidden = YES;

    [self.picImgView sd_setImageWithURL:[NSURL  URLWithString:currentPicURL] placeholderImage:[UIImage imageNamed:@"news2"]];
}

//视频题
- (void)setCurrentPlayURL:(NSString *)currentPlayURL
{
    _currentPlayURL = currentPlayURL;
    
    self.picImgView.hidden = YES;
    self.containerView.hidden = NO;
    
    [self.containerView setImageWithURLString:currentPlayURL?:@"" placeholder:[UIImage firstFrameWithVideoURL:[NSURL URLWithString:currentPlayURL] size:self.containerView.size]];
}


- (void)setupPlayer {
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self.currentViewControlller setNeedsStatusBarAppearanceUpdate];
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player stop];
    };
}

- (void)playClick:(UIButton *)sender {
    
    self.player.assetURL = [NSURL URLWithString:[NSString  stringWithFormat:@"%@",self.currentPlayURL]] ;
    
    [self.controlView showTitle:@"" coverURLString:self.currentPlayURL fullScreenMode:ZFFullScreenModeAutomatic];
}

#pragma mark UI

- (UIImageView *)picImgView
{
    if (!_picImgView) {
        _picImgView = [UIImageView new];
        _picImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _picImgView;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
        _controlView.prepareShowControlView = YES;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        _containerView.userInteractionEnabled = YES;
    }
    return _containerView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
