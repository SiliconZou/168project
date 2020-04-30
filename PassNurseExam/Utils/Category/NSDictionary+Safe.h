//
//  NSDictionary+Safe.h
//  HSKCommon
//
//  Created by Carl on 2016/11/24.
//  Copyright © 2016年 Carl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (Safe)

- (NSString *)stringObjectForKey:(id <NSCopying>)key;

- (ObjectType)safeObjectForKey:(id <NSCopying>)key;

- (KeyType)safeKeyForObject:(id)object;

@end


@interface NSMutableDictionary(Safe)

- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end
