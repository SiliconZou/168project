//
//  HomePageBannerCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomePageBannerCell.h"

#define dotW 29 * AUTO_WIDTH
#define dotH 2
#define  magrin 11

@implementation HMPageControl

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++)
    {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        subview.layer.cornerRadius = 0;
        CGSize size;
        size.height = dotH;
        size.width = dotW;
        subview.layer.borderColor = UR_ColorFromValue(0x9B89FF).CGColor;
        subview.layer.borderWidth = 0.5;

        if (subviewIndex == currentPage)
        {
            subview.backgroundColor = UR_ColorFromValue(0x9B89FF);
        }
        else
        {
            subview.backgroundColor = UR_ColorFromValue(0xFFFFFF);
        }
        
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,size.width,size.height)];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //计算圆点间距
    CGFloat marginX = dotW + magrin;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX;
    
    //设置新frame
    self.frame = CGRectMake(URScreenWidth()/2-(newW + dotW)/2, self.frame.origin.y, newW + dotW, self.frame.size.height);
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
        }
    }
}


@end


@implementation HomePageBannerCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    UIImageView *topBgImg = [[UIImageView new] initWithImage:[UIImage imageNamed:@"home_bg"]];
    [self.contentView addSubview:topBgImg];
    [topBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(URScreenWidth(), 160 * AUTO_WIDTH));
    }];
    
    [self.contentView addSubview:self.bannerView];
//    [self.contentView addSubview:self.hmPage];
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(348 * AUTO_WIDTH, 140 * AUTO_WIDTH));
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_offset(8 * AUTO_WIDTH);
    }];
    
//    CGFloat pag_w = dotW * 3 + magrin * 2;
//    
//    [self.hmPage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.contentView);
//        make.size.mas_equalTo(CGSizeMake(pag_w, 13));
//        make.top.mas_equalTo(self.bannerView.mas_bottom).offset(10*AUTO_WIDTH);
//    }];
    
    self.bannerView.imageURLStringsGroup =
    @[@"http://gcyl168.com/upload/images/sybanner4.png",
    @"http://gcyl168.com/upload/images/sybanner5.png",
    @"http://gcyl168.com/upload/images/sybanner6.png"];
    
    self.hmPage.numberOfPages = 3;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSString *type = self.homePageModel.data2[index].type;
    NSString * linkURL = [NSString  stringWithFormat:@"%@",self.homePageModel.data2[index].value?:@""] ;
    if ([type isEqualToString:@"web"]) {
        URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:linkURL];
        wkWebViewController.hidesBottomBarWhenPushed = YES ;
        //    wkWebViewController.itemTitle = [NSString  stringWithFormat:@"%@",self.homePageModel.data2[index].title?:@""] ;
        [self.currentViewController.navigationController pushViewController:wkWebViewController animated:YES];

    } else if ([type isEqualToString:@"init"]) {
        NSLog(@"轮播图点击");
    }
    NSLog(@"轮播图点击");
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.hmPage.currentPage = index;
}

-(void)setHomePageModel:(HomePageModel *)homePageModel{
    _homePageModel = homePageModel ;
    
    NSMutableArray * imageArray = [NSMutableArray  arrayWithCapacity:0] ;
    
    [homePageModel.data2 enumerateObjectsUsingBlock:^(HomePageCourseBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imageArray  addObject:obj.thumbnail];
    }];
    
    if (imageArray.count>0) {
        self.bannerView.imageURLStringsGroup = imageArray ;
//        self.hmPage.numberOfPages = imageArray.count;
        
    }
}

-(SDCycleScrollView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _bannerView.autoScrollTimeInterval = 4;
        _bannerView.layer.cornerRadius = 16;
        _bannerView.layer.masksToBounds = YES;
        
        _bannerView.showPageControl = YES;
 
    }
    return _bannerView;
}

- (HMPageControl *)hmPage
{
    if (!_hmPage) {
        _hmPage = [[HMPageControl alloc] init];
    }
    return _hmPage;
}

@end
