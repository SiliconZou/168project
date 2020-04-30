//
//  QuestionProgressView.m
//  PassNurseExam
//
//  Created by qc on 2019/9/14.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "QuestionProgressView.h"

@implementation QuestionProgressView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UR_ColorFromValue(0xD8D8D8);
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (self.progress == 0) return;
    UIBezierPath * bez = [UIBezierPath bezierPath];
    [bez moveToPoint:CGPointMake(0, self.mj_h/2.0)];
    [bez setLineWidth:self.mj_h];
    [bez setLineCapStyle:kCGLineCapRound];
    [bez addLineToPoint:CGPointMake(self.mj_w * self.progress , self.mj_h/2.0)];
    [UR_ColorFromValue(0x9B89FF) set];
    [bez stroke];
}


@end
