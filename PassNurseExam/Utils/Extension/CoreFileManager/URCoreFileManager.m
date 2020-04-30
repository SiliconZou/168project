//
//  URCoreFileManager.m
//  PassNurseExam
//
//  Created by qc on 2018/8/29.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import "URCoreFileManager.h"

static NSString *__defaultImageDirectory = nil; // 默认的图片文件夹路径

NSString * URGetDefaultImageDirectory();


NSURL* URFileURL(NSString *path){
    return [[NSURL alloc] initFileURLWithPath:path];
}

BOOL URIsFileExistAtPath(NSString *filePath){
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    const bool isExist = [fileManager fileExistsAtPath:filePath];
    
    if (!isExist){
        NSLog(@"%@ not exist!", filePath);
    }
    
    return isExist;
}


# pragma mark -
# pragma mark Read and write plist file

NSArray* URArrayFromMainBundle(NSString *filename){
    NSArray *arrayForReturn = nil;
    NSString *path = URPathForBundleResource(nil, filename);
    
    if (URIsFileExistAtPath(path)){
        arrayForReturn = [NSArray arrayWithContentsOfFile:path];
    }
    return arrayForReturn;
}


NSDictionary* URDictionaryFromMainBundle(NSString *filename){
    NSDictionary *dictionaryForReturn = nil;
    NSString *path = URPathForBundleResource(nil, filename);
    
    if (URIsFileExistAtPath(path)){
        dictionaryForReturn = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return dictionaryForReturn;
}


NSArray* URArrayFromCachesDirectory(NSString *filename){
    NSString *path = URPathForCachesResource(filename);
    return [NSArray arrayWithContentsOfFile:path];
}


NSDictionary* URDictionaryFromDocumentDirectory(NSString *filename){
    NSString *path = URPathForCachesResource(filename);
    return [NSDictionary dictionaryWithContentsOfFile:path];
}


BOOL URSaveArrayToCachesDirectory(NSString *filename, NSArray *array){
    NSString *path = URPathForCachesResource(filename);
    return [array writeToFile:path atomically:YES];
}


BOOL URSaveDictionaryToCachesDirectory(NSString *filename, NSDictionary *dictionary){
    NSString *path = URPathForCachesResource(filename);
    return [dictionary writeToFile:path atomically:YES];
}


BOOL URFileManagerCreateDirectory(NSString *dir){
    BOOL flag = NO;
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error = nil;
    
    if (![fileManger fileExistsAtPath:dir])
    {
        flag = [fileManger createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"createDirectoryAtPath faild:%@", error);
        }
    }
    else{
        NSLog(@"%@ 文件夹已存在", dir);
    }
    
    return flag;
}


BOOL URFileManagerRemoveDirectory(NSString *dir){
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:dir error:nil];
}


BOOL URFileManagerRemoveFile(NSString *file){
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:file error:nil];
}


BOOL URFileManagerSaveFile(NSString *file, NSData *data){
    NSError *error = nil;
    BOOL flag = [data writeToFile:file options:NSDataWritingAtomic error:&error];
    
    if (flag == NO) {
        NSLog(@"MSFileManagerSaveFile error = %@", error);
    }
    
    return flag;
}


NSData *URFileManagerFileAtPath(NSString *filePath){
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    return data;
}


NSString* URGetDefaultImageDirectory(){
    if (__defaultImageDirectory==nil) {
        __defaultImageDirectory = URPathForCachesResource(@"/pic");
        URFileManagerCreateDirectory(__defaultImageDirectory);
    }
    
    return __defaultImageDirectory;
}


void URSetDefaultImageDirectory(NSString *directory){
    if (__defaultImageDirectory==nil) {
        __defaultImageDirectory = URGetDefaultImageDirectory();
    }
    
    __defaultImageDirectory = directory;
}

# pragma mark - Path
NSString* URPathForMainBundleResource(NSString* relativePath){
    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}


NSString* URPathForBundleResource(NSBundle* bundle, NSString* relativePath) {
    NSString* resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}


NSString* URPathForDocumentsResource(NSString* relativePath) {
    
    if (relativePath==nil) {
        relativePath = @"";
    }
    
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        documentsPath = [dirs objectAtIndex:0];
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}


NSString* URPathForLibraryResource(NSString* relativePath) {
    static NSString* libraryPath = nil;
    if (nil == libraryPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        libraryPath = [dirs objectAtIndex:0];
    }
    return [libraryPath stringByAppendingPathComponent:relativePath];
}


NSString* URPathForCachesResource(NSString* relativePath) {
    static NSString* cachesPath = nil;
    if (nil == cachesPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        cachesPath = [dirs objectAtIndex:0];
    }
    return [cachesPath stringByAppendingPathComponent:relativePath];
}

