//
//  NSDictionary+Safe.m
//  HSKCommon
//
//  Created by Carl on 2016/11/24.
//  Copyright © 2016年 Carl. All rights reserved.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)

- (NSString *)stringObjectForKey:(id <NSCopying>)key {
    id ob = [self objectForKey:key];
    if(ob == [NSNull null] || ob == nil) {
        return (@"");
    }
    if([ob isKindOfClass:[NSString class]]) {
        return (ob);
    }
    return ([NSString stringWithFormat:@"%@", ob]);
}

- (id)safeObjectForKey:(id<NSCopying>)aKey
{
    if (aKey != nil) {
        return [self objectForKey:aKey];
    } else {
        return nil;
    }
}

- (id)safeKeyForObject:(id)object {
    for (id key in self.allKeys) {
        if ([object isEqual:[self objectForKey:key]]) {
            return object;
        }
    }
    return nil;
}

@end


@implementation NSMutableDictionary(Safe)

- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if(!aKey || !anObject) {
        NSLog(@"--- setObject:forKey: key must not nil");
    } else {
        [self setObject:anObject forKey:aKey];
    }
}

@end
