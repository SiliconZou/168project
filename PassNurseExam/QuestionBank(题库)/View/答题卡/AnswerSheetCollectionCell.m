//
//  AnswerSheetCollectionCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/18.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "AnswerSheetCollectionCell.h"

@implementation AnswerSheetCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.noLb];
        [self.noLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(43 * AUTO_WIDTH, 43 * AUTO_WIDTH));
            make.center.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel *)noLb
{
    if (!_noLb) {
        _noLb = [UILabel borderLabelWithRadius:43/2 borderColor:UR_ColorFromValue(0x999999) borderWidth:0.5 title:@"" titleColor:[UIColor whiteColor] font:RegularFont(FontSize16) textAlignment:NSTextAlignmentCenter numberLines:1];
    }
    return _noLb;
}


@end
