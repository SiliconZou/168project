//
//  CourseDetailSubCatalogueCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/12.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "CourseDetailSubCatalogueCell.h"

@implementation CourseDetailSubCatalogueCell

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
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.priceLb];
    [self.contentView addSubview:self.downloadBtn];
    [self.contentView addSubview:self.lockBtn];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(40 * AUTO_WIDTH);
        make.top.bottom.mas_offset(0);
    }];
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35 * AUTO_WIDTH, 35 * AUTO_WIDTH));
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_offset(-0 * AUTO_WIDTH);
    }];
    [self.lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.downloadBtn);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.downloadBtn.mas_left).offset(-0 * AUTO_WIDTH);
    }];
    [self.priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.lockBtn.mas_left).offset(-3 * AUTO_WIDTH);
        make.left.mas_equalTo(self.nameLb.mas_right).offset(3 * AUTO_WIDTH);
    }];
    [self.priceLb setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.priceLb setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

-(void)setCurriculumsModel:(CourseCommonDetailDataCurriculumsModel *)curriculumsModel{
    
    _curriculumsModel = curriculumsModel ;
    
    self.nameLb.text = [NSString  stringWithFormat:@"%@",curriculumsModel.name?:@""];
    self.priceLb.text = [NSString stringWithFormat:@"￥%@",curriculumsModel.univalence];
    
    //锁：表示未购买，播放按钮：表示已购买

    if (curriculumsModel.vip.intValue==1)//会员课程
    {
        self.priceLb.text = @"会员课程";
        
        if (userLoginStatus)
        {
            if ([[URUserDefaults  standardUserDefaults].userInforModel.is_vip integerValue]==1)
            {
              [self.lockBtn setImage:[UIImage imageNamed:@"player"] forState:UIControlStateNormal];
            } else {
                [self.lockBtn setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
            }
        } else {
           [self.lockBtn setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
        }
    } else
    {
        if (curriculumsModel.charge.intValue==1)//付费课程
        {
            if (curriculumsModel.own.intValue==0)//未购买
            {
                self.priceLb.text = [NSString stringWithFormat:@"￥%@",curriculumsModel.univalence];
                [self.lockBtn setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
            }else//已购买
            {
                if (is_online==0) {
                    self.priceLb.text = @"已激活";
                } else {
                    self.priceLb.text = @"已购买";
                }
                [self.lockBtn setImage:[UIImage imageNamed:@"player"] forState:UIControlStateNormal];
            }
        }else//免费课程
        {
            self.priceLb.text = @"免费";
            [self.lockBtn setImage:[UIImage imageNamed:@"player"] forState:UIControlStateNormal];
        }
    }
    
    TaskProgressInfo *info = [[DownloadManager shareManager] progressInfoIfFileExsit:curriculumsModel.download_address];
    
    // 绿色：已下载，灰色：未下载
    if (info)
    {
        if (info.progress>=1.0f)
        {
            [self.downloadBtn setImage:[UIImage  imageNamed:@"xiazai1"] forState:UIControlStateNormal];
        } else
        {
            [self.downloadBtn setImage:[UIImage  imageNamed:@"xiazai0"] forState:UIControlStateNormal];
        }
    } else
    {
        [self.downloadBtn setImage:[UIImage  imageNamed:@"xiazai0"] forState:UIControlStateNormal];
    }
}



- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel normalLabelWithTitle:@"2019真题全解析基础护理知识（01-30）" titleColor:UR_ColorFromValue(0x666666) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentLeft numberLines:1];
        _nameLb.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _nameLb;
}

- (UILabel *)priceLb
{
    if (!_priceLb) {
        _priceLb = [UILabel normalLabelWithTitle:@"￥1.99" titleColor:UR_ColorFromValue(0xF9A768) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentRight numberLines:1];
    }
    return _priceLb;
}

- (UIButton *)lockBtn
{
    if (!_lockBtn) {
        _lockBtn = [UIButton ImgBtnWithImageName:@"lock"];
    }
    return _lockBtn;
}

-(UIButton *)downloadBtn
{
    if (!_downloadBtn) {
        _downloadBtn = [UIButton ImgBtnWithImageName:@"xiazai0"];
    }
    return _downloadBtn;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
