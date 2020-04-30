//
//  ImgVideoQuestionBankAnalysisTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "ImgVideoQuestionBankAnalysisTableViewCell.h"

@implementation ImgVideoQuestionBankAnalysisTableViewCell

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
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLb];
    [self.bgView addSubview:self.contentLb];
    [self.bgView addSubview:self.difficultyLb];
    [self.bgView addSubview:self.starsView];
    [self.bgView addSubview:self.videoTitleLb];
    
    [self.bgView  addSubview:self.containerView];
    [self.containerView addSubview:self.playBtn];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10 * AUTO_WIDTH, 12 * AUTO_WIDTH, 10 * AUTO_WIDTH, 12 * AUTO_WIDTH));
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10 * AUTO_WIDTH);
        make.top.mas_offset(10 * AUTO_WIDTH);
    }];
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20 * AUTO_WIDTH);
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(12 * AUTO_WIDTH);
        make.right.mas_offset(-20 * AUTO_WIDTH);
    }];
    [self.difficultyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb);
        make.top.mas_equalTo(self.contentLb.mas_bottom).offset(20 * AUTO_WIDTH);
    }];
    [self.starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80 * AUTO_WIDTH, 12 * AUTO_WIDTH));
        make.left.mas_equalTo(self.difficultyLb.mas_right);
        make.centerY.mas_equalTo(self.difficultyLb);
    }];
    [self.videoTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb);
        make.top.mas_equalTo(self.difficultyLb.mas_bottom).offset(20 * AUTO_WIDTH);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.videoTitleLb.mas_bottom).offset(20 * AUTO_WIDTH);
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(200 * AUTO_WIDTH);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60 * AUTO_WIDTH, 60 * AUTO_WIDTH));
        make.center.mas_equalTo(self.containerView);
    }];
    
}

- (void)setCurrentPlayURL:(NSString *)currentPlayURL
{
    _currentPlayURL = currentPlayURL;
            
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

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.layer.borderColor = UR_COLOR_LINE.CGColor;
        _bgView.layer.borderWidth = 0.5;
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"参考答案：" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _titleLb;
}

- (UILabel *)contentLb
{
    if (!_contentLb) {
        _contentLb = [UILabel normalLabelWithTitle:@"【解析】" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _contentLb;
}

- (UILabel *)difficultyLb
{
    if (!_difficultyLb) {
        _difficultyLb = [UILabel normalLabelWithTitle:@"难度系数：" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _difficultyLb;
}

- (HCSStarRatingView *)starsView
{
    if (!_starsView) {
        _starsView = [[HCSStarRatingView alloc] init];
        _starsView.maximumValue = 5;
        _starsView.minimumValue = 0;
        _starsView.spacing = 1.0;
        _starsView.userInteractionEnabled = NO;
        _starsView.emptyStarImage = [UIImage imageNamed:@"empty_star"];
        _starsView.filledStarImage = [UIImage imageNamed:@"full_star"];
        _starsView.allowsHalfStars = YES;
        _starsView.accurateHalfStars = YES;
    }
    return _starsView;
}

- (UILabel *)videoTitleLb
{
    if (!_videoTitleLb) {
        _videoTitleLb = [UILabel normalLabelWithTitle:@"视频解析：" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _videoTitleLb;
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

- (void)playClick:(UIButton *)sender {
    
    self.player.assetURL = [NSURL  URLWithString:[NSString  stringWithFormat:@"%@",self.currentPlayURL]] ;
    
    [self.controlView showTitle:@"" coverURLString:self.currentPlayURL fullScreenMode:ZFFullScreenModeAutomatic];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
