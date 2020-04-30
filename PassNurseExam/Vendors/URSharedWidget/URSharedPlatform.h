//
//  URSharedPlatform.h
//  GeneralHospitalPat
//
//  Created by quchao on 2018/4/17.
//  Copyright © 2018年 卓健科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URSharedView.h"


@interface URSharedPlatform : NSObject

@property (nonatomic,copy) NSString * iconImageName;

@property (nonatomic,copy) NSString * nameStr;

@property (nonatomic,assign) URShareType sharedPlatformType;

@end
