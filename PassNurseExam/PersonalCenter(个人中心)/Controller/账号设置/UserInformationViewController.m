//
//  UserInformationViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/10/1.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserInformationViewController.h"
#import "UIImage+Utility.h"
@interface UserInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,strong) URUserInforModel *userInforModel;

@property (nonatomic,strong) UIButton * manButton;

@property (nonatomic,strong) UIButton * womanButton;

@property (nonatomic,strong) UIButton * thumbnailButton;

@property (nonatomic,copy) NSString * thumbnail;

@property (nonatomic,assign) NSInteger  sex;

@property (nonatomic,copy) NSString * birthStr;

@property (nonatomic,copy) NSString * nickNameStr;

@property (nonatomic,copy) NSString * emailStr;

@end

@implementation UserInformationViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    [[URCommonApiManager  sharedInstance] getUserInformationDataWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        self.userInforModel = [URUserInforModel  yy_modelWithDictionary:responseDict[@"data"]] ;
        
        [self.thumbnailButton  sd_setImageWithURL:[NSURL  URLWithString:self.userInforModel.thumbnail] forState:UIControlStateNormal placeholderImage:[UIImage  imageNamed:@"headimg"]];
        
        if ([NSString  isBlank:self.userInforModel.birthday]== NO) {
            
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:self.userInforModel.birthday.integerValue];
            
            NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
            
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            
            NSString* string=[dateFormat stringFromDate:confromTimesp];
            
            self.birthStr = [NSString  stringWithFormat:@"%@",string?:@""] ;
        } else {
            self.birthStr = [NSString  stringWithFormat:@"%@",self.userInforModel.birthday?:@""] ;
        }

        self.thumbnail = [NSString  stringWithFormat:@"%@",self.userInforModel.thumbnail?:@""] ;
        
        self.nickNameStr = [NSString  stringWithFormat:@"%@",self.userInforModel.username?:@""] ;
        
        self.emailStr = [NSString  stringWithFormat:@"%@",self.userInforModel.email?:@""] ;
        
        [self.tableView  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"基本信息" ;
    
    self.view.backgroundColor = UR_ColorFromValue(0xffffff);
    
    self.dataArray = @[@"* 姓名",@"* 性别",@"* 出生日期",@"* 手机号码",@"* 邮箱"];

    [self.cBtnRight setTitle:@"保存" forState:UIControlStateNormal];
    
    self.thumbnailButton = [UIButton  buttonWithType:UIButtonTypeCustom] ;
    [self.thumbnailButton  setImage:[UIImage  imageNamed:@"headimg"] forState:UIControlStateNormal];
    self.thumbnailButton.layer.cornerRadius =50.0f ;
    self.thumbnailButton.layer.masksToBounds = YES ;
    [self.view  addSubview:self.thumbnailButton];
    [self.thumbnailButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20+URSafeAreaNavHeight());
        make.left.mas_equalTo((URScreenWidth()-100)/2) ;
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [[self.thumbnailButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self  selectImageWithAllowsEditing:YES title:@"请选择要上传的图片" completeBlock:^(UIImage * imageName) {
            UIImage *compressImage = [UIImage ur_imageCompression:imageName];
            [self.thumbnailButton  setImage:compressImage forState:UIControlStateNormal];

            [[URCommonApiManager  sharedInstance] sendUploadImageRequestWithFile:compressImage requestSuccessBlock:^(id response, NSDictionary *responseDict) {
                
                self.thumbnail = [NSString  stringWithFormat:@"%@",responseDict[@"data"]] ;
                
            } requestFailureBlock:^(NSError *error, id response) {
                
            }];
            
        }] ;
    }];
    
    [self.view  addSubview:self.tableView];
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(URSafeAreaNavHeight()+140) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), self.dataArray.count * 44));
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * tableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"tableViewCellID"] ;
    if (!tableViewCell) {
        tableViewCell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableViewCellID"];
        tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    
    tableViewCell.textLabel.text = [NSString  stringWithFormat:@"%@",self.dataArray[indexPath.row]] ;
    tableViewCell.textLabel.textColor = UR_ColorFromValue(0x666666) ;
    tableViewCell.textLabel.font=  RegularFont(FontSize15) ;
    
    NSMutableAttributedString * attributedStr = [NSMutableAttributedString  ur_changeColorWithColor:UR_ColorFromValue(0xFF8500) totalString:self.dataArray[indexPath.row] subStringArray:@[@"*"]] ;
    tableViewCell.textLabel.attributedText = attributedStr ;
    
    if (indexPath.row==0 || indexPath.row ==4) {
        UITextField * nameTextFiled = [[UITextField  alloc] init];
        nameTextFiled.text = [NSString  stringWithFormat:@"%@",indexPath.row==0?(self.userInforModel.username?:@""):(self.userInforModel.email?:@"")] ;
        nameTextFiled.tag = 100+indexPath.row ;
        nameTextFiled.textColor = UR_ColorFromValue(0x666666);
        nameTextFiled.font = RegularFont(FontSize15) ;
        nameTextFiled.textAlignment = NSTextAlignmentRight ;
        [tableViewCell.contentView  addSubview:nameTextFiled];
        [nameTextFiled  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10) ;
            make.top.mas_equalTo(0) ;
            make.size.mas_equalTo(CGSizeMake(200, 44)) ;
        }];
        
        [[nameTextFiled  rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(UITextField * x) {
            if (indexPath.row==0) {
                self.nickNameStr = x.text ;
            } else {
                self.emailStr = x.text ;
            }
        }];
    } else if (indexPath.row==3){
        tableViewCell.detailTextLabel.text = [NSString  stringWithFormat:@"%@",self.userInforModel.phone?:@""] ;
        tableViewCell.detailTextLabel.textColor = UR_ColorFromValue(0x666666);
        tableViewCell.detailTextLabel.font = RegularFont(FontSize15) ;
    } else if (indexPath.row==2){
        
        NSString * dateString = [NSString  stringWithFormat:@"%@",self.userInforModel.birthday?:@""] ;
        tableViewCell.detailTextLabel.textColor =UR_ColorFromValue(0x666666);
        tableViewCell.detailTextLabel.font = RegularFont(FontSize15) ;
        if (dateString.length>8) {
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:self.userInforModel.birthday.integerValue];
            
            NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
            
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            
            NSString* string=[dateFormat stringFromDate:confromTimesp];
            
            tableViewCell.detailTextLabel.text = [NSString  stringWithFormat:@"%@",string];
        } else if(dateString.length==8){
            tableViewCell.detailTextLabel.text = [NSString  stringWithFormat:@"%@-%@-%@",[dateString  substringToIndex:4],[[dateString  substringFromIndex:4]substringToIndex:2],[[dateString substringFromIndex:4]substringFromIndex:2]];
        }
        
        tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    } else if (indexPath.row==1){
        
        [tableViewCell.contentView  addSubview:self.womanButton];
        [self.womanButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20) ;
            make.top.mas_equalTo(7) ;
            make.size.mas_equalTo(CGSizeMake(50, 30)) ;
        }];
        
        [tableViewCell.contentView  addSubview:self.manButton];
        [self.manButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.womanButton.mas_left).mas_offset(-30) ;
            make.top.mas_equalTo(7) ;
            make.size.mas_equalTo(CGSizeMake(50, 30)) ;
        }];
        
        self.sex = self.userInforModel.sex.integerValue ;
        
        if (self.userInforModel.sex.integerValue==1) {
            [_manButton setTitleColor:UR_ColorFromValue(0xd4237a) forState:UIControlStateNormal];
            [_manButton setImage:[UIImage  imageNamed:@"nanSelected"] forState:UIControlStateNormal];
            [_womanButton setTitleColor:UR_ColorFromValue(0x777777) forState:UIControlStateNormal];
            [_womanButton setImage:[UIImage  imageNamed:@"nv"] forState:UIControlStateNormal];
        } else {
            [_manButton setTitleColor:UR_ColorFromValue(0x777777) forState:UIControlStateNormal];
            [_manButton setImage:[UIImage  imageNamed:@"nan"] forState:UIControlStateNormal];
            [_womanButton setTitleColor:UR_ColorFromValue(0xd4237a) forState:UIControlStateNormal];
            [_womanButton setImage:[UIImage  imageNamed:@"nvSelected"] forState:UIControlStateNormal];
        }
        
        [self.womanButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [self.manButton  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        
        [[self.womanButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            
            self.sex = 2 ;
           
            [_womanButton setTitleColor:UR_ColorFromValue(0xd4237a) forState:UIControlStateNormal];
            [_womanButton setImage:[UIImage  imageNamed:@"nvSelected"] forState:UIControlStateNormal];
            
            [_manButton setTitleColor:UR_ColorFromValue(0x777777) forState:UIControlStateNormal];
            [_manButton setImage:[UIImage  imageNamed:@"nan"] forState:UIControlStateNormal];
        }];
        
        [[self.manButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
            
            self.sex = 1 ;
            
            [_manButton setTitleColor:UR_ColorFromValue(0xd4237a) forState:UIControlStateNormal];
            [_manButton setImage:[UIImage  imageNamed:@"nanSelected"] forState:UIControlStateNormal];
            
            [_womanButton setTitleColor:UR_ColorFromValue(0x777777) forState:UIControlStateNormal];
            [_womanButton setImage:[UIImage  imageNamed:@"nv"] forState:UIControlStateNormal];
        }];

    }
    
    return tableViewCell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        
        UITableViewCell * tableViewCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]] ;
        
        [BRDatePickerView   showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeYMD defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
            
            tableViewCell.detailTextLabel.text = [NSString  stringWithFormat:@"%@",selectValue] ;
            
            self.birthStr = [NSString  stringWithFormat:@"%@",selectValue] ;
            
        }] ;
    }
}

-(void)navRightPressed:(id)sender{
    
//    UITableViewCell * nickNameTableViewCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] ;
//    UITextField * nickNameTextFiled = (UITextField *)[nickNameTableViewCell  viewWithTag:100] ;
//
//    UITableViewCell * emailTableViewCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]] ;
//    UITextField * emailTextFiled = (UITextField *)[emailTableViewCell  viewWithTag:104] ;
    
    if ([NSString  isBlank:self.nickNameStr]) {
        [URToastHelper  showErrorWithStatus:@"请输入姓名"] ;
    } else if ([NSString  isBlank:self.emailStr]){
        [URToastHelper  showErrorWithStatus:@"请输入邮箱"] ;
    } else if ([NSString  isBlank:self.birthStr]){
        [URToastHelper  showErrorWithStatus:@"请选择出生日期"] ;
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
        [dateFormatter setDateFormat:@"YYYY-MM-dd"]; //设定时间的格式
        NSDate *tempDate = [dateFormatter dateFromString:self.birthStr];//将字符串转换为时间对象
        NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];//字符串转成时间戳,精确到毫秒*1000
        [[URCommonApiManager  sharedInstance] sendChangeUserInformationRequestWithToken:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" thumbnail:self.thumbnail?:@"" sex:[NSString  stringWithFormat:@"%ld",self.sex] birthday:timeStr?:@"" email:self.emailStr?:@"" username:self.nickNameStr?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
            
            [URToastHelper  showErrorWithStatus:[NSString stringWithFormat:@"%@",responseDict[@"msg"]]] ;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        } requestFailureBlock:^(NSError *error, id response) {
            
        }];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.separatorColor = UR_COLOR_LINE;
        _tableView.scrollEnabled = NO ;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0) ;
        _tableView.estimatedRowHeight = 70.0f * AUTO_WIDTH;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO ;
        }
    }
    return _tableView;
}

-(UIButton *)manButton{
    if (!_manButton) {
        _manButton = [UIButton  buttonWithType:UIButtonTypeCustom] ;
        [_manButton setTitle:@"男" forState:UIControlStateNormal];
        [_manButton setTitleColor:UR_ColorFromValue(0x777777) forState:UIControlStateNormal];
        [_manButton setTitleColor:UR_ColorFromValue(0xd4237a) forState:UIControlStateSelected];
        [_manButton setImage:[UIImage  imageNamed:@"nan"] forState:UIControlStateNormal];
        [_manButton setImage:[UIImage  imageNamed:@"nanSelected"] forState:UIControlStateSelected];

    }
    return _manButton ;
}

-(UIButton *)womanButton{
    if (!_womanButton) {
        _womanButton = [UIButton  buttonWithType:UIButtonTypeCustom] ;
        [_womanButton setTitle:@"女" forState:UIControlStateNormal];
        [_womanButton setTitleColor:UR_ColorFromValue(0x777777) forState:UIControlStateNormal];
        [_womanButton setTitleColor:UR_ColorFromValue(0xd4237a) forState:UIControlStateSelected];
        [_womanButton setImage:[UIImage  imageNamed:@"nv"] forState:UIControlStateNormal];
        [_womanButton setImage:[UIImage  imageNamed:@"nvSelected"] forState:UIControlStateSelected];

    }
    return _womanButton ;
}

@end
