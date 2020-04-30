//
//  CourseCombinationDetailTopTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/17.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseCombinationDetailTopTableViewCell.h"

@interface CourseCombinationDetailTopTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *corseImgH;//图片高度
@property (weak, nonatomic) IBOutlet UIImageView * corseImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *personCountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *courseTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseStageCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *coursePriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teacherIconImage;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;

@property (nonatomic,strong) NSMutableArray <UIButton *> *btnTempArr;//暂时存放多个老师的按钮

@end

@implementation CourseCombinationDetailTopTableViewCell

-(void)setDataModel:(id)dataModel{
    
    NSLog(@"----------------------------------------------%@",dataModel) ;
    
    if ([dataModel  isKindOfClass:[CourseCombinationDetailModel  class]]) {
        
        CourseCombinationDetailModel * combinationModel = dataModel ;
         
        [self.corseImageView sd_setImageWithURL:[NSURL URLWithString:combinationModel.data.advert] placeholderImage:nil];
        
        self.titleLabel.text = [NSString  stringWithFormat:@"%@",combinationModel.data.name?:@""] ;
        
        self.courseCountLabel.text = [NSString  stringWithFormat:@"%@",combinationModel.data.describe?:@""] ;
        
        if (is_online==1) {
            self.priceLabel.text = [NSString  stringWithFormat:@"¥%@元",combinationModel.data.univalence?:@""] ;
            
            self.originPriceLabel.text = [NSString  stringWithFormat:@"原价¥%@元",combinationModel.data.original_price?:@""] ;
            
            self.personCountLabel.text = [NSString  stringWithFormat:@"%@人购买",combinationModel.data.nums?:@""] ;
            
        } else {
            self.priceLabel.text = @"";
            
            self.originPriceLabel.text = @"";
            
            self.personCountLabel.text = [NSString  stringWithFormat:@"%@人学习",combinationModel.data.nums?:@""] ;
        }
        
    }
    else if ([dataModel  isKindOfClass:[BaseCourseModel  class]])
    {
        BaseCourseModel * stageModel = dataModel ;
        
        [self.iconImageView sd_setImageWithURL:[NSURL  URLWithString:stageModel.thumbnail] placeholderImage:[UIImage  imageNamed:@"占位图"]];
        self.courseTitleLabel.text = [NSString  stringWithFormat:@"%@",stageModel.name?:@""] ;
        self.courseSubTitleLabel.text = [NSString  stringWithFormat:@"%@",stageModel.describe?:@""] ;
        self.courseStageCountLabel.text  = [NSString  stringWithFormat:@"%@",stageModel.class_hour?:@""] ;
        CGFloat stageCountLabelWidth = [stageModel.class_hour  ur_widthWithFont:RegularFont(11.0f) constrainedToHeight:15];
        [self.courseStageCountLabel  mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(stageCountLabelWidth+10) ;
        }];
        
        //vip ：是否是vip才可以看的视频   1是   0不是
        if ([stageModel.vip integerValue] == 1)
        {
            self.coursePriceLabel.text = @"会员课程";
        }else
        {
            //charge ：是否收费  1收费  0不收费
            if ([stageModel.charge integerValue] == 1 && [stageModel.univalence floatValue] > 0)
            {
                if (is_online==0) {
                    self.coursePriceLabel.text = @"";
                } else {
                    self.coursePriceLabel.text = [NSString  stringWithFormat:@"¥%.2f元",stageModel.univalence.floatValue];
                }
            } else {
                self.coursePriceLabel.text = @"免费";
            }
        }
        
        if (self.btnTempArr.count > 0) {
            [self.btnTempArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            [self.btnTempArr removeAllObjects];
        }
        
        if (stageModel.teachers.count>0)
        {
            CGFloat teacherWidth = (25*stageModel.teachers.count*AUTO_WIDTH + (stageModel.teachers.count-1)*8+10)*AUTO_WIDTH;
            
            [stageModel.teachers  enumerateObjectsUsingBlock:^(BaseCourseTeacherModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                UIButton * teacherIconButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
                [teacherIconButton  sd_setImageWithURL:[NSURL  URLWithString:obj.thumbnail] forState:UIControlStateNormal placeholderImage:[UIImage  imageNamed:@"占位图"]];
                teacherIconButton.layer.cornerRadius = 12.5f*AUTO_WIDTH;
                teacherIconButton.layer.masksToBounds = YES ;
                [self.contentView addSubview:teacherIconButton];
                [teacherIconButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(self.courseStageCountLabel);
                    make.left.mas_equalTo((URScreenWidth()-teacherWidth)+33*idx*AUTO_WIDTH);
                    make.size.mas_equalTo(CGSizeMake(25*AUTO_WIDTH, 25*AUTO_WIDTH));
                }];
                
                if (stageModel.teachers.count==1)
                {
                    self.teacherNameLabel.hidden = NO;
                    self.teacherNameLabel.text = [NSString  stringWithFormat:@"%@",stageModel.teachers[0].name?:@""] ;
                    CGFloat teacherNameWidth = [stageModel.teachers[0].name ur_widthWithFont:RegularFont(12.0f) constrainedToHeight:25] ;
                    [teacherIconButton  mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(URScreenWidth()-10*AUTO_WIDTH-teacherNameWidth-30*AUTO_WIDTH) ;
                    }];
                } else {
                    self.teacherNameLabel.hidden = YES;
                }
                
                [self.btnTempArr addObject:teacherIconButton];
            }];
        }
    }
    
}

- (IBAction)selectedButton:(UIButton *)sender {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImageView.layer.cornerRadius = 5.0f;
    self.iconImageView.layer.masksToBounds = YES ;
    
    self.courseStageCountLabel.layer.cornerRadius = 3.0f ;
    self.courseStageCountLabel.layer.masksToBounds = YES ;
    self.courseStageCountLabel.layer.borderColor = UR_ColorFromRGBA(249, 164, 97, 0.3).CGColor;
    self.courseStageCountLabel.layer.borderWidth= 1.0f;
    
    self.corseImgH.constant = 236 * AUTO_WIDTH;
    
    self.btnTempArr = [NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
