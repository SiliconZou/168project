//
//  UIViewController+Extension.h
//  STYBuy
//
//  Created by qc on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIViewController (Extension)

- (void)alertMessage:(NSString *)msg cancle:(NSString *)cancleTitle title1:(NSString *)title1 title2:(NSString *)title2 block1:(void (^) (NSInteger index))block1 block2:(void (^) (NSInteger index))block2;


- (void)alertTitle:(NSString *)title message:(NSString *)msg cancle:(NSString *)cancleTitle title1:(NSString *)title1 title2:(NSString *)title2 block1:(void (^) (NSInteger index))block1 block2:(void (^) (NSInteger index))block2 cancle:(void(^)(NSInteger index))cancle preferredStyle:(UIAlertControllerStyle)preferredStyle;


/**
 是否有相机访问权限的判断
 
 @needAlert 是否需要弹窗提示无权限
 @return YES 有权限  NO 无权限
 */
- (BOOL)authedCamera:(BOOL)needAlert;

/**
 是否有相册使用权限
 
 @param needAlert 是否需要弹窗提示
 @return YES 有权限  NO 无权限
 */
- (BOOL)authedPhotoLibrary:(BOOL)needAlert;

/**
 选择图片
 
 @param allowsEditing 是否允许编辑
 @param title 标题
 @param imageBlock 图片回调
 */
- (void)selectImageWithAllowsEditing:(BOOL)allowsEditing title:(NSString *)title completeBlock:(void (^)(UIImage *))imageBlock;

/**
 讲当前视图保存到相册
 */
- (void)saveCaptureImageFromView:(UIView *)view;

/**
 选择图片
 
 @param sourcetype 相册/相机
 @param allowsEditing 是否允许编辑
 */
- (void)showImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourcetype allowsEditing:(BOOL)allowsEditing completeBlock:(void (^)(UIImage *))imageBlock;

/**
 退回到指定控制器
 
 @param vcName 控制器名称
 */
- (void)st_popToViewController:(NSString *)vcName;

@end
