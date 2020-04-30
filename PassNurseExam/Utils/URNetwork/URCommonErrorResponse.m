//
//  URCommonErrorResponse.m
//  BeiJingHospital
//
//  Created by qc on 2019/5/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonErrorResponse.h"

@implementation URCommonErrorResponse

- (NSInteger)httpResponseCode {
    return [self.returnCode integerValue];
}

@end
