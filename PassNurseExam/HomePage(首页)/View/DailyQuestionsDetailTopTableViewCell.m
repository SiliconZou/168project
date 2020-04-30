//
//  DailyQuestionsDetailTopTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 15/9/2019.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "DailyQuestionsDetailTopTableViewCell.h"

@interface DailyQuestionsDetailTopTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation DailyQuestionsDetailTopTableViewCell

-(void)setDataModel:(DailyQuestionsDataModel *)dataModel{
    
    _dataModel = dataModel ;
    
    NSString * typeStr ;
    
    if (dataModel.type.integerValue==1) {
        typeStr = @"[单选题]" ;
    } else if (dataModel.type.integerValue==2){
        typeStr = @"[多选题]" ;
    } else if (dataModel.type.integerValue==3){
        typeStr = @"[判断题]" ;
    }
    
    self.namelabel.text = [NSString  stringWithFormat:@"%@ %@题型",typeStr,dataModel.question_type?:@""] ;
    
    self.timeLabel.text = [NSString  stringWithFormat:@"%@",dataModel.qs_time?:@""] ;
    
    self.contentLabel.text = [NSString  stringWithFormat:@"(%@)每日真题",dataModel.subject_name?:@""] ;
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
