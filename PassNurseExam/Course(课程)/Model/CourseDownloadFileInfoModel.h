//
//  CourseDownloadFileInfoModel.h
//  PassNurseExam
//
//  Created by helingmin on 2019/10/23.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FileModel;

@interface CourseDownloadFileInfoModel : NSObject

+ (instancetype)shareInstance;

/// 保存
/// @param model 视频文件信息modle
/// @param fileName 保存信息的plist文件名称
- (void)safeFileModel:(FileModel *)model fileName:(NSString *)fileName;

/// 获取
/// @param fileName 保存信息的plist文件名称
- (NSArray *)loadFileList:(NSString *)fileName;

/// 删除
/// @param fileName 保存信息的plist文件名称
-(void)deleteFileToplist:(NSString *)fileName;

/// 查询下载文件地址
/// @param urlString 下载地址
- (NSString *)getAseFileName:(NSString *)urlString;

/// 视频异或解密，返回视频 .mp4 地址
/// @param url 下载地址
- (void)funcDeFile:(NSString *)url finishBlock:(void(^)(NSString * path))finish;

@end

 
@interface FileModel : NSObject

@property (nonatomic,copy) NSString *courseName;//课程名称
@property (nonatomic,copy) NSString *checkCode;//校验有效性的码
@property (nonatomic,copy) NSString *downloadUrl;//网上下载的地址
@property (nonatomic,copy) NSString *playUrl;//网上播放地址，可以根据这个获取第一帧图片
@property (nonatomic,copy) NSString *localFilePath;//本地保存的路径

@end


NS_ASSUME_NONNULL_END
