//
//  URGifView.m
//  Rubik-X-Popular-UI2.0
//
//  Created by qc on 16/3/11.
//  Copyright © 2016年 ucmed —— Rubik-X. All rights reserved.
//

#import "URGifView.h"
#import <ImageIO/ImageIO.h>

@interface URGifView ()
{
    CGImageSourceRef gif; // 保存gif动画
    NSDictionary *gifProperties;  // 保存gif动画属性
    size_t index;// gif动画播放开始的帧序号
    size_t count;// gif动画的总帧数
    NSTimer *timer;// 播放gif动画所使用的timer
}

@end

@implementation URGifView

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath{
    
    self = [super initWithFrame:frame];
    if (self) {
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                    forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:_filePath], (CFDictionaryRef)gifProperties);
        count =CGImageSourceGetCount(gif);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame data:(NSData *)_data{
    self = [super initWithFrame:frame];
    if (self) {
        
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                    forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gif = CGImageSourceCreateWithData((CFDataRef)_data, (CFDictionaryRef)gifProperties);
        count =CGImageSourceGetCount(gif);
    }
    return self;
}

- (void)startGif
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(play) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)play
{
    index ++;
    index = index%count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}
-(void)removeFromSuperview
{
    NSLog(@"removeFromSuperview");
    [timer invalidate];
    timer = nil;
    [super removeFromSuperview];
}
- (void)dealloc {
    NSLog(@"dealloc");
    CFRelease(gif);
}
- (void)stopGif
{
    [timer invalidate];
    timer = nil;
}

@end
