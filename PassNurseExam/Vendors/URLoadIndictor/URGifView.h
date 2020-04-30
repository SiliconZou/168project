//
//  URGifView.h
//  Rubik-X-Popular-UI2.0
//
//  Created by qc on 16/3/11.
//  Copyright © 2016年 ucmed —— Rubik-X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface URGifView : UIView

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath;
- (id)initWithFrame:(CGRect)frame data:(NSData *)_data;
- (void)startGif;
- (void)stopGif;

@end
