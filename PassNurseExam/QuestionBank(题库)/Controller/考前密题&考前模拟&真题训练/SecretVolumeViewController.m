//
//  SecretVolumeViewController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "SecretVolumeViewController.h"
#import "SecretVolumeCell.h"
#import "TrainingViewController.h"


static NSString * const SecretVolumeCellIdentifier = @"SecretVolumeCellIdentifier";

@interface SecretVolumeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) SecretVolumeModel * volumeModel ;

@property (nonatomic,strong) UICollectionView * secretCollection;

@end

@implementation SecretVolumeViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    @weakify(self) ;
    [[URCommonApiManager  sharedInstance] getSecretVolumeDataWithSubjectID:self.secondaryClassificationID?:@"" token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        @strongify(self) ;
        
        self.volumeModel = response ;
        
        [self.secretCollection  reloadData];
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.cSuperTitle = @"考前密题";
    [self.view addSubview:self.secretCollection];
    [self.secretCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(URSafeAreaNavHeight());
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.volumeModel.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecretVolumeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SecretVolumeCellIdentifier forIndexPath:indexPath];
    
    SecretVolumeDataModel *model = self.volumeModel.data[indexPath.item];
    cell.titleLb.text = model.name;
    cell.typeLb.text = [NSString stringWithFormat:@"(%@)",model.category];
    cell.countLb.text = [NSString stringWithFormat:@"本卷共%@题",model.quantity];
    cell.timeLb.text = [NSString stringWithFormat:@"%@分钟",model.duration];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TrainingViewController * viewController  = [[TrainingViewController alloc] init];
    
    SecretVolumeDataModel *model = self.volumeModel.data[indexPath.item];

    viewController.subjectsStr = model.category;
    viewController.secretVolume = model.idStr;
    viewController.testType = TestType_Secret;
    viewController.examName = model.category;
    viewController.primaryClassificationID = self.primaryClassificationID?:@"";
    viewController.secondaryClassificationID = self.secondaryClassificationID?:@"" ;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UICollectionView *)secretCollection
{
    if (!_secretCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(153 * AUTO_WIDTH, 202 * AUTO_WIDTH);
        layout.minimumLineSpacing = 27 * AUTO_WIDTH;
        layout.minimumInteritemSpacing = 25 * AUTO_WIDTH;
        layout.sectionInset = UIEdgeInsetsMake(24 * AUTO_WIDTH, 22 * AUTO_WIDTH, 0,  22 * AUTO_WIDTH);
        _secretCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _secretCollection.delegate = self;
        _secretCollection.dataSource = self;
        _secretCollection.backgroundColor = [UIColor whiteColor];
        _secretCollection.showsVerticalScrollIndicator = NO;
        _secretCollection.showsHorizontalScrollIndicator = NO;
        
        [_secretCollection registerClass:[SecretVolumeCell class] forCellWithReuseIdentifier:SecretVolumeCellIdentifier];
    }
    return _secretCollection;
}
@end
