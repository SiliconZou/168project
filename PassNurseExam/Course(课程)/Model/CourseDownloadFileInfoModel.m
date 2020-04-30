//
//  CourseDownloadFileInfoModel.m
//  PassNurseExam
//
//  Created by helingmin on 2019/10/23.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseDownloadFileInfoModel.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation CourseDownloadFileInfoModel

+ (instancetype)shareInstance {
    static CourseDownloadFileInfoModel *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[CourseDownloadFileInfoModel alloc] init];
    });
    return obj;
}

//存储数据
- (void)safeFileModel:(FileModel *)model fileName:(NSString *)fileName
{
    NSString *filePath = [self getFilePath:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO) //不存在plist文件
    {
        NSLog(@"开始创建 %@plist文件",fileName);
        NSString *filePath = [self getFilePath:fileName];

        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        
        
        NSMutableArray *mutiArr = [NSMutableArray array];
        NSDictionary *dic = [model yy_modelToJSONObject];
        [mutiArr insertObject:dic atIndex:0];
        [mutiArr writeToFile:filePath atomically:YES];
    }
    else
    {
        NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:filePath];
        NSDictionary *dic = [model yy_modelToJSONObject];
        [arr insertObject:dic atIndex:0];
        [arr writeToFile:filePath atomically:YES];
    }
}

//获取数据
- (NSArray *)loadFileList:(NSString *)fileName
{
    NSMutableArray *fileArr = [NSMutableArray arrayWithContentsOfFile:[self getFilePath:fileName]];
    NSArray *modelArr = [NSArray yy_modelArrayWithClass:[FileModel class] json:fileArr];
    return modelArr;
}

//删除数据
-(void)deleteFileToplist:(NSString *)fileName
{
    NSString *filePath = [self getFilePath:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
       if ([[NSFileManager defaultManager] removeItemAtPath:filePath error:nil]) {
            NSLog(@"文件删除成功");
        }
    }
}

//查询plit文件
- (NSString *)getFilePath:(NSString *)fileName
{
    return [[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName] stringByAppendingString:@".plist"];
}

//查询下载文件地址
- (NSString *)getAseFileName:(NSString *)urlString
{
    NSString *fileNameWithoutType = [self md5:urlString];
    NSString *fileName = [NSString stringWithFormat:@"%@.%@",fileNameWithoutType,@"mp4"];
    return fileName;
}

- (NSString *)md5:(NSString *)str
{
    NSData *stringbytes = [str dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    if (CC_MD5([stringbytes bytes], (int)[stringbytes length], digest)) {
        NSMutableString *digestString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
        for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            unsigned char achar = digest[i];
            [digestString appendFormat:@"%02X",achar];
        }
        return digestString;
    }
    return nil;
}

//异或解密,返回视频地址
- (void)funcDeFile:(NSString *)url finishBlock:(void(^)(NSString * path))finish
{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self getAseFileName:url]];

    NSData *dataEncoded = [NSData dataWithContentsOfFile:filePath];
    // 数据初始化，空间未分配 配合使用 appendBytes
    NSMutableData *encryptData = [[NSMutableData alloc] initWithCapacity:dataEncoded.length];
    [encryptData appendData:dataEncoded];
    
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"video.mp4"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{

        Byte sharedKey[] = { (Byte)0x37, (Byte)0x85, (Byte)0xF2, (Byte)0xB3, (Byte)0x5D, (Byte)0x55, (Byte)0x78, (Byte)0x49, (Byte)0xFF, (Byte)0x17 };
        Byte privateKey = (Byte)(dataEncoded.length / 1037) % 256;
        // 获取字节指针
        const Byte *point = (Byte *)dataEncoded.bytes;
        for (int i = 0; i < dataEncoded.length; i++)
        {
            //取文件前10240字节、后10240字节、中间（fileSize/2开始10240字节）简化算法
//            if (i < 10240 ||
//                i >= (dataEncoded.length - 10240) ||
//                (i >= dataEncoded.length/2 && i < (dataEncoded.length/2 + 10240)))
//            {
                Byte b = (Byte) ((point[i]) ^ (sharedKey[i % 10]) ^ privateKey);       // 异或运算
                [encryptData replaceBytesInRange:NSMakeRange(i, 1) withBytes:&b];
//            }
        }
        
        [encryptData writeToFile:cachePath atomically:YES];
        
        if (finish) {
            finish(cachePath);
        }
    });
}

@end


@implementation FileModel

@end
