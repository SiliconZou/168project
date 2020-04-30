//
//  CourseDetailMaterialsCell.m
//  PassNurseExam
//
//  Created by helingmin on 2019/10/28.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseDetailMaterialsCell.h"

@implementation CourseDetailMaterialsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * iconImageView = [[UIImageView  alloc] init];
        [self.contentView  addSubview:iconImageView];
        [iconImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(URScreenWidth());
        }];
        self.iconView = iconImageView;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
