//
//  URRoute.m
//  URWKWebViewController
//
//  Created by chenyong on 2017/10/27.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import "URRoute.h"

@implementation URRoute

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        //TODO: key值需要和后台商定
        _remoteHTML = [NSURL URLWithString:[dict objectForKey:@"remote_file"]];
        _URIRegex = [NSRegularExpression regularExpressionWithPattern:[dict objectForKey:@"uri"] options:0 error:nil];
    }
    return self;
}

@end
