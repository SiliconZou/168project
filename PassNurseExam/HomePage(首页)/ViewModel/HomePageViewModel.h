//
//  HomePageViewModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageViewModel : NSObject

@property (nonatomic,strong) RACCommand *dataCommand;

+(void)qrCodeScanWithViewController:(UIViewController *)viewController  pushViewController:(UIViewController *)pushViewController;

@end

NS_ASSUME_NONNULL_END
