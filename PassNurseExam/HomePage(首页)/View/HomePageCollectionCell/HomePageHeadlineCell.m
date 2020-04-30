//
//  HomePageHeadlineCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "HomePageHeadlineCell.h"

@interface HomePageHeadlineCell ()<LMJVerticalScrollTextDelegate>

@property (nonatomic ,strong) LMJVerticalScrollText * scrollTextTop ;

@property (nonatomic ,strong) LMJVerticalScrollText * scrollTextSecond ;

@property (nonatomic,strong) NSMutableArray * topArray;

@property (nonatomic,strong) NSMutableArray * secondArray;

@property (nonatomic,strong) NSMutableArray * topURLArray;

@property (nonatomic,strong) NSMutableArray * secondURLArray;

@end

@implementation HomePageHeadlineCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
        
        self.topArray = [NSMutableArray  arrayWithCapacity:0] ;
        
        self.secondArray = [NSMutableArray  arrayWithCapacity:0] ;
        
        self.topURLArray = [NSMutableArray  arrayWithCapacity:0] ;
        
        self.secondURLArray = [NSMutableArray  arrayWithCapacity:0] ;

    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.logo];
//    [self.contentView addSubview:self.dian1];
//    [self.contentView addSubview:self.dian2];

    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60 * AUTO_WIDTH, 23 * AUTO_WIDTH));
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_offset(15 * AUTO_WIDTH);
    }];
//    [self.dian1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(4 * AUTO_WIDTH, 4 * AUTO_WIDTH));
//        make.centerY.mas_equalTo(self.contentView).multipliedBy(0.6);
//        make.left.mas_offset(65 * AUTO_WIDTH);
//    }];
//    [self.dian2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(4* AUTO_WIDTH, 4 * AUTO_WIDTH));
//        make.centerY.mas_equalTo(self.contentView).multipliedBy(1.4);
//        make.left.mas_offset(65 * AUTO_WIDTH);
//    }];
    
    self.scrollTextTop = [[LMJVerticalScrollText  alloc] initWithFrame:CGRectMake(80 * AUTO_WIDTH, 6*AUTO_WIDTH, (URScreenWidth()-120)* AUTO_WIDTH,30* AUTO_WIDTH)];
    self.scrollTextTop.delegate = self ;
    self.scrollTextTop.textColor = UR_ColorFromValue(0x666666);
    self.scrollTextTop.textFont = RegularFont(FontSize14) ;
    self.scrollTextTop.scrollAnimationTime = 2.0f ;
    self.scrollTextTop.textDataArr = @[@"医护头条内容医护头条内容医护头条内容医护"] ;
    [self.scrollTextTop startScrollBottomToTopWithSpace];
    [self.contentView addSubview:self.scrollTextTop];
    
    self.scrollTextSecond = [[LMJVerticalScrollText  alloc] initWithFrame:CGRectMake(80 * AUTO_WIDTH, 32 *AUTO_WIDTH, (URScreenWidth()-90)* AUTO_WIDTH,30* AUTO_WIDTH)];
    self.scrollTextSecond.delegate = self ;
    self.scrollTextSecond.textColor = UR_ColorFromValue(0x666666);
    self.scrollTextSecond.textFont = RegularFont(FontSize14) ;
    self.scrollTextSecond.scrollAnimationTime = 2.0f ;
    self.scrollTextSecond.textDataArr = @[@"医护头条内容医护头条内容医护头条内容医护"] ;
    [self.scrollTextSecond startScrollBottomToTopWithSpace];
//    [self.contentView addSubview:self.scrollTextSecond];

}

-(void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray ;
    
    @weakify(self) ;
    [dataArray  enumerateObjectsUsingBlock:^(HomePageCourseTitleBannerModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        @strongify(self) ;
        /*
        if (idx%2==1) {
            [self.secondArray  addObject:obj.title];
            [self.secondURLArray  addObject:obj.url];

        } else {
            [self.topArray  addObject:obj.title];
            [self.topURLArray  addObject:obj.url];

        }
        */
        [self.topArray  addObject:obj.title];
        [self.topURLArray  addObject:obj.url];
    }] ;
    
    if (self.topArray.count>0) {
        self.scrollTextTop.textDataArr = self.topArray ;
    }
    
//    if (self.secondArray.count>0) {
//        self.scrollTextSecond.textDataArr = self.secondArray ;
//    }
    
}

#pragma mark - LMJVerticalScrollTextDelegate
- (void)verticalScrollText:(LMJVerticalScrollText *)scrollText clickIndex:(NSInteger)index content:(NSString *)content{
    if ([scrollText  isEqual:self.scrollTextTop]) {
        
        NSString * urlString = [NSString  stringWithFormat:@"%@",self.topURLArray[index]] ;
        
        if ([NSString isBlank:urlString]==NO){
            URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:urlString];
            wkWebViewController.hidesBottomBarWhenPushed = YES ;
            wkWebViewController.itemTitle = [NSString  stringWithFormat:@"%@",content?:@""] ;
            [self.currentViewController.navigationController pushViewController:wkWebViewController animated:YES];
        }
        
    } else if ([scrollText  isEqual:self.scrollTextSecond]){
        NSString * urlString = [NSString  stringWithFormat:@"%@",self.secondURLArray[index]] ;
        
        if ([NSString isBlank:urlString]==NO){
            URWKWebViewController * wkWebViewController = [[URWKWebViewController  alloc] initWithLinkUrl:urlString];
            wkWebViewController.hidesBottomBarWhenPushed = YES ;
            wkWebViewController.itemTitle = [NSString  stringWithFormat:@"%@",content?:@""] ;
            [self.currentViewController.navigationController pushViewController:wkWebViewController animated:YES];
        }
    }
}

- (UIImageView *)logo {
    if (_logo == nil) {
        _logo = [[UIImageView alloc]init];
        _logo.image = [UIImage imageNamed:@"home_toutiao"];
    }
    return _logo;
}

-(UIImageView *)dian1
{
    if (!_dian1) {
        _dian1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_dian"]];
    }
    return _dian1;
}

-(UIImageView *)dian2
{
    if (!_dian2) {
        _dian2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_dian"]];
    }
    return _dian2;
}

//- (UILabel *)contentLb1 {
//    if (_contentLb1 == nil) {
//        _contentLb1 = [UILabel normalLabelWithTitle:@"医护头条内容医护头条内容医护头条内容医护" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
//    }
//    return _contentLb1;
//}
//
//- (UILabel *)contentLb2 {
//    if (_contentLb2 == nil) {
//        _contentLb2 = [UILabel normalLabelWithTitle:@"医护头条内容医护头条内容医护头条内容" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
//    }
//    return _contentLb2;
//}



@end
