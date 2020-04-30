//
//  UserMessageTableViewCell.m
//  PassNurseExam
//
//  Created by 何灵敏 on 2019/10/7.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserMessageTableViewCell.h"

@interface UserMessageTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation UserMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 4.0f;
    self.bgView.layer.masksToBounds = YES ;
    self.bgView.layer.borderWidth = 1.0f ;
    self.bgView.layer.borderColor = UR_ColorFromValue(0xFECA91).CGColor ;
    
}

-(void)setModel:(id)model{
    if ([model  isKindOfClass:[MineMessageDataModel  class]]) {
        
        MineMessageDataModel * dataModel = model ;
        
        self.timeLabel.text = [NSString  stringWithFormat:@"%@",dataModel.updated_at?:@""] ;
        
        self.contentLabel.text = [NSString  stringWithFormat:@"%@",dataModel.title?:@""] ;
        
    } else if ([model  isKindOfClass:[MineMessageData1Model  class]]){
        
        MineMessageData1Model * data1Model = model ;
        
        self.timeLabel.text = [NSString  stringWithFormat:@"%@",data1Model.updated_at?:@""] ;
        
        self.contentLabel.text = [NSString  stringWithFormat:@"%@",data1Model.title?:@""] ;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
