//
//  NELiveDetailModel.h
//  PassTheNurseExam
//
//  Created by Best on 2019/2/15.
//  Copyright © 2019 LeFu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NELiveDetailState) {
    ///未预约
    NELiveDetailStateNone = 1,
    ///已预约
    NELiveDetailStateAppointment,
    ///管理员
    NELiveDetailStateManager,
};

NS_ASSUME_NONNULL_BEGIN

@interface NELiveDetailUserItem : NSObject

@property (nonatomic, copy) NSString *user_url;
@property (nonatomic, copy) NSString *username;

@end

@interface NELiveDetailItem : NSObject

@property (nonatomic, assign) NSInteger charge;
@property (nonatomic, copy) NSString *lb_content;
@property (nonatomic, copy) NSString *lb_handout;
@property (nonatomic, copy) NSString *lb_id;
@property (nonatomic, copy) NSString *lb_time;
@property (nonatomic, copy) NSString *lb_url;
///单位：分
@property (nonatomic, copy) NSString *money;
@property (nonatomic, assign) NELiveDetailState state;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *lb_gonggao;
@property (nonatomic, copy) NSString *userNumber;

@property (nonatomic, copy) NSArray <NELiveDetailUserItem *>*userList;

///客户端处理字段
@property (nonatomic, copy) NSString *stateTitle;
@property (nonatomic, strong) UIColor *stateColor;
@property (nonatomic, copy) NSString *userNumberStr;


@end

@interface NELiveAppointmentModel : NSObject

///预约返回信息
@property (nonatomic, copy) NSString *order_number;
///单位：元
@property (nonatomic, copy) NSString *money;
///课程收费 1没费 2收费
@property (nonatomic, assign) NSInteger state;

@end

@interface NELiveUrlModel : NSObject

///客户端处理字段
///1 手机 2电脑
@property (nonatomic, assign) NSInteger videoSourceType;
///视频源地址
@property (nonatomic, copy) NSString *nameUrl;
///剩余时间
@property (nonatomic, assign) NSTimeInterval shengyTime;
///预约状态
@property (nonatomic, assign) NELiveDetailState state;

@end


@interface NELiveDetailModel : NSObject

@property (nonatomic, strong) LiveSectionDetailModel * detailModel;

///1用户个人未禁言 2用户个人被禁言
@property (nonatomic, assign) NSInteger forbiddenUid;
///1未全体禁言 2全体用户禁言	
@property (nonatomic, assign) NSInteger forbidden;



+ (NSDictionary *)getTestData;

@end

NS_ASSUME_NONNULL_END


/*
 beanList    直播详情    object
 beanList.charge    收费 1 免费 2收费    number
 beanList.lb_content    老师简介    string
 beanList.lb_handout    讲义地址    string
 beanList.lb_id    直播ID    number
 beanList.lb_time    直播时间    string
 beanList.lb_url    直播图片    string
 beanList.money    金额    string
 beanList.state    预约状态 1 未预约 2已预约 3 管理员    number
 beanList.title    标题    string
 return_message        string
 return_code        number
 beanList.lb_gonggao    公告地址    string
 beanList.userList.user_url    播看用户头像    string
 beanList.userList.username    播看用户名称    string
 beanList.userList    博看用户列表    array
 beanList.userNumber    在线人数    number
 forbiddenUid    1用户个人未禁言 2用户个人被禁言    number
 forbidden    1未全体禁言 2全体用户禁言    number
 */


/*
 获取播流地址
 {
 "nameUrl":"rtmp://bl.dianshiedu.cn/DSHZS201901021900/DSHZS201901021900",
 "state":2,
 "return_message":"获取成功",
 "return_code":"1000",
 "shengyTime":300
 }
 */
