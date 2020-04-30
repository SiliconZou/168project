//
//  URAlert.m
//  Test
//
//  Created by qc on 16/1/29.
//  Copyright © 2016年 ucmed. All rights reserved.
//

#import "URAlert.h"

static buttonIndexBlock indexBlock;

static NSMutableArray  *alertHubArray;

static UIColor   *themeColor = nil;

@interface URAlert ()<UIAlertViewDelegate>
{
    buttonIndexBlock indexBlock;
}

@end

@implementation URAlert

+ (void)setThemeColor:(UIColor *)color;
{
    if (color) {
        themeColor = color;
    }
}

+ (void)alertWithStyle:(URAlertStyle)style
               message:(nullable NSString *)message;
{
    [self alertWithStyle:style type:URAlertTypeInfo title:nil message:message];
}

+ (void)alertWithStyle:(URAlertStyle)style
                  type:(URAlertType)type
                 title:(nullable NSString *)title
               message:(nullable NSString *)message
{
    [self alertWithStyle:style type:type title:title message:message viewController:nil];
}

+ (void)alertWithStyle:(URAlertStyle)style
                  type:(URAlertType)type
                 title:(nullable NSString *)title
               message:(nullable NSString *)message
        viewController:(nullable UIViewController *)viewController
{
    if (style == URAlertStyleNone) {
        return;
    }
    if (style == URAlertStyleAlert) {
        if (viewController) {
            [self alertViewWithStyle:URAlertStyleAlert
                               title:title?title:@"提示"
                             message:message
                   cancelButtonTitle:@"知道啦"
                    sureButtonTitles:nil
                      viewController:viewController
                             handler:^(NSInteger buttonIndex) {
                                 
                             }];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title?title:@"提示"
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:@"知道啦"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
#pragma clang diagnostic pop

        }
    } else if (style == URAlertStyleCustom) {
        [self alertViewWithStyle:URAlertStyleAlert
                           title:title?title:@"提示"
                         message:message
               cancelButtonTitle:@"知道啦"
                sureButtonTitles:nil
                  viewController:viewController
                         handler:^(NSInteger buttonIndex) {
                             
                         }];
    } else {
        [self showAlertHubWithType:type title:title message:message];
    }
}

/* butonIndex 0：第一个按钮；1：第二个按钮
 */
+ (void)alertViewWithStyle:(URAlertStyle)style
                     title:(nullable NSString *)title
                   message:(nullable NSString *)message
         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
          sureButtonTitles:(nullable NSString *)sureButtonTitles
            viewController:(nonnull UIViewController *)viewController
                   handler:(_Nonnull buttonIndexBlock)buttonIndex;
{
    if (style == URAlertStyleAlert) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:cancelButtonTitle
                                                      otherButtonTitles:sureButtonTitles, nil];
            alertView.delegate = self;
            [alertView show];
            indexBlock = buttonIndex;
#pragma clang diagnostic pop
            
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                     message:message
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            if (cancelButtonTitle) {
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    buttonIndex(0);
                }];
                [alertController addAction:alertAction];
            }
            if (sureButtonTitles) {
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:sureButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (cancelButtonTitle) {
                        buttonIndex(1);
                    } else {
                        buttonIndex(0);
                    }
                }];
                [alertController addAction:alertAction];
            }
            
            [viewController presentViewController:alertController animated:YES completion:nil];
        }
    } else if (style == URAlertStyleCustom) {
        UIView *grayLayerView = grayLayerView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        grayLayerView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        
#define URA_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define URA_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
        
        NSInteger alertViewLeftPadding = URA_SCREEN_WIDTH > 320 ? 60 : 35;
        NSInteger alertViewHeight = URA_SCREEN_WIDTH > 320 ? 260 : 240;
        
        UIView *alertViewBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(alertViewLeftPadding, (URA_SCREEN_HEIGHT-210)/2, URA_SCREEN_WIDTH-alertViewLeftPadding*2, alertViewHeight)];
        alertViewBackgroundView.backgroundColor = [UIColor whiteColor];
        [grayLayerView addSubview:alertViewBackgroundView];
        
        UIImageView *colorLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, alertViewBackgroundView.frame.size.width, 3)];
        colorLineImageView.image = [UIImage imageNamed:@"ur_colorline_icon"];
        [alertViewBackgroundView addSubview:colorLineImageView];
        
        UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, alertViewBackgroundView.frame.size.width, 40)];
        labTitle.text = title;
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.textColor = [UIColor blackColor];
        labTitle.font = [UIFont systemFontOfSize:17];
        [alertViewBackgroundView addSubview:labTitle];
        
        UIButton *dismissViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissViewButton.frame = CGRectMake(alertViewBackgroundView.frame.size.width-30, 13, 20, 20);
        [dismissViewButton setImage:[UIImage imageNamed:@"ur_login_back_icon"]  forState:UIControlStateNormal];
        [alertViewBackgroundView addSubview:dismissViewButton];
        [[dismissViewButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            buttonIndex(2);
            
            if (grayLayerView.superview) {
                [grayLayerView removeFromSuperview];
            }
        }];
        
        CGSize size = [message boundingRectWithSize:CGSizeMake(alertViewBackgroundView.frame.size.width - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        
        CGFloat contentH = MIN(size.height+10, 140);
        
        UIScrollView *contentBgView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, labTitle.frame.origin.y + labTitle.frame.size.height, alertViewBackgroundView.frame.size.width - 20, contentH)];
        contentBgView.backgroundColor = [UIColor clearColor];
        [alertViewBackgroundView addSubview:contentBgView];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertViewBackgroundView.frame.size.width - 20, contentH+5)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.text = message;
        contentLabel.numberOfLines = 0;
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.font = [UIFont systemFontOfSize:15];
        [contentBgView addSubview:contentLabel];
        
        contentLabel.frame = CGRectMake(0, 0, alertViewBackgroundView.frame.size.width - 20, MAX(size.height+10, contentH));
        contentBgView.contentSize = CGSizeMake(alertViewBackgroundView.frame.size.width - 20, MAX(size.height+10, contentH));
        
        alertViewHeight = alertViewHeight-140+contentH;
        alertViewBackgroundView.frame = CGRectMake(alertViewLeftPadding, (URA_SCREEN_HEIGHT-alertViewHeight)/2, URA_SCREEN_WIDTH-alertViewLeftPadding*2, alertViewHeight);
        [alertViewBackgroundView setCenter:CGPointMake(CGRectGetMidX([UIApplication sharedApplication].keyWindow.bounds), CGRectGetMidY([UIApplication sharedApplication].keyWindow.bounds)-64)];
        
        UIImageView *imgLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, alertViewBackgroundView.frame.size.height - 55,alertViewBackgroundView.frame.size.width, 1)];
        imgLine.backgroundColor = [UIColor lightGrayColor];
        [alertViewBackgroundView addSubview:imgLine];
        
        NSInteger alertViewButtonWidth = (alertViewBackgroundView.frame.size.width-50)/2;
        
        if (cancelButtonTitle) {
            UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.backgroundColor = [UIColor clearColor];
            leftButton.frame = CGRectMake(10, alertViewBackgroundView.frame.size.height - 45, alertViewButtonWidth, 35);
            [leftButton setTitle:cancelButtonTitle?cancelButtonTitle:@"不再提示" forState:UIControlStateNormal];
            [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            leftButton.layer.cornerRadius = 18.0;
            leftButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
            leftButton.layer.borderWidth = 1;
            [alertViewBackgroundView addSubview:leftButton];
            [[leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                buttonIndex(0);
                
                if (grayLayerView.superview) {
                    [grayLayerView removeFromSuperview];
                }
            }];
        }
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (cancelButtonTitle) {
            rightButton.frame = CGRectMake(alertViewBackgroundView.frame.size.width/2 + 10, alertViewBackgroundView.frame.size.height - 45, alertViewButtonWidth, 35);
        }else{
            rightButton.frame = CGRectMake((alertViewBackgroundView.frame.size.width - alertViewButtonWidth) / 2 , alertViewBackgroundView.frame.size.height - 45, alertViewButtonWidth, 35);
        }
        [rightButton setTitle:sureButtonTitles?sureButtonTitles:@"确定" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton setBackgroundColor:[themeColor isKindOfClass:[UIColor class]]?themeColor:[UIColor blueColor]];
        rightButton.layer.cornerRadius = 18.0;
        [alertViewBackgroundView addSubview:rightButton];
        [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (cancelButtonTitle) {
                buttonIndex(1);
            } else {
                buttonIndex(0);
            }
            
            if (grayLayerView.superview) {
                [grayLayerView removeFromSuperview];
            }
        }];
        
        if (viewController) {
            [viewController.view addSubview:grayLayerView];
        } else {
            [[[UIApplication sharedApplication].windows lastObject] addSubview:grayLayerView];
        }
    } else {
        [self alertWithStyle:URAlertStyleHUB message:message];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (indexBlock) {
        indexBlock(buttonIndex);
    }
}
#pragma clang diagnostic pop


+ (void)showAlertHubWithType:(URAlertType)type
                       title:(NSString *)title
                     message:(NSString *)message
{
    MBProgressHUD *hudView = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    hudView.mode = MBProgressHUDModeCustomView;
    hudView.customView = [self hubViewWithMessage:message type:type];
    hudView.margin = 2;
    hudView.layer.cornerRadius = 3;
    hudView.alpha = 0.85;
    hudView.userInteractionEnabled = NO;
    
    if (!alertHubArray) {
        alertHubArray = [[NSMutableArray alloc] init];
    }
    NSDictionary *dict = @{@"view":hudView,
                           @"time":[NSNumber numberWithInteger:MAX(3, message.length/4+1)]};
    [alertHubArray addObject:dict];
    
    if (alertHubArray.count == 1) {
        [self showHubView];
    }
}

+ (UIView *)hubViewWithMessage:(NSString *)message
                          type:(URAlertType)type
{
    UIView *hubView = [[UIView alloc] init];
    hubView.backgroundColor = [UIColor clearColor];
#define URA_FONE_SIZE 14
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGSize size = [message boundingRectWithSize:CGSizeMake(screenWidth-90-21, 170) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:URA_FONE_SIZE]} context:nil].size;
    CGFloat heigth = MAX(20, size.height+5);
    CGFloat width = MAX(size.width+10, 50);
    UILabel *hubLabel = [[UILabel alloc] init];
    hubLabel.backgroundColor = [UIColor clearColor];
    hubLabel.textColor = [UIColor whiteColor];
    hubLabel.font = [UIFont systemFontOfSize:URA_FONE_SIZE];
    hubLabel.text = message;
    hubLabel.numberOfLines = 0;
    [hubView addSubview:hubLabel];
    
    UIImageView *hubImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ur_alert_info_icon"]];
    hubImageView.backgroundColor = [UIColor clearColor];
    [hubView addSubview:hubImageView];
    hubImageView.frame = CGRectMake(5, (heigth-11)/2, 11, 11);
    hubLabel.frame = CGRectMake(21, 0, width, heigth);
    hubView.frame = CGRectMake(0, 0, 21+width, heigth);
    
    return hubView;
}

+ (void)showHubView
{
    static BOOL isShow = NO;
    
    if (alertHubArray.count) {
        if (isShow) {
            return;
        } else {
            isShow = YES;
        }
        
        NSDictionary *dict = [alertHubArray objectAtIndex:0];
        [alertHubArray removeObjectAtIndex:0];
        MBProgressHUD *hubView = dict[@"view"];
        [[UIApplication sharedApplication].keyWindow addSubview:hubView];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep([dict[@"time"] unsignedIntValue]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [hubView removeFromSuperview];
                isShow = NO;
                [self showHubView];
            });
        });
    }
}

@end
