//
//  HomePageNewsInforTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "HomePageNewsInforTableViewCell.h"

@interface HomePageNewsInforTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation HomePageNewsInforTableViewCell

-(void)setModel:(id)model{
    
    _model = model ;
    
    if ([model  isKindOfClass:[HomePageNewsInforFirstClassArticleListModel  class]]) {
        
        HomePageNewsInforFirstClassArticleListModel * listModel = model ;
        
        [self.iconImage sd_setImageWithURL:[NSURL  URLWithString:listModel.thumb?:@""] placeholderImage:[UIImage  imageNamed:@"占位图"]];
        
        self.titleLabel.text = [NSString  stringWithFormat:@"%@",listModel.title?:@""] ;
        NSDate *newsDate = listModel.updated_at.ur_date_Day;
        NSString *newsStr = newsDate.timeTextOfDate;
        self.subTitleLabel.text = [NSString  stringWithFormat:@"%@ 浏览量:%@",newsStr?:@"",listModel.click?:@""] ;
        
    } else if ([model  isKindOfClass:[HomePageNewsInforMoreListModel  class]]){
        
        HomePageNewsInforMoreListModel * listModel = model ;
        
        [self.iconImage sd_setImageWithURL:[NSURL  URLWithString:listModel.thumb?:@""] placeholderImage:[UIImage  imageNamed:@"占位图"]];
        
        self.titleLabel.text = [NSString  stringWithFormat:@"%@",listModel.title?:@""] ;
        NSDate *newsDate = listModel.updated_at.ur_date_Day;
        NSString *newsStr = newsDate.timeTextOfDate;
        self.subTitleLabel.text = [NSString  stringWithFormat:@"%@ 浏览量:%@",newsStr?:@"",listModel.click?:@""] ;
        
    } else if ([model  isKindOfClass:[HomeArticleSearchDataDataModel  class]]){
        
        HomeArticleSearchDataDataModel * searchModel = model ;
        
        [self.iconImage sd_setImageWithURL:[NSURL  URLWithString:searchModel.thumb?:@""] placeholderImage:[UIImage  imageNamed:@"占位图"]];
        
        self.titleLabel.text = [NSString  stringWithFormat:@"%@",searchModel.title?:@""] ;
        NSDate *newsDate = searchModel.updated_at.ur_date_Day;
        NSString *newsStr = newsDate.timeTextOfDate;
        self.subTitleLabel.text = [NSString  stringWithFormat:@"%@ 浏览量:%@",newsStr?:@"",searchModel.click?:@""] ;
    } else {
        [self.iconImage sd_setImageWithURL:[NSURL  URLWithString:model[@"thumb"]?:@""] placeholderImage:[UIImage  imageNamed:@"占位图"]];
        
        self.titleLabel.text = [NSString  stringWithFormat:@"%@",model[@"title"]?:@""] ;
        NSDate *newsDate = ((NSString *) model[@"updated_at"]).ur_date_Day;
        NSString *newsStr = newsDate.timeTextOfDate;
        self.subTitleLabel.text = [NSString  stringWithFormat:@"%@ 浏览量:%@",newsStr?:@"",model[@"click"]?:@""] ;
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
