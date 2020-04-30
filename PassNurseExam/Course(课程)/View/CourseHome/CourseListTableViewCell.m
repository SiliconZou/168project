//
//  CourseListTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseListTableViewCell.h"

@interface CourseListTableViewCell ()

@property (nonatomic,strong) UIImageView *logo;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UILabel *subTipLb;
@property (nonatomic,strong) UILabel *priceLb;
@property (nonatomic,strong) UIButton *teacherBtn;
@property (nonatomic,strong) UILabel * teacherNameLb;
@property (nonatomic,strong) NSMutableArray <UIButton *> *btnTempArr;//暂时存放多个老师的按钮

@end

@implementation CourseListTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.btnTempArr = [NSMutableArray array];
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.subTipLb];
    [self.contentView addSubview:self.priceLb];
    [self.contentView addSubview:self.teacherBtn];
    [self.contentView  addSubview:self.teacherNameLb];
    
    
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(111 * AUTO_WIDTH, 82 * AUTO_WIDTH));
        make.left.mas_offset(11 * AUTO_WIDTH);
        make.top.mas_offset(13 * AUTO_WIDTH);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logo.mas_right).offset(20 * AUTO_WIDTH);
        make.right.mas_offset(-10 * AUTO_WIDTH);
        make.top.mas_offset(13 * AUTO_WIDTH);
        make.height.mas_equalTo(20 * AUTO_WIDTH);
    }];
    [self.subTipLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLb);
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(8 * AUTO_WIDTH);
        make.height.mas_equalTo(20 * AUTO_WIDTH);
    }];
    [self.priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLb);
        make.top.mas_equalTo(self.subTipLb.mas_bottom).offset(15 * AUTO_WIDTH);
    }];
    [self.teacherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLb);
        make.size.mas_equalTo(CGSizeMake(80* AUTO_WIDTH, 28* AUTO_WIDTH)) ;
        make.right.mas_offset(-10 * AUTO_WIDTH);
        make.bottom.mas_offset(-15 * AUTO_WIDTH);
    }];
    
    [self.teacherNameLb  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10* AUTO_WIDTH) ;
        make.top.mas_equalTo(self.subTipLb.mas_bottom).offset(12 * AUTO_WIDTH) ;
        make.height.mas_equalTo(25* AUTO_WIDTH) ;
    }];

    @weakify(self);
    [[self.teacherBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self);
        
        if (userLoginStatus == 1)
        {
            if ([self.courseModel.vip integerValue] == 1)
            {
                //会员课程，点击去开通会员，才可看
                [URAlert alertViewWithStyle:URAlertStyleAlert title:@"提示" message:@"此课程为会员专享课程，是否开通会员？" cancelButtonTitle:@"取消" sureButtonTitles:@"开通" viewController:[self getCurrentVC] handler:^(NSInteger buttonIndex) {
                    
                    if (buttonIndex == 1)//开通，则跳转到 会员开通支付页面
                    {
                        MemberPayAlertView * payAlertView = [[MemberPayAlertView  alloc] init];
                        [payAlertView showAlertView:@{@"buyType":@"1"} finish:^{
                            //改变下当前按钮
                            [self.teacherBtn setTitle:@"立即学习" forState:UIControlStateNormal];
                            [self.teacherBtn setBackgroundColor:UR_ColorFromValue(0x91f261)];
                            self.teacherBtn.userInteractionEnabled = NO;
                        }];
                    }
                }];
            }
            else //付费视频，点击去课程付费页面，购买付费视频
            {
                CoursePayViewController * payViewController = [[CoursePayViewController  alloc] init];
                
                payViewController.univalence =  self.courseModel.univalence;
                payViewController.idStr = self.courseModel.idStr;
                payViewController.stage = @[self.courseModel];
                payViewController.buyType = @"stage";//阶段
                NSLog(@"走了这里 %@",@"stage");
                
                payViewController.hidesBottomBarWhenPushed = YES;
                URBasicViewController *vc = (URBasicViewController *)[self getCurrentVC];
                [vc.navigationController pushViewController:payViewController animated:YES];
            }
        }else//未登录，去登陆
        {
            [[self getCurrentVC] presentViewController:[[UINavigationController  alloc]initWithRootViewController:[NSClassFromString(@"UserLogInViewController") new]] animated:YES completion:nil];
        }
    }];
}

-(void)setCourseModel:(BaseCourseModel *)courseModel
{
    _courseModel = courseModel ;
    
    BaseCourseModel *  commonModel = courseModel ;
    
    [_logo sd_setImageWithURL:[NSURL  URLWithString:[NSString  stringWithFormat:@"%@",commonModel.thumbnail?:@""]] placeholderImage:[UIImage  imageNamed:@"占位图"]];
    
    _nameLb.text = [NSString  stringWithFormat:@"%@",commonModel.name?:@""] ;
    
    self.subTipLb.text = [NSString  stringWithFormat:@" 更新时间：%@ 共%@ ",commonModel.updated_at?:@"",commonModel.class_hour?:@""] ;
    
    
    //vip ：是否是vip才可以看的视频   1是   0不是
    if ([commonModel.vip integerValue] == 1)
    {
        self.priceLb.text = @"会员课程";
        self.priceLb.textColor = UR_ColorFromValue(0xFF773A);
        
        //我 还不是会员
        if ([URUserDefaults standardUserDefaults].userInforModel.is_vip.integerValue == 0)
        {
            if (is_online == 0) {
                [self.teacherBtn setTitle:@"还不是会员" forState:UIControlStateNormal];
                self.teacherBtn.userInteractionEnabled = NO;
            }else {
                [self.teacherBtn setTitle:@"立即开通" forState:UIControlStateNormal];
                self.teacherBtn.userInteractionEnabled = YES;
            }
            [self.teacherBtn setBackgroundColor:UR_ColorFromValue(0xF9A768)];
        } else
        {
            [self.teacherBtn setTitle:@"立即学习" forState:UIControlStateNormal];
            [self.teacherBtn setBackgroundColor:UR_ColorFromValue(0x91f261)];
            self.teacherBtn.userInteractionEnabled = NO;
        }
    }
    else
    {
        //charge ：是否收费  1收费  0不收费
        if ([commonModel.charge integerValue] == 1 && [courseModel.univalence floatValue] > 0)
        {
            //未付款
            if ([commonModel.own integerValue] == 0)
            {
                if (is_online==0) {
                    self.priceLb.text = @"" ;
                } else {
                    self.priceLb.text = [NSString  stringWithFormat:@"¥%.2f",commonModel.univalence.floatValue];

                }
                self.priceLb.textColor = UR_ColorFromValue(0xFF773A);
                [self.teacherBtn setBackgroundColor:UR_ColorFromValue(0xF9A768)];
                
                 if (is_online == 0) {
                     [self.teacherBtn setTitle:@"暂不可学习" forState:UIControlStateNormal];
                     self.teacherBtn.userInteractionEnabled = NO;
                 }else {
                     [self.teacherBtn setTitle:@"立即开通" forState:UIControlStateNormal];
                     self.teacherBtn.userInteractionEnabled = YES;
                 }
            }else
            {
                if (is_online==0) {
                    self.priceLb.text = @"已激活";
                } else {
                    self.priceLb.text = @"已购买";
                }
                self.priceLb.textColor = UR_ColorFromValue(0x256900);
                [self.teacherBtn setTitle:@"立即学习" forState:UIControlStateNormal];
                [self.teacherBtn setBackgroundColor:UR_ColorFromValue(0x63A3FF)];
                self.teacherBtn.userInteractionEnabled = NO;
            }
        } else
        {
            self.priceLb.text = @"免费";
            self.priceLb.textColor = UR_ColorFromValue(0x256900);
            [self.teacherBtn setTitle:@"立即学习" forState:UIControlStateNormal];
            [self.teacherBtn setBackgroundColor:UR_ColorFromValue(0x63A3FF)];
            self.teacherBtn.userInteractionEnabled = NO;
        }
    }
    
    if (self.btnTempArr.count > 0) {
        [self.btnTempArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self.btnTempArr removeAllObjects];
    }
    
    if (commonModel.teachers.count>0)
    {
        CGFloat teacherWidth = (25*commonModel.teachers.count*AUTO_WIDTH + (commonModel.teachers.count-1)*8+10)*AUTO_WIDTH;;
        
        [commonModel.teachers  enumerateObjectsUsingBlock:^(BaseCourseTeacherModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIButton * teacherIconButton = [UIButton   buttonWithType:UIButtonTypeCustom] ;
            [teacherIconButton  sd_setImageWithURL:[NSURL  URLWithString:obj.thumbnail] forState:UIControlStateNormal placeholderImage:[UIImage  imageNamed:@"占位图"]];
            teacherIconButton.layer.cornerRadius = 12.5f*AUTO_WIDTH;
            teacherIconButton.layer.masksToBounds = YES ;
            [self.contentView addSubview:teacherIconButton];
            [teacherIconButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.subTipLb.mas_bottom).offset(12 * AUTO_WIDTH) ;
                make.left.mas_equalTo((URScreenWidth()-teacherWidth)+33*idx*AUTO_WIDTH);
                make.size.mas_equalTo(CGSizeMake(25*AUTO_WIDTH, 25*AUTO_WIDTH));
            }];
            
            if (commonModel.teachers.count==1)
            {
                self.teacherNameLb.hidden = NO;
                self.teacherNameLb.text = [NSString  stringWithFormat:@"%@",commonModel.teachers[0].name?:@""] ;
                CGFloat teacherNameWidth = [commonModel.teachers[0].name ur_widthWithFont:RegularFont(12.0f) constrainedToHeight:25] ;
                
                [teacherIconButton  mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(URScreenWidth()-10*AUTO_WIDTH-teacherNameWidth-30*AUTO_WIDTH) ;
                }];
            } else {
                self.teacherNameLb.hidden = YES;
            }
            
            [self.btnTempArr addObject:teacherIconButton];
        }];
        
        [self.priceLb  mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.subTipLb.mas_bottom).mas_offset(50* AUTO_WIDTH) ;
        }];
        
    }
}


- (UIImageView *)logo
{
    if (!_logo) {
        _logo = [UIImageView new];
        _logo.backgroundColor = UR_COLOR_DISABLE_CLICK;
        _logo.layer.cornerRadius = 4 * AUTO_WIDTH;
        _logo.layer.masksToBounds = YES;
    }
    return _logo;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:2];
    }
    return _nameLb;
}

-(UILabel *)teacherNameLb{
    if (!_teacherNameLb) {
        _teacherNameLb = [[UILabel  alloc] init];
        _teacherNameLb.textColor = UR_ColorFromValue(0x666666) ;
        _teacherNameLb.font = RegularFont(12.0f);
    }
    
    return _teacherNameLb ;
}

- (UILabel *)subTipLb
{
    if (!_subTipLb) {
        _subTipLb = [UILabel borderLabelWithRadius:4 borderColor:UR_ColorFromRGBA(249, 164, 97, 0.3) borderWidth:1 title:@"" titleColor:UR_ColorFromValue(0xF9A768) font:RegularFont(FontSize12) textAlignment:NSTextAlignmentCenter numberLines:1];
        _subTipLb.backgroundColor = UR_ColorFromValue(0xFFF7F3);
    }
    return _subTipLb;
}

-(UILabel *)priceLb
{
    if (!_priceLb) {
        _priceLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0xFF773A) font:RegularFont(FontSize13) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _priceLb;
}

- (UIButton *)teacherBtn{
    if (!_teacherBtn) {
        _teacherBtn = [UIButton new];
        [_teacherBtn setTitle:@"" forState:UIControlStateNormal];
        [_teacherBtn setTitleColor:UR_ColorFromValue(0xffffff) forState:UIControlStateNormal];
        _teacherBtn.titleLabel.font = RegularFont(14.0f) ;
        _teacherBtn.layer.cornerRadius = 14.0f* AUTO_WIDTH;
        _teacherBtn.layer.masksToBounds = YES ;
        _teacherBtn.alpha = 0.5f ;
    }
    return _teacherBtn;
}


@end
