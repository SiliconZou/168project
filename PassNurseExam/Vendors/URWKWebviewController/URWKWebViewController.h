//
//  URWKWebViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface URWKWebViewController : URBasicViewController

@property (nonatomic, copy, readonly) NSURL *uri;
@property (nonatomic, strong) NSString *linkUrl;

@property (nonatomic,copy) NSString * itemTitle;
@property (nonatomic, assign) BOOL isShowNav;
@property (nonatomic, assign) BOOL isCiecleVC;
@property (nonatomic, assign) BOOL isNews;
- (instancetype)initWithLinkUrl:(NSString *)linkUrl;
- (instancetype)initWithURI:(NSURL *)uri linkUrl:(NSString *)linkUrl;

/**
 *  it will get the correct root viewcontroller and go back
 */
- (void)gotoRootViewController;


@end

NS_ASSUME_NONNULL_END
