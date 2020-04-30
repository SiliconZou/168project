//
//  LiveSectionManagerView.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionManagerView.h"

@interface LiveSectionManagerView ()<UIGestureRecognizerDelegate>

/// 用户头像
@property (nonatomic,strong) UIImageView * userIconImageView;

/// 用户昵称
@property (nonatomic,strong) UILabel * userNameLabel;

/// 禁言
@property (nonatomic,strong) UIButton * bannedButton;

/// 踢出
@property (nonatomic,strong) UIButton * kickOutButton;

/// 取消按钮
@property (nonatomic,strong) UIButton * cancelButton;

@property (nonatomic,strong) UIView *alertView;


@property (nonatomic,copy) void (^__nullable commitBlock) (NSInteger index);
@property (nonatomic,copy) void (^__nullable cancelBlock) (void);

@end

@implementation LiveSectionManagerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.delegate = self;
        [tap addTarget:self action:@selector(tapPressInAlertViewGesture:)];
        [self addGestureRecognizer:tap];
        [self createUI];
    }
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.alertView]) {
        return NO;
    }
    return YES;
}

// 点击其他区域关闭弹窗
- (void)tapPressInAlertViewGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [sender locationInView:nil];
        
        if (![self.alertView pointInside:[self.alertView convertPoint:location fromView:self] withEvent:nil])
        {
            self.cancelBlock();
            [self dismiss];
        }
    } 
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.alertView.alpha = 0;
        self.alertView.transform =  CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.commitBlock = nil;
        self.cancelBlock = nil;
    }];
}

- (void)showWithData:(LivePenetrateMsgModel *)model commit:(void(^)(NSInteger index))commit cancel:(void(^)(void))cancel{
    
    self.commitBlock = commit;
    self.cancelBlock = cancel;
    
    [self.userIconImageView  sd_setImageWithURL:[NSURL  URLWithString:model.thumbnail] placeholderImage:[UIImage  imageNamed:@"headimg"]];
    
    self.userNameLabel.text = [NSString  stringWithFormat:@"%@",model.username?:@""] ;
       
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.alertView.alpha = 1;
        self.alertView.transform =  CGAffineTransformMakeScale(1, 1);
    }];
    
}

- (void)createUI
{
    [self  addSubview:self.alertView];
    [self.alertView addSubview:self.cancelButton];
    [self.alertView addSubview:self.userIconImageView];
    [self.alertView addSubview:self.userNameLabel];
    [self.alertView addSubview:self.bannedButton];
    [self.alertView addSubview:self.kickOutButton];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45*AUTO_WIDTH, 45*AUTO_WIDTH));
        make.top.right.mas_offset(0);
    }];
    
    [self.userIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*AUTO_WIDTH, 50*AUTO_WIDTH));
        make.top.mas_offset(25*AUTO_WIDTH);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.userIconImageView.mas_bottom).offset(10*AUTO_WIDTH);
        make.left.mas_offset(15*AUTO_WIDTH);
        make.right.mas_offset(-15*AUTO_WIDTH);
    }];
    
    [self.bannedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_offset(0);
        make.height.mas_equalTo(45*AUTO_WIDTH);
    }];
    
    [self.kickOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.height.width.mas_equalTo(self.bannedButton);
        make.left.mas_equalTo(self.bannedButton.mas_right);
    }];
    
    [self.alertView addLineWithStartPoint:CGPointMake(0, 125*AUTO_WIDTH) endPoint:CGPointMake(280*AUTO_WIDTH, 125*AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
    
    [self.alertView addLineWithStartPoint:CGPointMake(280/2.0*AUTO_WIDTH, 125*AUTO_WIDTH) endPoint:CGPointMake(280/2.0*AUTO_WIDTH, 170*AUTO_WIDTH) lineColor:UR_COLOR_LINE lineWidth:0.5];
    
    self.alertView.alpha = 0;
    self.alertView.transform =  CGAffineTransformMakeScale(0.8, 0.8);
    
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
        [self dismiss];
    }];
    
    [[self.bannedButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.commitBlock) {
            self.commitBlock(0);
        }
        [self dismiss];
    }];
    
    [[self.kickOutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.commitBlock) {
            self.commitBlock(1);
        }
        [self dismiss];
    }];
}

- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(URScreenWidth()/2.0 - 280/2.0*AUTO_WIDTH, URScreenHeight()/2.0-170/2.0*AUTO_WIDTH, 280*AUTO_WIDTH, 170*AUTO_WIDTH)];
        _alertView.backgroundColor = UR_ColorFromValue(0xffffff);
        _alertView.layer.cornerRadius = 10.0f ;
        _alertView.layer.masksToBounds = YES ;
    }
    return _alertView;
}

-(UIImageView *)userIconImageView{
    if (!_userIconImageView) {
        _userIconImageView = [[UIImageView   alloc] init];
        _userIconImageView.layer.cornerRadius = 8*AUTO_WIDTH;
        _userIconImageView.layer.masksToBounds = YES;
        _userIconImageView.backgroundColor = UR_COLOR_LINE;
    }
    return _userIconImageView ;
}

-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [UILabel  normalLabelWithTitle:@"名称" titleColor:UR_ColorFromValue(0x101628) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:0] ;
    }
    return _userNameLabel ;
}

- (UIButton *)bannedButton{
    if (!_bannedButton) {
        _bannedButton = [UIButton normalBtnWithTitle:@"禁言" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize15)];
    }
    return _bannedButton;
}

- (UIButton *)kickOutButton{
    if (!_kickOutButton) {
        _kickOutButton = [UIButton normalBtnWithTitle:@"踢出" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize15)];
    }
    return _kickOutButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton ImgBtnWithImageName:@"cha-2"];
    }
    return _cancelButton;
}

@end
