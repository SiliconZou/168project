//
//  UIViewController+Extension.m
//  STYBuy
//
//  Created by qc on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface UIViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) BOOL allowsEditing;

@property (nonatomic,copy) void (^ImageBlock) (UIImage * image) ;

@end


@implementation UIViewController (Extension)

- (void)setAllowsEditing:(BOOL)allowsEditing
{
    objc_setAssociatedObject(self, @selector(allowsEditing), @(allowsEditing), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)allowsEditing
{
    return [objc_getAssociatedObject(self, @selector(allowsEditing)) boolValue];
}


- (void)setImageBlock:(void (^)(UIImage *))ImageBlock
{
    objc_setAssociatedObject(self, @selector(setImageBlock:), ImageBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIImage *))ImageBlock
{
    return objc_getAssociatedObject(self, @selector(setImageBlock:));
}


- (void)alertMessage:(NSString *)msg cancle:(NSString *)cancleTitle title1:(NSString *)title1 title2:(NSString *)title2 block1:(void (^) (NSInteger index))block1 block2:(void (^) (NSInteger index))block2
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *photoLibraryAction ;
    if (title1) {
        photoLibraryAction = [UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (block1) {
                block1(0);
            }
        }];
    }
    
    UIAlertAction *cameraAction;
    if (title2) {
        cameraAction = [UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (block2) {
                block2(1);
            }
        }];
    }
    
    
    [alertController addAction:cancelAction];
    if (title1) {
        [alertController addAction:photoLibraryAction];
    }
    
    if (title2) {
        [alertController addAction:cameraAction];
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)alertTitle:(NSString *)title message:(NSString *)msg cancle:(NSString *)cancleTitle title1:(NSString *)title1 title2:(NSString *)title2 block1:(void (^) (NSInteger index))block1 block2:(void (^) (NSInteger index))block2 cancle:(void(^)(NSInteger index))cancle preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle: preferredStyle];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancle) {
                cancle(2);
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        UIAlertAction *oneAction;
        if (title1) {
            oneAction= [UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (block1) {
                    block1(0);
                }
            }];
        }
        
        UIAlertAction *twoAction;
        if (title2) {
            twoAction = [UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (block2) {
                    block2(1);
                }
            }];
        }
        
        [alertController addAction:cancelAction];
        if (title1) {
            [alertController addAction:oneAction];
        }
        
        if (title2) {
            [alertController addAction:twoAction];
        }
        [self presentViewController:alertController animated:YES completion:nil];
    });
}


/**
 是否有访问相机的权限
 */
- (BOOL)authedCamera:(BOOL)needAlert
{
    NSString * mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
        //无权限
        if (needAlert) {
            [self alertAuthedCamera];
        }
        return NO;
    }else{
        //有权限
        return YES;
    }
}

/**
 是否有相册使用权限
 
 @param needAlert 是否需要弹窗提示
 @return YES 有权限  NO 无权限
 */
- (BOOL)authedPhotoLibrary:(BOOL)needAlert
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
    {
        // 无权限
        if (needAlert) {
            [self alertAuthedPhotoLibrary];
        }
        return NO;
    }else
    {
        return YES;
    }
}

- (void)alertAuthedCamera
{
    [self alertTitle:@"摄像头访问受限" message:@"为了更好的体验,请在设置中打开相机权限" cancle:@"取消" title1:@"去设置中打开"  title2:nil block1:^(NSInteger index) {
        [self toSetForOpenPhoto];
    } block2:^(NSInteger index) {
    } cancle:^(NSInteger index) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } preferredStyle:UIAlertControllerStyleAlert];
}

- (void)alertAuthedPhotoLibrary
{
    [self alertTitle:@"相册访问受限" message:@"为了更好的体验,请在设置中打开相册权限" cancle:@"取消" title1:@"去设置中打开"  title2:nil block1:^(NSInteger index) {
        [self toSetForOpenPhoto];
    } block2:^(NSInteger index) {
    } cancle:^(NSInteger index) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } preferredStyle:UIAlertControllerStyleAlert];
}


/**
 去设置中打开相机访问权限
 */
- (void)toSetForOpenPhoto
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)selectImageWithAllowsEditing:(BOOL)allowsEditing title:(NSString *)title completeBlock:(void (^)(UIImage *))imageBlock
{
    [self alertMessage:title cancle:@"取消" title1:@"相册" title2:@"拍照" block1:^(NSInteger index) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary allowsEditing:allowsEditing completeBlock:imageBlock];
    } block2:^(NSInteger index) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera allowsEditing:allowsEditing completeBlock:imageBlock];
    }];
}

- (void)showImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourcetype allowsEditing:(BOOL)allowsEditing completeBlock:(void (^)(UIImage *))imageBlock
{
    if (sourcetype == UIImagePickerControllerSourceTypeCamera) {
        if ([self authedCamera:YES]) {
            [self showSourceType:sourcetype allowsEditing:allowsEditing completeBlock:imageBlock];
        }
    }else if (sourcetype == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        if ([self authedPhotoLibrary:YES]) {
            [self showSourceType:sourcetype allowsEditing:allowsEditing completeBlock:imageBlock];
        }
    }
}

- (void)showSourceType:(UIImagePickerControllerSourceType)sourcetype allowsEditing:(BOOL)allowsEditing completeBlock:(void (^)(UIImage *))imageBlock
{
    self.allowsEditing = allowsEditing;
    if (imageBlock) {
        self.ImageBlock = imageBlock;
    }
    
    UIImagePickerController *pk = [[UIImagePickerController alloc] init];
    pk.sourceType = sourcetype;
    pk.allowsEditing = allowsEditing;
    pk.delegate = self;
    [self presentViewController:pk animated:YES completion:nil];
}


//选择图片的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image;
    if (self.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    }else
    {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    @weakify(self);
    [picker dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([image isKindOfClass:[UIImage class]]) {
            if (self.ImageBlock) {
                self.ImageBlock(image);
            }
        }
    }];
}


/**
 将当前视图保存到相册
 */
- (void)saveCaptureImageFromView:(UIView *)view
{
    // 1.获取相册授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        [self alertTitle:@"相册访问受限" message:@"为了更好的体验,请在设置中打开相册权限" cancle:@"取消" title1:@"去设置中打开"  title2:nil block1:^(NSInteger index) {
            [self toSetForOpenPhoto];
        } block2:^(NSInteger index) {
        } cancle:^(NSInteger index) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } preferredStyle:UIAlertControllerStyleAlert];
        return;
    } else if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        }];
    }else if (status == PHAuthorizationStatusAuthorized)
    {
        // 用户已经授权，可以使用
        UIImage *image = [self captureImageFromView:view];
        if (image) {
            [self saveImageToPhotos:image];
        }
    }
    
}


//截图功能
-(UIImage *)captureImageFromView:(UIView *)view{
    
    CGRect screenRect = view.frame;
    UIGraphicsBeginImageContextWithOptions(screenRect.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
- (void)saveImageToPhotos:(UIImage *)image {
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}
-  (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
        [URToastHelper  showErrorWithStatus:@"保存成功"];
    } else {
        [URToastHelper  showErrorWithStatus:@"保存失败"];
    }
}

/**
 退回到指定控制器
 
 @param vcName 控制器名称
 */
- (void)st_popToViewController:(NSString *)vcName
{
    
    Class cls = NSClassFromString(vcName);
    for (UIViewController * vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[cls class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
