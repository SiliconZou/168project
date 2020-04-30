//
//  URLoadingIndicator.m
//  Rubik-X-Popular-UI2.0
//
//  Created by qc on 16/3/11.
//  Copyright © 2016年 ucmed —— Rubik-X. All rights reserved.
//

#import "URLoadingIndicator.h"
#import "URGifView.h"


#define URL_IMAGE_WIDTH   145
#define URL_IMAGE_HEIGHT  145
#define URL_SCRENTCENTER  [UIApplication sharedApplication].keyWindow.center
#define URL_IMAGE_FRAME   CGRectMake(URL_SCRENTCENTER.x-URL_IMAGE_WIDTH/2,URL_SCRENTCENTER.y-URL_IMAGE_HEIGHT/2 - 80,URL_IMAGE_WIDTH,URL_IMAGE_HEIGHT)

static URLoadingIndicator  *_defaultIndicator = nil;

@interface URLoadingIndicator ()
{
    URGifView  *_gifView;
    NSInteger   _index;
    URReturnValue _returnBlock;
}

@end

@implementation URLoadingIndicator

- (URLoadingIndicator *)sharedIndicator
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _defaultIndicator = [super initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64)];
        _index = 0;
        _defaultIndicator.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0];
        [self initUI];
    });
    return _defaultIndicator;
}

- (instancetype)copy
{
    return [self sharedIndicator];
}

- (void)initUI
{
    UIButton *bgButton = [[UIButton alloc] initWithFrame:_defaultIndicator.frame];
    bgButton.backgroundColor = [UIColor clearColor];
    [bgButton addTarget:self action:@selector(bgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_defaultIndicator addSubview:bgButton];
    
    UIButton *imageBgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBgBtn.frame = URL_IMAGE_FRAME;
    imageBgBtn.backgroundColor = [UIColor clearColor];
    [imageBgBtn addTarget:self action:@selector(imageBgBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    [bgButton addSubview:imageBgBtn];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:imageBgBtn];
    hud.label.text = @"加载中...";
    hud.removeFromSuperViewOnHide = YES;
    [imageBgBtn addSubview:hud];
    [hud showAnimated:YES];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_defaultIndicator];
    _defaultIndicator.alpha = 0.0;
}

- (void)bgButtonAction:(UIButton *)button
{
    
}

- (void)imageBgBtnAct:(UIButton *)button
{
    _index = 1;
    [self stopLoading];
    if (_returnBlock) {
        _returnBlock(nil);
    }
}

- (void)startLoadingWithCancel:(URReturnValue)returnValue;
{
    [self startLoading];
    _returnBlock = returnValue;
}

- (void)startLoading
{
    ++_index;
    if (_index == 1) {
        [_gifView startGif];
        _defaultIndicator.alpha = 1.0;
    }
}

- (void)stopLoading
{
    --_index;
    if (_index<0) {
        _index = 0;
    }
    if (_index == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            [_gifView stopGif];
            _defaultIndicator.alpha = 0.0;
        }];
    }
}

- (void)stopAllLoading
{
    _index = 0;
    [UIView animateWithDuration:0.5 animations:^{
        [_gifView stopGif];
        _defaultIndicator.alpha = 0.0;
    }];
}

@end
