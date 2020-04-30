//
//  CoursePackageListTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CoursePackageListTableViewCell.h"

@interface CoursePackageListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *courseCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *learnButton;

@end

@implementation CoursePackageListTableViewCell

-(void)setCombinationModel:(CourseStageCombinationModel *)combinationModel{
    
    _combinationModel = combinationModel ;
    
    [_iconImage sd_setImageWithURL:[NSURL  URLWithString:[NSString  stringWithFormat:@"%@",combinationModel.thumbnail?:@""]] placeholderImage:[UIImage  imageNamed:@"占位图"]];
    
    _nameLabel.text = [NSString  stringWithFormat:@"%@",combinationModel.name?:@""] ;
    
    _courseCountLabel.text = [NSString  stringWithFormat:@"%@",combinationModel.describe?:@""] ;
    
    _timeLabel.text = [NSString  stringWithFormat:@" %@ ",combinationModel.updated_describe?:@""] ;
    
    if (is_online==0) {
        _priceLabel.text = @"" ;
    } else {
        _priceLabel.text = [NSString  stringWithFormat:@"¥%@",combinationModel.univalence?:@""] ;
    }
    
    if ([combinationModel.own integerValue] == 1) {
        [self.learnButton setTitle:@"立即学习" forState:UIControlStateNormal];
        [self.learnButton  setBackgroundColor:UR_ColorFromValue(0x91f261)];
    }else {
        self.learnButton.userInteractionEnabled = is_online == 0 ? NO : YES;
        [self.learnButton setTitle:is_online == 0 ? @"暂不可学习" : @"立即购买" forState:UIControlStateNormal];
        [self.learnButton  setBackgroundColor:UR_ColorFromValue(0x4f81ff)];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.timeLabel.layer.cornerRadius = 5.0f ;
    self.timeLabel.layer.masksToBounds = YES ;
    self.timeLabel.layer.borderColor = UR_ColorFromRGBA(249, 164, 97, 0.3).CGColor;
    self.timeLabel.layer.borderWidth = 1.0f ;
    self.timeLabel.backgroundColor = UR_ColorFromValue(0xFFF7F3);
    
    [self.learnButton setBackgroundColor:UR_ColorFromValue(0x63A3FF)] ;
    self.learnButton.layer.cornerRadius = 14.0f;
    self.learnButton.layer.masksToBounds = YES ;
    self.learnButton.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
