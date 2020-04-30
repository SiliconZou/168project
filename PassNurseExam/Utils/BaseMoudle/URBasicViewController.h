//
//  URBasicViewController.h
//  PassNurseExam
//
//  Created by qc on 2019/9/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface URBasicViewController : UIViewController

@property (nonatomic, strong) UIButton    *cBtnLeft;    //导航左按钮（默认返回图标@"nav_back"）
@property (nonatomic, strong) UIButton    *cBtnRight;   //导航右按钮（默认无内容）
@property (nonatomic, strong) UIImageView *cViewNav;    //导航栏
@property (nonatomic, strong) NSString    *cSuperTitle; //标题（默认无内容）
@property (nonatomic, strong) UILabel     *lblTitle;    //导航栏标题
@property (nonatomic,assign) BOOL  isNeedLeftIcon;
@property (nonatomic,strong) id viewModel;              //传值模型

/**
 *  导航左按钮事件（默认返回上一页）
 *
 */
- (void)navLeftPressed;
/**
 *  导航右按钮事件（默认无内容）
 *
 */
- (void)navRightPressed:(id)sender;

/**
 push跳转方法
 
 @param vcName 控制器名称
 @param viewModel 数据
 */
- (void)pushViewControllerWithString:(NSString *)vcName withModel:(id _Nullable)viewModel;

/**
 退回到指定控制器
 
 @param vcName 控制器名称
 */
- (void)hm_popToViewController:(NSString *)vcName;

/**
 弹起 用户vip权益
 */
- (void)alertUserVipRight;


/**
打开qq

@param qqStr 要打开的qq号
*/

- (void)openOnlineWithQQ:(NSString *)qqStr;


-(void)openWebViewWithUrl:(NSString *)urlStr currVC:(UIViewController*)vc;

@end

NS_ASSUME_NONNULL_END
