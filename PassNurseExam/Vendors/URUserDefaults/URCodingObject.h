//
//  URCodingObject.h
//  BeiJingHospital
//
//  Created by qc on 2019/5/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface URCodingObject : NSObject <NSCoding>

// URCodingObject 是利用runtime创建的归档对象,可自定义添加属性

// ❗️❗️❗️❗️❗️属性必须遵循NSCoding协议❗️❗️❗️❗️❗️

/**
 不需要归档的属性名称集合
 */
@property(nonatomic,copy)NSArray <NSString *>*unEncodePropertys;


/**
 是否需要管理提示Log打印,默认为NO
 */
@property(nonatomic,assign)BOOL closeAlertLog;


@end

NS_ASSUME_NONNULL_END
