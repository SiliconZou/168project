//
//  NSString+JSON.h
//  BeiJingHospital
//
//  Created by qc on 2019/5/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JSON)


+(NSString *)convertToJsonData:(NSDictionary *)dict ;

@end

NS_ASSUME_NONNULL_END
