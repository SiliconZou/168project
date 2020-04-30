//
//  MyClassLifeImgCell.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "MyClassLifeImgCell.h"

static NSString * const MyClassLifeImgCollectionCellIdentifier = @"MyClassLifeImgCollectionCellIdentifier";

@interface MyClassLifeImgCollectionCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imgView;

@end


@implementation MyClassLifeImgCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.contentView.backgroundColor = UR_ColorFromValue(0xffffff);
    
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.size.mas_equalTo(CGSizeMake(113 * AUTO_WIDTH, 113 * AUTO_WIDTH));
    }];
    self.imgView.backgroundColor = [UIColor blueColor];
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1570785554423&di=e331ebade9b8bdca1653479427c813b4&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201510%2F15%2F20151015212545_E8Tjk.jpeg"]];
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}


@end



@implementation MyClassLifeImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createView];
    }
    return  self;
}

- (void)createView
{
    self.contentView.backgroundColor = UR_ColorFromValue(0xffffff);
    [self.contentView addSubview:self.collection];
    
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_greaterThanOrEqualTo(113 * 3 * AUTO_WIDTH + 4 * 2 * AUTO_WIDTH);
        make.top.mas_offset(6 * AUTO_WIDTH);
        make.bottom.mas_offset(-6 * AUTO_WIDTH);
    }];
}

- (void)setImgsArr:(NSArray *)imgsArr
{
    _imgsArr = imgsArr;
    [self.collection reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyClassLifeImgCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MyClassLifeImgCollectionCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (UICollectionView *)collection{
    if (!_collection) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(113 * AUTO_WIDTH, 113 * AUTO_WIDTH);
        layout.minimumInteritemSpacing = 4 * AUTO_WIDTH;
        layout.minimumLineSpacing = 4 * AUTO_WIDTH;
        
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.alwaysBounceVertical = YES;
        _collection.scrollEnabled = NO;
        
        [_collection registerClass:[MyClassLifeImgCollectionCell class] forCellWithReuseIdentifier:MyClassLifeImgCollectionCellIdentifier];
    }
    return _collection;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
