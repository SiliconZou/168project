//
//  UIButton+EdgeInsets.h
//  PassNurseExam
//
//  Created by qc on 2018/8/16.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, URButtonEdgeInsetsStyle) {
    URButtonEdgeInsetsStyleTop, // image在上，label在下
    URButtonEdgeInsetsStyleLeft, // image在左，label在右
    URButtonEdgeInsetsStyleBottom, // image在下，label在上
    URButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (EdgeInsets)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(URButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
