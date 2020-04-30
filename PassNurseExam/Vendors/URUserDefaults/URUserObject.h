//
//  URUserObject.h
//  BeiJingHospital
//
//  Created by qc on 2019/5/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCodingObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface URUserObject : URCodingObject

/**
 当前对象的标识,只读属性
 */
@property( nonatomic,copy,readonly)NSString *identifier;

/**
 在NSUserDefaults创建一个具有标识符的对象.
 @param identifier 唯一标识符,作为归档存储和解档取值的唯一标识.
 */
- (instancetype)initWithIdentifier:(NSString *)identifier;

/**
 在Keychain创建一个具有标识符的对象.
 @param identifier 唯一标识符,作为归档存储和解档取值的唯一标识.
 */
- (instancetype)initKeychainObjectWithIdentifier:(NSString *)identifier;

/**
 存储所有的对象属性
 */
- (void)saveAllPropertyAction;

/**
 删除所有的对象属性
 */
- (void)deleteAllPropertyAction;

/**
 弃用init方法
 */
- (instancetype)init DEPRECATED_MSG_ATTRIBUTE("Please use '- (instancetype)initWithIdentifier:(NSString *)identifier' ");

@end

NS_ASSUME_NONNULL_END
