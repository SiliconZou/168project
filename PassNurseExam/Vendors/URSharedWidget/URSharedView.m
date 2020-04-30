//
//  URSharedView.m
//  GeneralHospitalPat
//
//  Created by quchao on 2018/4/16.
//  Copyright © 2018年 卓健科技. All rights reserved.
//

#import "URSharedView.h"
#import "URSharedPlatform.h"
#import <UMShare/UMShare.h>

static CGFloat const URShreCancelHeight = 54.0;

@interface URSharedView ()<UIGestureRecognizerDelegate>

//底部view
@property (nonatomic,strong) UIView *bottomPopView;

@property (nonatomic,strong) NSMutableArray *platformArray;

@property (nonatomic,strong) NSMutableArray *buttonArray;

@property (nonatomic,strong) URSharedModel *shareModel;

@property (nonatomic,assign) URShareContentType shareConentType;
@property (nonatomic,assign) CGFloat shreViewHeight;//分享视图的高度


@end

@implementation URSharedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.platformArray = [NSMutableArray array];
        self.buttonArray = [NSMutableArray array];
        
        //初始化分享平台
        [self setUpPlatformsItems];

        //计算分享视图的总高度
        self.shreViewHeight = 164;
        
        for (int i=0; i<self.platformArray.count; i++) {
            URSharedPlatform *platform = self.platformArray[i];
            
            UIButton *shareBut = [[UIButton alloc] init];
            [shareBut setTitle:platform.nameStr forState:UIControlStateNormal];
            [shareBut  setTitleColor:UR_ColorFromValue(0x111111) forState:UIControlStateNormal];
            shareBut.titleLabel.font = [UIFont  systemFontOfSize:14.0f];
            [shareBut setImage:[UIImage imageNamed:platform.iconImageName] forState:UIControlStateNormal];
            [shareBut setImage:[UIImage imageNamed:platform.iconImageName] forState:UIControlStateHighlighted];
            shareBut.frame = CGRectMake(10, 10, 76, 90);
            [shareBut addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
            shareBut.tag = platform.sharedPlatformType;//这句话必须写！！！
            [shareBut  layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleTop imageTitleSpace:10];
            [self.bottomPopView addSubview:shareBut];
            shareBut.frame = CGRectMake(79+(URScreenWidth()-202)*i, 20, 44, 70);
            [self.bottomPopView addSubview:shareBut];
            [self.buttonArray addObject:shareBut];
            
        }
        
        //按钮动画
        for (UIButton *button in self.buttonArray) {
            NSInteger idx = [self.buttonArray indexOfObject:button];
            
            CGAffineTransform fromTransform = CGAffineTransformMakeTranslation(0, 50);
            button.transform = fromTransform;
            button.alpha = 0.3;
            
            [UIView animateWithDuration:0.9+idx*0.1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                button.transform = CGAffineTransformIdentity;
                button.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
            
        }
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setFrame:CGRectMake(0, self.shreViewHeight - URShreCancelHeight, URScreenWidth(), URShreCancelHeight)];
        [cancelButton setTitleColor:UR_ColorFromValue(0x666666) forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [cancelButton setBackgroundColor:UR_ColorFromValue(0xffffff)];
        [cancelButton addTarget:self action:@selector(closeShareView) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomPopView addSubview:cancelButton];
        
        [self addSubview:self.bottomPopView];
        
    }
    return self;
}

#pragma mark - 点击了分享按钮
-(void)clickShare:(UIButton *)sender{
    
    switch (sender.tag) {
        case 1:{
            
            [self  shareWebPageToPlatformType:UMSocialPlatformType_WechatSession withShareWebURL:_shareModel.url withShareTitle:_shareModel.title withDescrString:_shareModel.descr withThumImage:_shareModel.thumbImage] ;
        }
            break;
            
        case 2:{
            [self  shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine withShareWebURL:_shareModel.url withShareTitle:_shareModel.title withDescrString:_shareModel.descr withThumImage:_shareModel.thumbImage] ;

        }
            break;
            
//        case 3:{
//            [self  shareWebPageToPlatformType:UMSocialPlatformType_QQ withShareWebURL:_shareModel.url withShareTitle:_shareModel.title withDescrString:_shareModel.descr withThumImage:_shareModel.thumbImage] ;
//
//        }
//            break;
//
//        case 4:{
//            [self  shareWebPageToPlatformType:UMSocialPlatformType_Qzone withShareWebURL:_shareModel.url withShareTitle:_shareModel.title withDescrString:_shareModel.descr withThumImage:_shareModel.thumbImage] ;
//
//        }
//            break;
            
        default:
            break;
    }
    
    [self closeShareView];
}
#pragma mark - 分享结果处理
-(void)shareResult:(id)result error:(NSError*)error{
    
}

-(UIView *)bottomPopView{
    if (_bottomPopView == nil) {
        _bottomPopView = [[UIView alloc] initWithFrame:CGRectMake(0, URScreenHeight(), URScreenWidth(), self.shreViewHeight)];
        _bottomPopView.backgroundColor = UR_ColorFromValue(0xF6F6F6);
    }
    return _bottomPopView;
}

-(void)urShowShareViewWithDXShareModel:(URSharedModel *)shareModel shareContentType:(URShareContentType)shareContentType{
    self.shareModel = shareModel;
    self.shareConentType = shareContentType;
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3f animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.bottomPopView.frame = CGRectMake(0, URScreenHeight() - self.shreViewHeight, URScreenWidth(), self.shreViewHeight);
    }];
}

#pragma mark - 点击背景关闭视图
-(void)closeShareView{
    [UIView animateWithDuration:.3f animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.bottomPopView.frame = CGRectMake(0, URScreenHeight(), URScreenWidth(), self.shreViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma  mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.bottomPopView]) {
        return NO;
    }
    return YES;
}

#pragma mark 设置平台
-(void)setUpPlatformsItems{
    //微信好友
    URSharedPlatform *wechatSessionModel = [[URSharedPlatform alloc] init];
    wechatSessionModel.iconImageName = @"个人中心-微信";
    wechatSessionModel.sharedPlatformType = URShareTypeWechatSession;
    wechatSessionModel.nameStr = @"微信";
    [self.platformArray addObject:wechatSessionModel];
    
    
    //微信朋友圈
    URSharedPlatform *wechatTimeLineModel = [[URSharedPlatform alloc] init];
    wechatTimeLineModel.iconImageName = @"个人中心-朋友圈";
    wechatTimeLineModel.sharedPlatformType = URShareTypeWechatTimeline;
    wechatTimeLineModel.nameStr = @"朋友圈";
    [self.platformArray addObject:wechatTimeLineModel];

    
//    //QQ好友
//    URSharedPlatform *qqModel = [[URSharedPlatform alloc] init];
//    qqModel.iconImageName = @"QQ";
//    qqModel.sharedPlatformType = URShareTypeQQ;
//    qqModel.nameStr = @"QQ";
//    [self.platformArray addObject:qqModel];
//
//    //QQ空间
//    URSharedPlatform *qqZone = [[URSharedPlatform alloc] init];
//    qqZone.iconImageName = @"QQ空间";
//    qqZone.sharedPlatformType = URShareTypeQzone;
//    qqZone.nameStr = @"QQ空间";
//    [self.platformArray addObject:qqZone];
}

-(void)shareWebPageToPlatformType :(UMSocialPlatformType)platform  withShareWebURL:(NSString *)url withShareTitle:(NSString *)title withDescrString:(NSString *)descr withThumImage:(NSString *)image{
    //创建分享消息对象
    UMSocialMessageObject * messageObject = [UMSocialMessageObject  messageObject] ;
    //创建网页内容对象
    //    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    NSString * shareURL = [[NSString alloc]initWithFormat:@"%@",url];
    // 将链接转译为UTF8因为 codeStr中有中文会导致QQ分享链接出错
    NSString* encodedString = [shareURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    UMShareWebpageObject *shareObject ;
    
    if ([image  hasPrefix:@"https://"] || [image  hasPrefix:@"http://"]) {

        UIImage * thumbURL = [UIImage  imageWithData:[NSData  dataWithContentsOfURL:[NSURL  URLWithString:image]]] ;
                
        shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumbURL] ;
    } else {
        shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:[UIImage  imageNamed:image]] ;
    }
    
    //设置网页地址
    shareObject.webpageUrl = encodedString;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    // 判断是否安装了客户端
    BOOL isInstallClient = [[UMSocialManager  defaultManager]  isInstall:platform];
    if (isInstallClient==YES) {
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platform messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {

            if (error) {
                
            }else{
                
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    NSLog(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    NSLog(@"response originalResponse data is %@",resp.originalResponse);
                }else{
                    NSLog(@"response data is %@",data);
                    
                }
            }
        }];
    }else{
                
        switch (platform) {
                
            case UMSocialPlatformType_WechatSession | UMSocialPlatformType_WechatTimeLine:
                [URToastHelper   showErrorWithStatus:@"分享失败！您尚未安装微信客户端"] ;
                break;
                
            case UMSocialPlatformType_QQ |UMSocialPlatformType_Qzone:
                [URToastHelper   showErrorWithStatus:@"分享失败！您尚未安装QQ客户端"] ;
                break ;
                
            default:
                break;
        }
    }
}

-(void)shareMiniProgramWithDict:(NSDictionary *)dicData {
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:dicData[@"title"] descr:dicData[@"descr"] thumImage:[UIImage imageNamed:dicData[@"imgName"]]];
    shareObject.webpageUrl = dicData[@"shareUrl"];
    shareObject.path = dicData[@"path"];
    shareObject.userName = dicData[@"userName"];
    shareObject.miniProgramType = UShareWXMiniProgramTypeRelease;
    shareObject.hdImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:dicData[@"imgName"] ofType:@"png"]];
    messageObject.shareObject = shareObject;
    // 判断是否安装了客户端
    BOOL isInstallClient = [[UMSocialManager  defaultManager]  isInstall:UMSocialPlatformType_WechatSession];
    if (isInstallClient) {
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            
        }];
    } else {
        [URToastHelper   showErrorWithStatus:@"分享失败！您尚未安装微信客户端"] ;
    }
    
}



@end

