//
//  URSharedModel.h
//  GeneralHospitalPat
//
//  Created by quchao on 2018/4/16.
//  Copyright © 2018年 卓健科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URSharedModel : NSObject

//分享标题 只分享文本是也用这个字段
@property (nonatomic,copy) NSString *title;
//描述内容
@property (nonatomic,copy) NSString *descr;
//缩略图
@property (nonatomic,strong) id thumbImage;
//链接
@property (nonatomic,copy) NSString *url;

@end
