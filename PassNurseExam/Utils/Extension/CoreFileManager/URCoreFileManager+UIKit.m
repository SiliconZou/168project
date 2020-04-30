//
//  MSCoreFileManager+UIKit.m
//  PassNurseExam
//
//  Created by qc on 2018/8/29.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "URCoreFileManager.h"
#import "URCoreFileManager+UIKit.h"

BOOL URFileManagerSaveImage(NSString *filename, UIImage *image){
    NSData *data = nil;
    
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", URGetDefaultImageDirectory(), filename];
    
    return URFileManagerSaveFile(filePath, data);
}


UIImage* MSFileManagerLoadImage(NSString *filename){
    NSString *dir = URGetDefaultImageDirectory();
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", dir, filename];
    
    return [UIImage imageWithContentsOfFile:filePath];
}

