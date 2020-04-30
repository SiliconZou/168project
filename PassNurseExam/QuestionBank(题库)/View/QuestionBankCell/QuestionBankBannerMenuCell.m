//
//  QuestionBankBannerMenuCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/24.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "QuestionBankBannerMenuCell.h"

@implementation QuestionBankBannerMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{ 
    [self.contentView addSubview:self.cycleScrollView];
    [self.contentView addSubview:self.menu];
    
    self.menu.frame = CGRectMake(0, self.cycleScrollView.bottom, URScreenWidth(), 50 * 2 * AUTO_WIDTH + 1);
}

-(void)setBannerArray:(NSArray *)bannerArray{
    
    _bannerArray = bannerArray ;
    self.cycleScrollView.imageURLStringsGroup = bannerArray ;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSString * linkURL = [NSString  stringWithFormat:@"%@",self.bannerArray[index] ?:@""] ;
    if ([NSString  isBlank:linkURL]==NO) {
        URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:linkURL];
        wkWebViewController.hidesBottomBarWhenPushed = YES ;

        [[self getCurrentVC].navigationController pushViewController:wkWebViewController animated:YES];
    }
}


-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        NSArray *imageNames = @[
                                @"banner",
                                @"banner"
                                ];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, URScreenWidth(), 146 * AUTO_WIDTH) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        _cycleScrollView.autoScrollTimeInterval = 3.0;
        _cycleScrollView.delegate = self ;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter ;
    }
    return _cycleScrollView ;
}

- (CourseHomeMenuView *)menu
{
    if (!_menu) {
        _menu = [[CourseHomeMenuView alloc] init];
    }
    return _menu;
}

@end
