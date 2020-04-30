//
//  WXCallBackManager.m
//  PassNurseExam
//
//  Created by quchao on 2019/10/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "WXCallBackManager.h"

@interface WXCallBackManager ()<WXApiDelegate>

@end

@implementation WXCallBackManager

+(WXCallBackManager *)sharedInstance{
    
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        
        return [[self alloc] init];
    });
    
}

- (id)init{
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)sendWXAuthReq{
    
    if ([WXApi isWXAppInstalled]) {
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        
//        [WXApi sendReq:req];//发起微信授权请求
        [WXApi sendAuthReq:req viewController:[self getCurrentVC] delegate:self completion:^(BOOL success) {
            NSLog(@"请求%d",success);
        }];
        
    } else {
        [URToastHelper  showErrorWithStatus:@"请安装微信客户端"] ;
    }
}

-(BOOL)handleOpenURL:(NSURL *)url{
    if([url.host isEqualToString:@"platformId=wechat"] || [url.host isEqualToString:@"oauth"]){//微信WeChat分享及授权啊回调
        return [WXApi handleOpenURL:url delegate:self];
    }else if([url.host  isEqualToString:@"pay"]){ // 微信支付
        return [WXApi handleOpenURL:url delegate:self];
    } else {
        return NO;
    }
}

//微信回调代理
- (void)onResp:(BaseResp *)resp{
    
    // =============== 获得的微信登录授权回调 ============
    if ([resp isMemberOfClass:[SendAuthResp class]])  {
        NSLog(@"******************获得的微信登录授权******************");
        
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode != 0 ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [URToastHelper  showErrorWithStatus:@"微信授权失败"] ;
            });
            return;
        }
        //授权成功获取 OpenId
        NSString *code = aresp.code;
        [self getWeiXinOpenId:code];
    }
    
    // =============== 获得的微信支付回调 ============
    if([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp *)resp;
        switch (response.errCode)
        {
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                //支付返回结果，实际支付结果需要去微信服务器端查询
                [[NSNotificationCenter  defaultCenter] postNotificationName:@"PaySuccessNoti" object:nil userInfo:nil];
                break;
            case WXErrCodeUserCancel:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                //交易取消
                [URToastHelper  showErrorWithStatus:@"已取消支付"] ;
                break;
            default:
                NSLog(@"支付失败， retcode=%d",resp.errCode);
                [URToastHelper  showErrorWithStatus:@"支付失败"] ;
                break;
        }
    }
}

//通过code获取access_token，openid，unionid
- (void)getWeiXinOpenId:(NSString *)code{
    /*
     appid    是    应用唯一标识，在微信开放平台提交应用审核通过后获得
     secret    是    应用密钥AppSecret，在微信开放平台提交应用审核通过后获得
     code    是    填写第一步获取的code参数
     grant_type    是    填authorization_code
     */
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXAppID,WXAppSecret,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data1 = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        
        if (!data1) {
            [URToastHelper  showErrorWithStatus:@"微信授权失败"] ;
            return ;
        }
        
        // 授权成功，获取token、openID字典
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"token、openID字典===%@",dic);
       
        NSDictionary * paramsDict = @{
                                      @"access_token":dic[@"access_token"]?:@"",
                                      @"expires_in":dic[@"expires_in"]?:@"",
                                      @"openid":dic[@"openid"]?:@"",
                                      @"refresh_token":dic[@"refresh_token"]?:@"",
                                      @"scope":dic[@"scope"]?:@"",
                                      @"unionid":dic[@"unionid"]?:@"",
                                      @"code":code?:@""
                                      } ;
        
        [[NSNotificationCenter  defaultCenter] postNotificationName:@"WXLogInNotification" object:nil userInfo:paramsDict];
        
    });
}

@end
