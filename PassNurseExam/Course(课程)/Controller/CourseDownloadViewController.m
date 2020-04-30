//
//  CourseDownloadViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/19.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseDownloadViewController.h"
#import "CourseDownloadTableViewCell.h"

@interface CourseDownloadViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

//@property (nonatomic,strong) UIButton * sectionSelectedButton;

@property (nonatomic,assign) BOOL sectionIsShow;


@end

@implementation CourseDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = @"下载课程" ;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
        make.height.mas_equalTo(URScreenHeight()-URSafeAreaNavHeight());
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.detailModel.data.count ;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailModel.data[section].selected? self.detailModel.data[section].curriculums.count:0 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseDownloadTableViewCell * downloadTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"CourseDownloadTableViewCellID"] ;
    
    if (!downloadTableViewCell) {
        downloadTableViewCell = [[NSBundle  mainBundle] loadNibNamed:@"CourseDownloadTableViewCell" owner:self options:nil][0];
        downloadTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    
    CourseCommonDetailDataCurriculumsModel *curriculumsModel = self.detailModel.data[indexPath.section].curriculums[indexPath.row] ;
    downloadTableViewCell.curriculumsModel = curriculumsModel ;
    
    if (curriculumsModel.downloadStatus == TaskIsDownloading) {
        [downloadTableViewCell pause];
        [downloadTableViewCell start];
    }
    
    downloadTableViewCell.bBackVideoBlock = ^(NSString * _Nonnull str) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        if (self.backVideoPathBlock) {
            self.backVideoPathBlock(str);
        }
    };
    
    return downloadTableViewCell ;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, URScreenWidth(), 44)];
    headerView.backgroundColor = UR_ColorFromRGB(229, 241, 254);
    
    CourseCommonDetailDataModel *sectionModel = self.detailModel.data[section];
    UIButton *sectionSelectedButton = [[UIButton  alloc] init];
    [sectionSelectedButton setImage:[UIImage imageNamed:sectionModel.selected ? @"jiantous" : @"下"] forState:UIControlStateNormal];
    sectionSelectedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    [headerView  addSubview:sectionSelectedButton];
    [sectionSelectedButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10) ;
        make.top.bottom.mas_offset(0) ;
        make.left.mas_equalTo(10) ;
    }];
    
    [[sectionSelectedButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.detailModel.data enumerateObjectsUsingBlock:^(CourseCommonDetailDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == section) {
                obj.selected = !obj.selected;
            }else {
                obj.selected = NO;
            }
            
        }];
        [self.tableView reloadData];
        
    }];
    
    UILabel * sectionTitle = [[UILabel  alloc] init];
    sectionTitle.textColor = UR_ColorFromValue(0x333333);
    sectionTitle.font = RegularFont(16.0f) ;
    [headerView  addSubview:sectionTitle];
    [sectionTitle  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10) ;
        make.top.mas_equalTo(10) ;
        make.size.mas_equalTo(CGSizeMake(URScreenWidth()-44, 24)) ;
    }];
    
    sectionTitle.text = [NSString  stringWithFormat:@"%@",self.detailModel.data[section].name?:@""] ;
    
    return headerView ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44 ;
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
        _tableView.estimatedRowHeight = 44.0f;
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
