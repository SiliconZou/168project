//
//  UserSettingViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/30.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserSettingViewController.h"
#import "ForgotPasswordViewController.h"

@interface UserSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray * dataArray;


@end

@implementation UserSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.lblTitle.text = @"设置" ;
    
    self.dataArray = @[@[@"清理缓存",@""],@[@"修改密码",@"ForgotPasswordViewController"],@[@"关于我们",@"AboutUSViewController"],@[@"意见反馈",@"FeedBackViewController"],@[@"当前版本号",@""]] ;
    
    [self.view  addSubview:self.tableView];
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0) ;
        make.top.mas_equalTo(URSafeAreaNavHeight()) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), URScreenHeight()-URSafeAreaNavHeight()));
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
    
    tableViewCell.textLabel.text = [NSString  stringWithFormat:@"%@",self.dataArray[indexPath.row][0]] ;
    tableViewCell.textLabel.font = RegularFont(15.0f);
    tableViewCell.textLabel.textColor = UR_ColorFromValue(0x333333) ;
    
    tableViewCell.detailTextLabel.textColor = UR_ColorFromValue(0x333333) ;
    tableViewCell.detailTextLabel.font = RegularFont(15.0f);
    tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;

    if (indexPath.row==0) {
        tableViewCell.detailTextLabel.text = [NSString  stringWithFormat:@"%.2fMB",URGetCachSize()] ;
    } else if (indexPath.row==4){
        tableViewCell.detailTextLabel.text = [NSString  stringWithFormat:@"%@",URAppVersion()] ;
        tableViewCell.accessoryType = UITableViewCellAccessoryNone ;
    }
    
    return tableViewCell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [URAlert  alertViewWithStyle:URAlertStyleAlert title:@"温馨提示" message:@"是否要清除应用缓存？" cancelButtonTitle:@"不清除" sureButtonTitles:@"清除" viewController:self handler:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                [[SDImageCache sharedImageCache] clearMemory];
                [[SDImageCache sharedImageCache] clearWithCacheType:SDImageCacheTypeDisk completion:nil];
                NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
                [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
                
                [self.tableView  reloadData];
            }
        }];
    } else {
        if (indexPath.row==1) {
            
            ForgotPasswordViewController * passViewController = [[ForgotPasswordViewController alloc] init];
            passViewController.hidesBottomBarWhenPushed = YES ;
            passViewController.type = 2 ;
            [self.navigationController pushViewController:passViewController animated:YES];
            
        } else if (indexPath.row>1 && indexPath.row<4){
            UIViewController * viewController = [NSClassFromString(self.dataArray[indexPath.row][1]) new] ;
            
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01 ;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UR_COLOR_BACKGROUND_ALL;
        _tableView.separatorColor = UR_COLOR_LINE;
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

@end
