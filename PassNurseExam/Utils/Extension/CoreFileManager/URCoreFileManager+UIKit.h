//
//  URCoreFileManager+UIKit.h
//  PassNurseExam
//
//  Created by qc on 2018/8/29.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  保存图片到/caches/pic路径下
 *
 *  @param filename 文件名
 *  @param image 图片名
 *
 *  @return 是否成功
 */
BOOL URFileManagerSaveImage(NSString *filename, UIImage *image);


/**
 *  读取图片
 *
 *  @param  filename 默认图片路径caches/pic/, 可以通过MSSetDefaultImageDirectory设置
 *
 *  @return 图片
 */
UIImage* URFileManagerLoadImage(NSString *filename);
