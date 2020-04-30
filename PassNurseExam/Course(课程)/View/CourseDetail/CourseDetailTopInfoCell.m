//
//  CourseDetailTopInfoCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "CourseDetailTopInfoCell.h"

@implementation CourseDetailTopInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return  self;
}

- (void)createUI
{ 
    [self.contentView addSubview:self.courseNameLb];
    [self.contentView addSubview:self.coursePriceLb];
    [self.contentView addSubview:self.studyNumLb];
    [self.contentView addSubview:self.downloadBtn];
    [self.contentView addSubview:self.collectBtn];
    [self.contentView addSubview:self.shareBtn];
 
    [self.courseNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12 * AUTO_WIDTH);
        make.top.mas_equalTo(14 * AUTO_WIDTH);
        make.right.mas_offset(-12 * AUTO_WIDTH);
    }];
    [self.coursePriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.courseNameLb);
        make.top.mas_equalTo(self.courseNameLb.mas_bottom).offset(10 * AUTO_WIDTH);
        make.bottom.mas_offset(-12 * AUTO_WIDTH);
    }];
    [self.studyNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coursePriceLb.mas_right).offset(15 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.coursePriceLb);
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40 * AUTO_WIDTH, 40 * AUTO_WIDTH));
        make.right.mas_offset(0);
        make.centerY.mas_equalTo(self.coursePriceLb);
    }];
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40 * AUTO_WIDTH, 40 * AUTO_WIDTH));
        make.right.mas_equalTo(self.shareBtn.mas_left);
        make.centerY.mas_equalTo(self.shareBtn);
    }];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40 * AUTO_WIDTH, 40 * AUTO_WIDTH));
        make.right.mas_equalTo(self.downloadBtn.mas_left);
        make.centerY.mas_equalTo(self.shareBtn);
    }];

}


-(void)setModel:(BaseCourseModel *)model
{
    _model = model ;
    
    self.courseNameLb.text = [NSString  stringWithFormat:@"%@",model.name?:@""] ;

    
    
    if (model.vip.integerValue == 1)
    {
        self.coursePriceLb.text = @"会员课程";
    } else
    {
        //charge 是否收费  1收费  0不收费
        if (model.charge.integerValue == 0)
        {
            self.coursePriceLb.text = @"免费" ;
        } else
        {
            if ([model.own integerValue] == 1) {
                if (is_online==0) {
                    self.coursePriceLb.text = @"已激活";
                } else {
                    self.coursePriceLb.text = @"已购买";
                }
            }else {
                if (is_online==0) {
                    self.coursePriceLb.text = @"" ;
                } else {
                    self.coursePriceLb.text = [NSString  stringWithFormat:@"¥%@",model.univalence?:@""] ;
                }
            }
        }
    }
    self.studyNumLb.text = [NSString  stringWithFormat:@"学习人数:%@",model.click?:@"0"] ;
}

- (void)setChapterModel:(CourseCommonDetailDataModel *)chapterModel
{
    _chapterModel = chapterModel;
    
    self.courseNameLb.text = chapterModel.name;
    
    if (chapterModel.vip.integerValue == 1)
    {
        self.coursePriceLb.text = @"会员课程";
    } else
    {
        if (chapterModel.charge.integerValue == 0)
        {
           self.coursePriceLb.text = @"免费" ;
        } else
        {
            if ([chapterModel.own integerValue] == 1) {
                if (is_online==0) {
                    self.coursePriceLb.text = @"已激活";
                } else {
                    self.coursePriceLb.text = @"已购买";
                }
            }else {
                if (is_online==0) {
                    self.coursePriceLb.text = @"" ;
                } else {
                    self.coursePriceLb.text = [NSString  stringWithFormat:@"¥%@",chapterModel.univalence?:@""] ;
                }
            }
        }
    }
    
    __block NSInteger sum = 0;
    [chapterModel.curriculums enumerateObjectsUsingBlock:^(CourseCommonDetailDataCurriculumsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sum += [obj.click integerValue];
    }];
    self.studyNumLb.text = [NSString  stringWithFormat:@"学习人数:%zd",sum];
}

- (void)setCurriculumsModel:(CourseCommonDetailDataCurriculumsModel *)curriculumsModel
{
    _curriculumsModel = curriculumsModel;
    
    self.courseNameLb.text = curriculumsModel.name;
    
    if (curriculumsModel.vip.integerValue == 1)
    {
        self.coursePriceLb.text = @"会员课程";
    } else
    {
        if (curriculumsModel.charge.integerValue == 0)
        {
            self.coursePriceLb.text = @"免费" ;
        } else
        {
            if ([curriculumsModel.own integerValue] == 1) {
                if (is_online==0) {
                    self.coursePriceLb.text = @"已激活";
                } else {
                    self.coursePriceLb.text = @"已购买";
                }
            }else {
                self.coursePriceLb.text = [NSString  stringWithFormat:@"¥%@",curriculumsModel.univalence?:@""] ;
            }
        }
    }
    self.studyNumLb.text = [NSString  stringWithFormat:@"学习人数:%@",curriculumsModel.click?:@"0"] ;
}


- (UILabel *)courseNameLb
{
    if (!_courseNameLb) {
        _courseNameLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:2];
    }
    return _courseNameLb;
}

- (UILabel *)coursePriceLb
{
    if (!_coursePriceLb) {
        _coursePriceLb = [UILabel normalLabelWithTitle:@"￥0" titleColor:UR_ColorFromValue(0xFF773A) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _coursePriceLb;
}

- (UILabel *)studyNumLb
{
    if (!_studyNumLb) {
        _studyNumLb = [UILabel normalLabelWithTitle:@"学习人数：0" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _studyNumLb;
}

- (UIButton *)downloadBtn
{
    if (!_downloadBtn) {
        _downloadBtn = [UIButton ImgBtnWithImageName:@"xiazaiico"];
    }
    return _downloadBtn;
}

-(UIButton *)collectBtn
{
    if (!_collectBtn) {
        _collectBtn = [UIButton ImgBtnWithImageName:@""];//kechengshoucangico
    }
    return _collectBtn;
}

-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton ImgBtnWithImageName:@""];//fenxaing
    }
    return _shareBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
