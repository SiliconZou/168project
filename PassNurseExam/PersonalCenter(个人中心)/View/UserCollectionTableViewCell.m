//
//  UserCollectionTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 2019/10/1.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "UserCollectionTableViewCell.h"

@interface  UserCollectionTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;


@end

@implementation UserCollectionTableViewCell

-(void)setDataModel:(WrongRankingDataModel *)dataModel{
    
    _dataModel = dataModel ;
    
    self.contentLabel.text = [NSString  stringWithFormat:@"%@",dataModel.title?:@""] ;
    
    self.idLabel.text = [NSString  stringWithFormat:@"ID:%@",dataModel.idStr?:@""] ;
    
    self.countLabel.text = [NSString  stringWithFormat:@"做题次数:%@",dataModel.finished_count] ;
    
    if (dataModel.error_count.integerValue >0 & dataModel.finished_count.integerValue>0) {
        CGFloat accuracy = dataModel.error_count.floatValue/dataModel.finished_count.floatValue ;
        self.accuracyLabel.text = [NSString  stringWithFormat:@"综合正确率:%.f%@",accuracy*100,@"%"] ;
    } else {
        self.accuracyLabel.text = @"综合正确率:0%" ;
    }
    
    
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
