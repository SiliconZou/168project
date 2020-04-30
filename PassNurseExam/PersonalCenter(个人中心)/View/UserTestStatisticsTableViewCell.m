//
//  UserTestStatisticsTableViewCell.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/9.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserTestStatisticsTableViewCell.h"

@interface UserTestStatisticsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation UserTestStatisticsTableViewCell

-(void)setDataModel:(UserTestStatisticsDataModel *)dataModel{
    
    _dataModel = dataModel ;
    
    self.titleLabel.text = [NSString  stringWithFormat:@"%@",dataModel.title?:@""] ;
    
    self.subTitleLabel.text = [NSString  stringWithFormat:@"%@",dataModel.subject?:@""] ;

    self.numberLabel.text = [NSString  stringWithFormat:@"答对:%@道  总共:%@道",dataModel.correct_num?:@"",dataModel.all_num?:@""] ;

    self.timeLabel.text = [NSString  stringWithFormat:@"%@",dataModel.created_at?:@""] ;

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.subTitleLabel.layer.cornerRadius = 5.0f ;
    self.subTitleLabel.layer.masksToBounds = YES ;
    self.subTitleLabel.layer.borderWidth = 1.0f ;
    self.subTitleLabel.layer.borderColor = UR_ColorFromValue(0x59A2FF).CGColor ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
