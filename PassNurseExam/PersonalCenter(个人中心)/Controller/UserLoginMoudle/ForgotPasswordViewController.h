//
//  ForgotPasswordViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/10.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForgotPasswordViewController : URBasicViewController

/**
 1.忘记密码 2.修改密码
 */
@property (nonatomic,assign) NSInteger  type;

@end

NS_ASSUME_NONNULL_END
