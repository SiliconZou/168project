//
//  UserIntegralTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 2019/10/1.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserIntegralTableViewCell.h"

@interface UserIntegralTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end

@implementation UserIntegralTableViewCell

-(void)setIntegralModel:(UserIntegralData1Model *)integralModel{
    
    _integralModel = integralModel ;
    
    _contentLabel.text = [NSString  stringWithFormat:@"%@",integralModel.title?:@""] ;
    
    _timeLabel.text = [NSString  stringWithFormat:@"%@",integralModel.updated_at?:@""] ;

    _numberLabel.text = [NSString  stringWithFormat:@"+%@",integralModel.number?:@""] ;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
