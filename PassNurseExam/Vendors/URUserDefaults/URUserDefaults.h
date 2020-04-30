//
//  URUserDefaults.h
//  BeiJingHospital
//
//  Created by qc on 2019/5/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URUserObject.h"
#import "URUserInforModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface URUserDefaults : URUserObject

// URUserDefaults 是用户偏好设置存储单例对象.

+ (instancetype)standardUserDefaults;

// 请在下方添加你所需要保存的属性,注意要遵循NSCoding协议,或者继承于SDCodingObject类 ❗️❗️❗️❗️❗️暂不支持int,float,BOOL等类型❗️❗️❗️❗️❗️

@property (nonatomic,strong) URUserInforModel * userInforModel;


@end

NS_ASSUME_NONNULL_END
