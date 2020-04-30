//
//  CourseDetailProblemSolvingCell.m
//  PassNurseExam
//
//  Created by helingmin on 2019/10/30.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseDetailProblemSolvingCell.h"

@implementation CourseDetailProblemSolvingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * iconImageView = [[UIView  alloc] init];
        [self.contentView  addSubview:iconImageView];
        [iconImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(URScreenWidth());
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
