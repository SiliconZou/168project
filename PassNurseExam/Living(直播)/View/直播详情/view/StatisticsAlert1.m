//
//  StatisticsAlert1.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "StatisticsAlert1.h"

@interface StatisticsAlert1 ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UIScrollView *scrollV;
@property (nonatomic,strong) UILabel *contentLb;
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,strong) UIButton * cancelButton;

@property (nonatomic,copy) void (^__nullable commitBlock) (void);
@property (nonatomic,copy) void (^__nullable cancelBlock) (void);

@end

@implementation StatisticsAlert1

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

- (void)showWithStaticsList:(NSArray *)list commit:(void(^)(void))commit cancel:(void(^)(void))cancel
{
    self.commitBlock = commit;
    self.cancelBlock = cancel;
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.alertView.frame = CGRectMake(URScreenWidth()-180*AUTO_WIDTH, URScreenHeight()-340*AUTO_WIDTH, 180*AUTO_WIDTH, 340*AUTO_WIDTH);
    }];

    __block NSString *listStr = @"";
    
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *text = (NSString *)obj;
        
        if (listStr.length == 0) {
            listStr = text;
        }else {
            listStr = [NSString stringWithFormat:@"%@\n%@",listStr,text];
        }
    }];
    
    self.contentLb.attributedText = [NSMutableAttributedString ur_changeLineSpaceWithTotalString:listStr lineSpace:10];
}

-(void)setPersonalList:(NSArray *)personalList{
    
    _personalList = personalList ;
    
    __block NSString *listStr = @"";
    
    [personalList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *text = (NSString *)obj;
        
        if (listStr.length == 0) {
            listStr = text;
        }else {
            listStr = [NSString stringWithFormat:@"%@\n%@",listStr,text];
        }
    }];
    
    self.contentLb.attributedText = [NSMutableAttributedString ur_changeLineSpaceWithTotalString:listStr lineSpace:10];
    
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.alertView.frame = CGRectMake(URScreenWidth()-180*AUTO_WIDTH, URScreenHeight(), 180*AUTO_WIDTH, 340*AUTO_WIDTH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.commitBlock = nil;
        self.cancelBlock = nil;
    }];
}

- (void)createUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLb];
    [self.alertView addSubview:self.correctNumberLb];
    [self.alertView addSubview:self.scrollV];
    [self.scrollV addSubview:self.contentLb];
    [self.alertView addSubview:self.sureBtn];
    [self.alertView addSubview:self.cancelButton];

    [self.alertView addCorners:UIRectCornerTopLeft radius:10 bounds:self.alertView.bounds];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(24*AUTO_WIDTH, 24*AUTO_WIDTH));
        make.right.mas_equalTo(-5 *AUTO_WIDTH);
        make.top.mas_offset(10*AUTO_WIDTH);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(28*AUTO_WIDTH);
        make.left.mas_offset(15*AUTO_WIDTH);
    }];
    
    [self.correctNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15*AUTO_WIDTH);
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(5*AUTO_WIDTH);
    }];
    
    [self.scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150*AUTO_WIDTH);
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.correctNumberLb.mas_bottom).offset(15*AUTO_WIDTH);
        make.bottom.mas_offset(-58*AUTO_WIDTH);
    }];
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo(150*AUTO_WIDTH);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(91*AUTO_WIDTH, 26*AUTO_WIDTH));
        make.centerX.mas_equalTo(self.alertView);
        make.bottom.mas_offset(-12*AUTO_WIDTH);
    }];
    
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.commitBlock();
        [self dismiss];
    }];
    
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self  dismiss] ;
    }];
}

- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(URScreenWidth()-180*AUTO_WIDTH, URScreenHeight(), 180*AUTO_WIDTH, 340*AUTO_WIDTH)];
        _alertView.backgroundColor = UR_ColorFromValue(0x000000);
    }
    return _alertView;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"已有0人抢答" titleColor:[UIColor whiteColor] font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _titleLb;
}

- (UIScrollView *)scrollV
{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] init];
        _scrollV.showsHorizontalScrollIndicator = NO;
    }
    return _scrollV;
}

- (UILabel *)contentLb
{
    if (!_contentLb) {
        _contentLb = [UILabel normalLabelWithTitle:@"" titleColor:[UIColor whiteColor] font:RegularFont(FontSize11) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _contentLb;
}

-(UILabel *)correctNumberLb{
    if (!_correctNumberLb) {
        _correctNumberLb = [UILabel   normalLabelWithTitle:@"答对0人" titleColor:[UIColor whiteColor] font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:0] ;
    }
    return _correctNumberLb ;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton cornerBtnWithRadius:13*AUTO_WIDTH title:@"答题统计" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize14) backColor:UR_ColorFromValue(0x00A4FF)];
    }
    return _sureBtn;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton   ImgBtnWithImageName:@"cha"];
    }
    return _cancelButton ;
}

@end
