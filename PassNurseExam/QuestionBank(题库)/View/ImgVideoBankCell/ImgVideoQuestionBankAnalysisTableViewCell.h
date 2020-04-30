//
//  ImgVideoQuestionBankAnalysisTableViewCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/23.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImgVideoQuestionBankAnalysisTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UILabel *contentLb;
@property (nonatomic,strong) UILabel *difficultyLb;
@property (nonatomic,strong) HCSStarRatingView *starsView;

@property (nonatomic,strong) UILabel *videoTitleLb;//视频解析标题

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;

//赋值
@property (nonatomic, copy) NSString *currentPlayURL;
@property (nonatomic,strong) UIViewController *currentViewControlller;

@end

NS_ASSUME_NONNULL_END
