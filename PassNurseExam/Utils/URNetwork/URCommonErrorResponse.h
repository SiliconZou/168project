//
//  URCommonErrorResponse.h
//  BeiJingHospital
//
//  Created by qc on 2019/5/8.
//  Copyright © 2019 ucmed. All rights reserved.
//  处理错误信息

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface URCommonErrorResponse : NSObject

@property (nonatomic,copy) NSString *returnCode;

@property (nonatomic,copy) NSString *returnMsg;

@property (nonatomic,assign) id returnData;

- (NSInteger)httpResponseCode;

@end

NS_ASSUME_NONNULL_END
