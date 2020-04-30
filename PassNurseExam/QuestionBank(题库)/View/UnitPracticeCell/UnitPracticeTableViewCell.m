//
//  UnitPracticeTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/13.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UnitPracticeTableViewCell.h"

@interface UnitPracticeTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation UnitPracticeTableViewCell

-(void)setDataModel:(UnitPracticeDataModel *)dataModel{
    
    _dataModel = dataModel ;
    
    self.nameLabel.text = [NSString  stringWithFormat:@"%@",dataModel.name?:@""] ;
    
    self.progressLabel.text = [NSString  stringWithFormat:@"%@/%@",dataModel.done?:@"",dataModel.count?:@""] ;
    
    self.progressView.progressTintColor = UR_ColorFromValue(0x9B89FF);
    self.progressView.trackTintColor = UR_ColorFromValue(0xE5E5E5);
    
    self.progressView.progress = dataModel.done.floatValue/dataModel.count.floatValue ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.progressView.layer.cornerRadius =4.0f ;
    self.progressView.layer.masksToBounds = YES ;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
