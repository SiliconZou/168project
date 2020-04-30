//
//  DailyQuestionsTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 15/9/2019.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "DailyQuestionsTableViewCell.h"

@interface DailyQuestionsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *personallabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *contentlabel;

@end

@implementation DailyQuestionsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.bgView.layer.cornerRadius = 10.0f ;
    self.bgView.layer.masksToBounds = YES ;
    
    self.selectedButton.backgroundColor = UR_ColorFromValue(0xF2724F) ;
    self.selectedButton.layer.cornerRadius = 13.0f ;
    self.selectedButton.layer.masksToBounds = YES ;
    
    self.bgView.backgroundColor = UR_ColorFromValue(0x47DE87);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setQuestionModel:(DailyQuestionsDataModel *)questionModel{
    
    _questionModel  = questionModel ;
    
    self.nameLabel.text = [NSString  stringWithFormat:@"%@",questionModel.title?:@""] ;
    
    self.contentlabel.text = [NSString stringWithFormat:@"(%@)每日真题",questionModel.subject_name?:@""] ;
    
    self.timeLabel.text = [NSString  stringWithFormat:@"%@",questionModel.qs_time?:@""] ;
    
    self.personallabel.text = [NSString  stringWithFormat:@"%@人已做",questionModel.finished?:@""] ;
    
    if (questionModel.finished.integerValue==1)
    {

        self.bgView.layer.contents = (__bridge id)[UIImage gradientBackImgWithFrame:CGRectMake(0, 0, URScreenWidth()-10, 120-10) startColor:UR_ColorFromValue(0x39dd72) endColor:UR_ColorFromValue(0x4cdd8e) direction:0].CGImage;
        
        self.selectedButton.backgroundColor = [UIColor clearColor];
        [self.selectedButton  setTitle:@"查看" forState:UIControlStateNormal];
        [self.selectedButton  setImage:[UIImage imageNamed:[questionModel.collected integerValue]==1 ? @"start" : @""] forState:UIControlStateNormal];
        [self.selectedButton layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleRight imageTitleSpace:5];

    }  else {
        self.bgView.layer.contents = (__bridge id)[UIImage gradientBackImgWithFrame:CGRectMake(0, 0, URScreenWidth()-10, 120-10) startColor:UR_ColorFromValue(0x63c7ff) endColor:UR_ColorFromValue(0x3da8f8) direction:0].CGImage;

        self.selectedButton.backgroundColor = UR_ColorFromValue(0xF2724F);
        [self.selectedButton  setTitle:@"立即做题" forState:UIControlStateNormal];
        [self.selectedButton  setImage:nil forState:UIControlStateNormal];
    }
}

@end
