//
//  MyClassVC.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "MyClassVC.h"
#import "ClassAttendanceViewController.h"

@interface MyClassVC ()

@property (nonatomic,strong) UIScrollView *myScroll;
@property (nonatomic,strong) SFLabel *titleLb;
@property (nonatomic,strong) UILabel *notiContentLb;

@end

@implementation MyClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cSuperTitle = @"我的班级";
    [self createUI];
}

- (void)createUI
{
    UILabel *notiTitleLb = [UILabel cornerLabelWithRadius:4 backColor:UR_ColorFromValue(0xFECA91) title:@"班级\n通知" titleColor:[UIColor whiteColor] font:RegularFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:2];
    UIImageView *notiImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noti"]];
    
    [self.view addSubview:self.myScroll];
    [self.myScroll addSubview:self.titleLb];
    [self.myScroll addSubview:notiTitleLb];
    [self.myScroll addSubview:self.notiContentLb];
    [self.myScroll addSubview:notiImg];
    
    [self.myScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(URScreenWidth());
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.width.mas_equalTo(URScreenWidth() - 24 * AUTO_WIDTH);
        make.top.mas_offset(16 * AUTO_WIDTH);
        make.height.mas_equalTo(69 * AUTO_WIDTH);
    }];
    [notiTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36 * AUTO_WIDTH, 42 * AUTO_WIDTH));
        make.left.mas_equalTo(self.titleLb);
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(10 * AUTO_WIDTH);
    }];
    [notiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15 * AUTO_WIDTH, 12 * AUTO_WIDTH));
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(16 * AUTO_WIDTH);
        make.left.mas_equalTo(notiTitleLb.mas_right).offset(7 * AUTO_WIDTH);
    }];
    [self.notiContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(notiImg.mas_right).offset(7 * AUTO_WIDTH);
        make.right.mas_equalTo(self.titleLb);
        make.top.mas_equalTo(notiTitleLb);
    }];
    
    
    NSArray *titles = @[@"班级课表",@"我的书桌",@"班级作业",@"班级测验",@"上课笔记",@"班级生活"];
    NSArray *colorS = @[UR_ColorFromValue(0xCDEDFF),UR_ColorFromValue(0xFFF1D4),
                        UR_ColorFromValue(0xCFF2DC),UR_ColorFromValue(0xFFD9E2),
                        UR_ColorFromValue(0xE6DBFF),UR_ColorFromValue(0xFDFFD2)];
   
    for (int i = 0; i < 6; i++)
    {
        UIButton *btn = [UIButton backcolorBtnWithTitle:titles[i] titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize16) backColor:colorS[i]];
        [btn setImage:[UIImage imageNamed:titles[i]] forState:UIControlStateNormal];
    
        [self.myScroll addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(112 * AUTO_WIDTH, 102 * AUTO_WIDTH));
            make.left.mas_offset(i%3 * (112+8) * AUTO_WIDTH + 12 * AUTO_WIDTH);
            make.top.mas_equalTo(notiTitleLb.mas_bottom).offset(i/3 * (102+8) * AUTO_WIDTH + 30 * AUTO_WIDTH);
        }];
        [btn layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleTop imageTitleSpace:12];
        
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if (i==5) {
                [self pushViewControllerWithString:@"MyClassLifeVC" withModel:nil];
            }
        }];
    }
    
    //考勤按钮
    UIButton *attendanceBtn = [UIButton borderBtnWithBorderColor:UR_ColorFromValue(0x59A2FF) borderWidth:0.5 cornerRadius:0 title:@"上课考勤" titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize18)];
    [attendanceBtn setImage:[UIImage imageNamed:@"kq-sys"] forState:UIControlStateNormal];
    [[attendanceBtn  rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        ClassAttendanceViewController * clsViewController = [[ClassAttendanceViewController alloc] init];
        
        [self.navigationController pushViewController:clsViewController animated:YES] ;

    }];
    [self.myScroll addSubview:attendanceBtn];
    [attendanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.right.mas_equalTo(self.titleLb);
        make.top.mas_offset(404 * AUTO_WIDTH);
        make.height.mas_equalTo(54 * AUTO_WIDTH);
        make.bottom.mas_offset(-30 * AUTO_WIDTH);
    }];
    [attendanceBtn layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:20];
}

- (UIScrollView *)myScroll
{
    if (!_myScroll) {
        _myScroll = [[UIScrollView alloc] init];
        _myScroll.backgroundColor = [UIColor whiteColor];
        _myScroll.showsHorizontalScrollIndicator = NO;
    }
    return _myScroll;
}

- (SFLabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [[SFLabel alloc] init];
        _titleLb.text = @"护理类/护士资格/30天封闭集训营/面授课程2019年08班";
        _titleLb.textColor = UR_ColorFromValue(0x333333);
        _titleLb.font = RegularFont(FontSize16);
        _titleLb.layer.borderColor = UR_ColorFromValue(0xCCCCCC).CGColor;
        _titleLb.layer.borderWidth = 0.5;
        _titleLb.numberOfLines = 2;
        _titleLb.edgeInsets = UIEdgeInsetsMake(5, 15, 5, 15);
    }
    return _titleLb;
}

- (UILabel *)notiContentLb
{
    if (!_notiContentLb) {
        _notiContentLb = [UILabel normalLabelWithTitle:@"班级通知内容班级通知内容班级通知内容班级 通知内班级通知内容班级通知内容班级通知内容班级 通知内班级通知内容班级通知内容班级通知内容班级 通知内" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:2];
    }
    return _notiContentLb;
}


@end
