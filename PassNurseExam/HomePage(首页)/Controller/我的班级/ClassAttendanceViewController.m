//
//  ClassAttendanceViewController.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "ClassAttendanceViewController.h"
#import <FSCalendar/FSCalendar.h>

@interface ClassAttendanceViewController ()

@property (nonatomic,strong) FSCalendar * calendar;

@end

@implementation ClassAttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cSuperTitle = @"上课考勤";
    
    self.view.backgroundColor = UR_ColorFromValue(0xffffff) ;
    
    [self.cBtnRight  setImage:[UIImage  imageNamed:@"二维码"] forState:UIControlStateNormal];
    self.cBtnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -44 * AUTO_WIDTH) ;

    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, URSafeAreaNavHeight() , URScreenWidth(), 300)];
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    calendar.appearance.headerDateFormat = @"yyyy年MM月";
    calendar.appearance.headerTitleColor = UR_ColorFromValue(0xFF8500);
    calendar.appearance.headerTitleFont = RegularFont(FontSize18) ;
    calendar.appearance.weekdayTextColor = UR_ColorFromValue(0x333333);
    calendar.appearance.weekdayFont = RegularFont(FontSize16) ;
    calendar.firstWeekday = 1;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
    calendar.appearance.todaySelectionColor = UR_ColorFromValue(0xffffff);
    calendar.adjustsBoundingRectWhenChangingMonths = NO;
    calendar.swipeToChooseGesture.enabled = NO;
    calendar.allowsSelection = NO ;
    calendar.scrollEnabled = NO ;
    calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    [self.view addSubview:calendar];
    self.calendar = calendar;

    UILabel *  signCycleLabel = [[UILabel  alloc] init];
    signCycleLabel.backgroundColor = UR_ColorFromValue(0xFECA91);
    signCycleLabel.layer.cornerRadius = 18.0f ;
    signCycleLabel.layer.masksToBounds = YES ;
    [self.view  addSubview:signCycleLabel];
    [signCycleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17) ;
        make.top.mas_equalTo(375) ;
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    UILabel * signLabel = [UILabel  normalLabelWithTitle:@"已签到" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1] ;
    [self.view  addSubview:signLabel];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(signCycleLabel.mas_right).mas_offset(13) ;
        make.height.mas_equalTo(13) ;
        make.centerY.mas_equalTo(signCycleLabel) ;
    }];
    
    UILabel *  absenteeismCycleLabel = [[UILabel  alloc] init];
    absenteeismCycleLabel.backgroundColor = UR_ColorFromValue(0xD0D0D0);
    absenteeismCycleLabel.layer.cornerRadius = 18.0f ;
    absenteeismCycleLabel.layer.masksToBounds = YES ;
    [self.view  addSubview:absenteeismCycleLabel];
    [absenteeismCycleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(signLabel.mas_right).mas_offset(35) ;
        make.top.mas_equalTo(375) ;
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    UILabel * absenteeismLabel = [UILabel  normalLabelWithTitle:@"缺勤" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1] ;
    [self.view  addSubview:absenteeismLabel];
    [absenteeismLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(absenteeismCycleLabel.mas_right).mas_offset(13) ;
        make.height.mas_equalTo(13) ;
        make.centerY.mas_equalTo(absenteeismCycleLabel) ;
    }];
    
    UIButton * scanButton = [[UIButton   alloc] init];
    scanButton.layer.borderColor = UR_ColorFromValue(0x59A2FF).CGColor ;
    scanButton.layer.borderWidth = 1.0f ;
    [scanButton  setImage:[UIImage  imageNamed:@"kq-sys"] forState:UIControlStateNormal];
    [scanButton  setTitle:@"请点击右上角，扫描二维码签到！" forState:UIControlStateNormal];
    [scanButton setTitleColor:UR_ColorFromValue(0x333333) forState:UIControlStateNormal];
    scanButton.titleLabel.font = RegularFont(FontSize14) ;
    [self.view  addSubview:scanButton];
    [scanButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14) ;
        make.top.mas_equalTo(signCycleLabel.mas_bottom).mas_offset(38) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-28, 45));
    }];
    
    [scanButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:11] ;
}

-(void)navRightPressed:(id)sender{
    
    HomePageScanViewController * scanViewController = [[HomePageScanViewController  alloc] init];
    [HomePageViewModel  qrCodeScanWithViewController:self pushViewController:scanViewController];
}

@end
