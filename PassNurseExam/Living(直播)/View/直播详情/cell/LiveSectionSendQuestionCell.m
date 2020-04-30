//
//  LiveSectionSendQuestionCell.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/23.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionSendQuestionCell.h"

@interface LiveSectionSendQuestionCell ()

@property (nonatomic,strong) UILabel *tempLb;

@end

@implementation LiveSectionSendQuestionCell


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
    [self.contentView addSubview:self.imgV];
    [self.contentView addSubview:self.questionLb];
    [self.contentView addSubview:self.tipLb];
    [self.contentView addSubview:self.sendBtn];
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(350*AUTO_WIDTH, 190*AUTO_WIDTH));
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_offset(0);
    }];
    [self.questionLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12 * AUTO_WIDTH);
        make.right.mas_equalTo(-12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.imgV.mas_bottom).offset(12*AUTO_WIDTH);
    }];
    
    self.answerArr = [NSMutableArray array];
    NSArray *arr = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    
    for (int i = 0; i < 6; i++)
    {
        UILabel *lab1 = [UILabel borderLabelWithRadius:(23/2.0)*AUTO_WIDTH borderColor:UR_ColorFromValue(0xCCCCCC) borderWidth:1 title:arr[i] titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize14) textAlignment:NSTextAlignmentCenter numberLines:1];
        
        UILabel *lab2 = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize15) textAlignment:NSTextAlignmentLeft numberLines:0];
        
        [self.contentView addSubview:lab1];
        [self.contentView addSubview:lab2];
        
        [self.answerArr addObject:@[lab1,lab2]];
        
        if (self.tempLb)
        {
            [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15 * AUTO_WIDTH);
                make.size.mas_equalTo(CGSizeMake(23*AUTO_WIDTH, 23*AUTO_WIDTH));
                make.top.mas_equalTo(self.tempLb.mas_bottom).offset(10*AUTO_WIDTH);
            }];
        }else
        {
            [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15 * AUTO_WIDTH);
                make.size.mas_equalTo(CGSizeMake(23*AUTO_WIDTH, 23*AUTO_WIDTH));
                make.top.mas_equalTo(self.questionLb.mas_bottom).offset(25*AUTO_WIDTH);
            }];
        }
        
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(49 * AUTO_WIDTH);
            make.right.mas_equalTo(-15 * AUTO_WIDTH);
            make.height.mas_greaterThanOrEqualTo(23*AUTO_WIDTH);
            make.top.mas_equalTo(lab1);
        }];
        
        self.tempLb = lab2;
    }

    
    [self.tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12 * AUTO_WIDTH);
        make.top.mas_equalTo(self.tempLb.mas_bottom).offset(10*AUTO_WIDTH);
        make.height.mas_greaterThanOrEqualTo(20*AUTO_WIDTH);
    }];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90*AUTO_WIDTH, 32*AUTO_WIDTH));
        make.right.mas_equalTo(-12 * AUTO_WIDTH);
        make.centerY.mas_equalTo(self.tipLb);
        make.bottom.mas_offset(-15*AUTO_WIDTH);
    }];
}

-(void)setAllQuestionsDataModel:(LiveSectionAllQuestionsDataModel *)dataModel  index:(NSString *)index{
    
    if ([NSString  isBlank:dataModel.picture]) {
        self.imgV.hidden = YES ;
        
        [self.questionLb  mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12 *AUTO_WIDTH) ;
        }] ;
        
    } else {
        self.imgV.hidden = NO ;
        
        [self.questionLb  mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgV.mas_bottom).offset(12*AUTO_WIDTH);
        }] ;
        
        [self.imgV  sd_setImageWithURL:[NSURL  URLWithString:dataModel.picture]];
    }
    
    self.questionLb.attributedText = [NSMutableAttributedString ur_changeColorWithColor:UR_ColorFromValue(0xFF9600) totalString:[NSString  stringWithFormat:@"%ld.【单选】%@",(long)index.integerValue+1,dataModel.title?:@""] subStringArray:@[@"【单选】"]];
    
    @weakify(self);
    
    [self.answerArr enumerateObjectsUsingBlock:^(NSArray * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        @strongify(self);
        
        UILabel *lab1 = obj[0];
        UILabel *lab2 = obj[1];
        
        NSString *optionStr = @"";
        if (idx == 0 && dataModel.option1.length > 0) {
            optionStr = dataModel.option1;
        }
        else if (idx == 1 && dataModel.option2.length > 0) {
            optionStr = dataModel.option2;
        }
        else if (idx == 2 && dataModel.option3.length > 0) {
            optionStr = dataModel.option3;
        }
        else if (idx == 3 && dataModel.option4.length > 0) {
            optionStr = dataModel.option4;
        }
        else if (idx == 4 && dataModel.option5.length > 0) {
            optionStr = dataModel.option5;
        }
        else if (idx == 5 && dataModel.option6.length > 0) {
            optionStr = dataModel.option6;
        }
        
        if (optionStr.length > 0) {
            self.tempLb = lab2;
            
            if (dataModel.answer.integerValue == idx+1) {
                //正确答案
                lab2.text = [NSString stringWithFormat:@"%@  (正确答案)",optionStr];

                lab2.textColor = UR_ColorFromValue(0xFF4747);
                lab1.backgroundColor = UR_ColorFromValue(0xFF4747);
                lab1.textColor = [UIColor whiteColor];
                lab1.layer.borderColor = UR_ColorFromValue(0xFF4747).CGColor;
            }else {
                lab2.text = optionStr;
                
                lab2.textColor = UR_ColorFromValue(0x333333);
                lab1.backgroundColor = [UIColor whiteColor];
                lab1.textColor = UR_ColorFromValue(0x333333);
                lab1.layer.borderColor = UR_ColorFromValue(0xCCCCCC).CGColor;
            }
        }else {
            lab1.hidden = lab2.hidden = YES;
        }
    }];
    
    [self.tipLb mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tempLb.mas_bottom).offset(10*AUTO_WIDTH);
    }];
    
    if (dataModel.is_sel.integerValue==1) {
        self.tipLb.text = @"已抢答结束" ;
        [self.sendBtn  setTitle:@"答题详情" forState:UIControlStateNormal];
    } else {
        self.tipLb.text = @"未开始抢答" ;
        [self.sendBtn  setTitle:@"开始抢答" forState:UIControlStateNormal];
    }
    
}

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.backgroundColor = UR_COLOR_BACKGROUND_ALL;
    }
    return _imgV;
}

- (UILabel *)questionLb
{
    if (!_questionLb) {
        _questionLb = [UILabel normalLabelWithTitle:@"" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize15) textAlignment:NSTextAlignmentLeft numberLines:0];
    }
    return _questionLb;
}

- (UILabel *)tipLb
{
    if (!_tipLb) {
        _tipLb = [UILabel normalLabelWithTitle:@"抢答进行中" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize18) textAlignment:NSTextAlignmentLeft numberLines:1];
    }
    return _tipLb;
}

- (UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton cornerBtnWithRadius:16*AUTO_WIDTH title:@"开始抢答" titleColor:[UIColor whiteColor] titleFont:RegularFont(FontSize16) backColor:UR_ColorFromValue(0x59A2FF)];
    }
    return _sendBtn;
}

@end
