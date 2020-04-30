//
//  URKeychainUserDefaults.h
//  BeiJingHospital
//
//  Created by qc on 2019/5/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URUserObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface URKeychainUserDefaults : URUserObject

//URKeychainUserDefaults 是存储于Keychain中的单例对象.在安全性相比于URUserDefaults更高,但是在越狱手机上仍然存在风险.

+ (instancetype)standardUserDefaults;

// 请在下方添加你所需要保存的属性,注意要遵循NSCoding协议,或者继承于URCodingObject类 ❗️❗️❗️❗️❗️暂不支持int,float,BOOL等类型❗️❗️❗️❗️❗️

@end

NS_ASSUME_NONNULL_END
