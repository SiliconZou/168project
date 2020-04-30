//
//  StatisticsAlert2.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "StatisticsAlert2.h"

@interface ColorCircleView : UIView

//数组里面装的是字典，，字典里有两个key -> strokeColor和precent
@property (nonatomic,assign) NSArray *circleArray;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;

@end

@implementation ColorCircleView

- (void)initType
{
    [self.shapeLayer removeFromSuperlayer];

    __block float a = 0;

    [self.circleArray enumerateObjectsUsingBlock:^(NSDictionary *obj,NSUInteger idx, BOOL *_Nonnull stop) {
        
        //创建出CAShapeLayer
        self.shapeLayer = [CAShapeLayer layer];
        
        self.shapeLayer.frame = CGRectMake(0,0, self.bounds.size.width,self.bounds.size.height);//设置shapeLayer的尺寸和位置

        //  self.shapeLayer.position = self.view.center;
        
        self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor

        //设置线条的宽度和颜色
        
        self.shapeLayer.lineWidth = 20.0f * AUTO_WIDTH;

        self.shapeLayer.strokeColor = [obj[@"strokeColor"]CGColor];

        //创建出圆形贝塞尔曲线

        UIBezierPath *circlePath = [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0, self.bounds.size.width,self.bounds.size.height)] bezierPathByReversingPath];

        //让贝塞尔曲线与CAShapeLayer产生联系

        self.shapeLayer.path = circlePath.CGPath;

        self.shapeLayer.strokeStart = a;

        self.shapeLayer.strokeEnd = [obj[@"precent"]floatValue] + a;

        a = self.shapeLayer.strokeEnd;

        //添加并显示

        [self.layer addSublayer:self.shapeLayer];

        //添加圆环动画

        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        
        pathAnimation.duration = 1.0;

        pathAnimation.fromValue = @(0);

        pathAnimation.toValue = @(1);

        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
  }];
}

- (void)setCircleArray:(NSArray *)circleArray
{
  _circleArray = circleArray;
  [self initType];
}

@end


@interface OptionBarView  : UIView

@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UILabel *rateLb;
@property (nonatomic,strong) UIView *barBgView;
@property (nonatomic,strong) UIView *barValueView;

@end

@implementation OptionBarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self addSubview:self.titleLb];
    [self addSubview:self.rateLb];
    [self addSubview:self.barBgView];
    [self addSubview:self.barValueView];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(22*AUTO_WIDTH);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.rateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_right).offset(-50*AUTO_WIDTH);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.barBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(226*AUTO_WIDTH, 25*AUTO_WIDTH));
        make.centerY.mas_equalTo(self);
        make.left.mas_offset(54*AUTO_WIDTH);
    }];
    
    [self.barValueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.barBgView);
        make.width.mas_equalTo(0);
    }];
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x101628) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _titleLb;
}

- (UILabel *)rateLb
{
    if (!_rateLb) {
        _rateLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x101628) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _rateLb;
}

- (UIView *)barBgView
{
    if (!_barBgView) {
        _barBgView = [UIView new];
        _barBgView.backgroundColor = UR_ColorFromValue(0xEEEEEE);
    }
    return _barBgView;
}

- (UIView *)barValueView
{
    if (!_barValueView) {
        _barValueView = [UIView new];
        _barValueView.backgroundColor = UR_ColorFromValue(0xFDC13F);
    }
    return _barValueView;
}

@end

@interface StatisticsAlert2 ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,strong) UILabel *titleLb1;
@property (nonatomic,strong) UILabel *titleLb2;

@property (nonatomic,strong) UILabel *rateLb;
@property (nonatomic,strong) ColorCircleView *colorRingRateView;//正确率彩色圆环

@property (nonatomic,strong) UILabel *allPersonLb;
@property (nonatomic,strong) UILabel *rightPersonLb;
@property (nonatomic,strong) UILabel *errorPersonLb;

@property (nonatomic,strong) OptionBarView *optionAbar;
@property (nonatomic,strong) OptionBarView *optionBbar;
@property (nonatomic,strong) OptionBarView *optionCbar;
@property (nonatomic,strong) OptionBarView *optionDbar;
@property (nonatomic,strong) OptionBarView *optionEbar;
@property (nonatomic,strong) OptionBarView *optionFbar;

@property (nonatomic,copy) void (^__nullable cancelBlock) (void);

@end

@implementation StatisticsAlert2

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

- (void)showWithQuestionID:(NSString *)questionID cancel:(void(^)(void))cancel
{
    self.cancelBlock = cancel;
    
    [[URCommonApiManager  sharedInstance] getLiveAnswerStatisticsDataWithApi_token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" question_id:questionID?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        NSInteger  allNumber = [responseDict[@"data"][@"all"]  integerValue] ;
        NSInteger  trueNumber = [responseDict[@"data"][@"true"]  integerValue] ;
        NSInteger  falseNumber = [responseDict[@"data"][@"false"]  integerValue] ;
        NSInteger  sel1 = [responseDict[@"data"][@"sel1"]  integerValue] ;
        NSInteger  sel2 = [responseDict[@"data"][@"sel2"]  integerValue] ;
        NSInteger  sel3 = [responseDict[@"data"][@"sel3"]  integerValue] ;
        NSInteger  sel4 = [responseDict[@"data"][@"sel4"]  integerValue] ;
        NSInteger  sel5 = [responseDict[@"data"][@"sel5"]  integerValue] ;
        NSInteger  sel6 = [responseDict[@"data"][@"sel6"]  integerValue] ;

        
        [UIView animateWithDuration:0.5 animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            self.alertView.frame = CGRectMake(18*AUTO_WIDTH, URScreenHeight()-470*AUTO_WIDTH, 340*AUTO_WIDTH, 470*AUTO_WIDTH);
        }];

        self.rateLb.attributedText = [NSMutableAttributedString ur_changeFontAndColor:RegularFont(FontSize12) Color:UR_ColorFromValue(0x101628) TotalString:[NSString stringWithFormat:@"%ld\n正确率",(trueNumber/allNumber)*100] SubStringArray:@[@"正确率"]];
        
        self.colorRingRateView.circleArray =@[
            @{
            @"strokeColor":UR_ColorFromValue(0xFA2727),//正确
            @"precent"  :(@(trueNumber/allNumber))
            },
            @{
            @"strokeColor":UR_ColorFromValue(0x3F7FFD),//错误
            @"precent"  :@(falseNumber/allNumber)
            }
        ];
        
        self.allPersonLb.text = [NSString  stringWithFormat:@"总答题人数: %@人",responseDict[@"data"][@"all"]] ;
        
        self.rightPersonLb.attributedText = [NSMutableAttributedString ur_changeColorWithColor:UR_ColorFromValue(0xFA2727) totalString:[NSString stringWithFormat:@"• 答对人数：%ld人",(long)trueNumber] subStringArray:@[@"•"]];
        
        self.errorPersonLb.attributedText = [NSMutableAttributedString ur_changeColorWithColor:UR_ColorFromValue(0x3F7FFD) totalString:[NSString stringWithFormat:@"• 答错人数：%ld人",(long)falseNumber] subStringArray:@[@"•"]];
      
        if (sel1==0 || allNumber ==0) {
            self.optionAbar.rateLb.text = @"0%" ;
            [self.optionAbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
        } else {
            self.optionAbar.rateLb.text = [NSString  stringWithFormat:@"%.f%@",([responseDict[@"data"][@"sel1"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue] ) * 100,@"%"];
            [self.optionAbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(226*AUTO_WIDTH * ([responseDict[@"data"][@"sel1"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue]));
            }];
        }
        
        if (sel2==0 || allNumber ==0) {
            self.optionBbar.rateLb.text = @"0%" ;
            [self.optionBbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
        } else {
            self.optionBbar.rateLb.text = [NSString  stringWithFormat:@"%.f%@",([responseDict[@"data"][@"sel2"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue] ) * 100,@"%"];
            [self.optionBbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(226*AUTO_WIDTH * ([responseDict[@"data"][@"sel2"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue]));
            }];
        }
        
        
        if (sel3==0 || allNumber ==0) {
            self.optionCbar.rateLb.text = @"0%" ;
            [self.optionCbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
        } else {
            self.optionCbar.rateLb.text = [NSString  stringWithFormat:@"%.f%@",([responseDict[@"data"][@"sel3"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue] ) * 100,@"%"];
            [self.optionCbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(226*AUTO_WIDTH * ([responseDict[@"data"][@"sel3"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue]));
            }];
        }
        
        if (sel4==0 || allNumber ==0) {
            self.optionDbar.rateLb.text = @"0%" ;
            [self.optionDbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
        } else {
            self.optionDbar.rateLb.text = [NSString  stringWithFormat:@"%.f%@",([responseDict[@"data"][@"sel4"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue] ) * 100,@"%"];
            [self.optionDbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(226*AUTO_WIDTH * ([responseDict[@"data"][@"sel4"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue]));
            }];
        }
        
        if (sel5==0 || allNumber ==0) {
            self.optionEbar.rateLb.text = @"0%" ;
            [self.optionEbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
        } else {
            self.optionEbar.rateLb.text = [NSString  stringWithFormat:@"%.f%@",([responseDict[@"data"][@"sel5"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue] ) * 100,@"%"];
            [self.optionEbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(226*AUTO_WIDTH * ([responseDict[@"data"][@"sel5"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue]));
            }];
        }
        
        if (sel6==0 || allNumber ==0) {
            self.optionFbar.rateLb.text = @"0%" ;
            [self.optionFbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
        } else {
            self.optionFbar.rateLb.text = [NSString  stringWithFormat:@"%.f%@",([responseDict[@"data"][@"sel6"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue] ) * 100,@"%"];
            [self.optionFbar.barValueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(226*AUTO_WIDTH * ([responseDict[@"data"][@"sel6"]  floatValue]/[responseDict[@"data"][@"all"]  floatValue]));
            }];
        }
        
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];    
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.alertView.frame = CGRectMake(18*AUTO_WIDTH, URScreenHeight(), 340*AUTO_WIDTH, 470*AUTO_WIDTH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.cancelBlock = nil;
    }];
}

- (void)createUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.cancelBtn];
    [self.alertView addSubview:self.titleLb1];
    [self.alertView addSubview:self.titleLb2];
    [self.alertView addSubview:self.colorRingRateView];
    [self.alertView addSubview:self.rateLb];
    [self.alertView addSubview:self.allPersonLb];
    [self.alertView addSubview:self.rightPersonLb];
    [self.alertView addSubview:self.errorPersonLb];
    [self.alertView addSubview:self.optionAbar];
    [self.alertView addSubview:self.optionBbar];
    [self.alertView addSubview:self.optionCbar];
    [self.alertView addSubview:self.optionDbar];
    [self.alertView addSubview:self.optionEbar];
    [self.alertView addSubview:self.optionFbar];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45*AUTO_WIDTH, 45*AUTO_WIDTH));
        make.top.right.mas_offset(0);
    }];
    [self.titleLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50*AUTO_WIDTH);
        make.left.mas_offset(20*AUTO_WIDTH);
    }];
    [self.titleLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(220*AUTO_WIDTH);
        make.left.mas_offset(20*AUTO_WIDTH);
    }];
  
    [self.rateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.colorRingRateView);
    }];
    
    [self.allPersonLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(118*AUTO_WIDTH);
        make.left.mas_offset(190*AUTO_WIDTH);
    }];
    [self.rightPersonLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(145*AUTO_WIDTH);
        make.left.mas_offset(190*AUTO_WIDTH);
    }];
    [self.errorPersonLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(167*AUTO_WIDTH);
        make.left.mas_offset(190*AUTO_WIDTH);
    }];
    
    [self.optionAbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(@[self.optionBbar,self.optionCbar,self.optionDbar,self.optionEbar,self.optionFbar,@(25*AUTO_WIDTH)]);
        make.top.mas_offset(253*AUTO_WIDTH);
    }];
    [self.optionBbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.optionAbar.mas_bottom).offset(10*AUTO_WIDTH);
    }];
    [self.optionCbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.optionBbar.mas_bottom).offset(10*AUTO_WIDTH);
    }];
    [self.optionDbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.optionCbar.mas_bottom).offset(10*AUTO_WIDTH);
    }];
    [self.optionEbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.optionDbar.mas_bottom).offset(10*AUTO_WIDTH);
    }];
    [self.optionFbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.optionEbar.mas_bottom).offset(10*AUTO_WIDTH);
    }];
    
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismiss];
    }];
}

- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(18*AUTO_WIDTH, URScreenHeight(), 340*AUTO_WIDTH, 470*AUTO_WIDTH)];
        _alertView.backgroundColor = UR_ColorFromValue(0xFFFFFF);
    }
    return _alertView;
}

- (UILabel *)titleLb1
{
    if (!_titleLb1) {
        _titleLb1 = [UILabel normalLabelWithTitle:@"答题情况统计" titleColor:UR_ColorFromValue(0x101628) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _titleLb1;
}
 
- (UILabel *)titleLb2
{
    if (!_titleLb2) {
        _titleLb2 = [UILabel normalLabelWithTitle:@"各选项选中率" titleColor:UR_ColorFromValue(0x101628) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _titleLb2;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton ImgBtnWithImageName:@"cha-2"];
    }
    return _cancelBtn;
}

- (ColorCircleView *)colorRingRateView
{
    if (!_colorRingRateView) {
        _colorRingRateView = [[ColorCircleView alloc] initWithFrame:CGRectMake((25+10)*AUTO_WIDTH, (81+10)*AUTO_WIDTH, (132-20)*AUTO_WIDTH, (132-20)*AUTO_WIDTH)];
    }
    return _colorRingRateView;
}

- (UILabel *)rateLb
{
    if (!_rateLb) {
        _rateLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0xF16575) font:RegularFont(FontSize31) textAlignment:NSTextAlignmentCenter numberLines:2];
    }
    return _rateLb;
}

- (UILabel *)allPersonLb
{
    if (!_allPersonLb) {
        _allPersonLb = [UILabel normalLabelWithTitle:@"总答题人数：365人" titleColor:UR_ColorFromValue(0x101628) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _allPersonLb;
}

- (UILabel *)rightPersonLb
{
    if (!_rightPersonLb) {
        _rightPersonLb = [UILabel normalLabelWithTitle:@"• 答对人数：200人" titleColor:UR_ColorFromValue(0x101628) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _rightPersonLb;
}

- (UILabel *)errorPersonLb
{
    if (!_errorPersonLb) {
        _errorPersonLb = [UILabel normalLabelWithTitle:@"• 答错人数：165人" titleColor:UR_ColorFromValue(0x101628) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _errorPersonLb;
}

- (OptionBarView *)optionAbar
{
    if (!_optionAbar) {
        _optionAbar = [OptionBarView new];
        _optionAbar.titleLb.text = @"选A";
    }
    return _optionAbar;
}

- (OptionBarView *)optionBbar
{
    if (!_optionBbar) {
        _optionBbar = [OptionBarView new];
        _optionBbar.titleLb.text = @"选B";
    }
    return _optionBbar;
}

- (OptionBarView *)optionCbar
{
    if (!_optionCbar) {
        _optionCbar = [OptionBarView new];
        _optionCbar.titleLb.text = @"选C";
    }
    return _optionCbar;
}

- (OptionBarView *)optionDbar
{
    if (!_optionDbar) {
        _optionDbar = [OptionBarView new];
        _optionDbar.titleLb.text = @"选D";
    }
    return _optionDbar;
}

- (OptionBarView *)optionEbar
{
    if (!_optionEbar) {
        _optionEbar = [OptionBarView new];
        _optionEbar.titleLb.text = @"选E";
    }
    return _optionEbar;
}

- (OptionBarView *)optionFbar
{
    if (!_optionFbar) {
        _optionFbar = [OptionBarView new];
        _optionFbar.titleLb.text = @"选F";
    }
    return _optionFbar;
}

@end
