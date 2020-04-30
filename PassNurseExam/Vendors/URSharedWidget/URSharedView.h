//
//  URSharedView.h
//  GeneralHospitalPat
//
//  Created by quchao on 2018/4/16.
//  Copyright © 2018年 卓健科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URSharedModel.h"

typedef NS_ENUM(NSUInteger , URShareType) {
    URShareTypeWechatSession    = 1,               //微信好友
    URShareTypeWechatTimeline   = 2,               //微信朋友圈
    URShareTypeQQ               = 3,               //QQ好友
    URShareTypeQzone            = 4,               //QQ空间
    URShareTypeUrl              = 5,              //链接
};

typedef NS_ENUM(NSUInteger , URShareContentType) {
    URShareContentTypeText    = 1,               //文本分享
    URShareContentTypeImage   = 2,               //图片分享
    URShareContentTypeLink    = 3,               //链接分享
    //...其它自行扩展
};

@interface URSharedView : UIView

/**
分享视图弹窗

@param shareModel 分享的数据
@param shareContentType 分享类型
*/
-(void)urShowShareViewWithDXShareModel:(URSharedModel*)shareModel shareContentType:(URShareContentType)shareContentType;

-(void)shareMiniProgramWithDict:(NSDictionary *)dicData;
-(void)closeShareView ;

@end
