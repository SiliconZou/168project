//
//  HomePageScanViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePageScanViewController : URBasicViewController
@property (nonatomic,copy) void(^scanBtnBlock)(NSString *scanResult);
@end

NS_ASSUME_NONNULL_END
