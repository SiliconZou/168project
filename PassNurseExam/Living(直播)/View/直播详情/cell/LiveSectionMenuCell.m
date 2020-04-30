//
//  LiveSectionMenuCell.m
//  PassNurseExam
//
//  Created by helingmin on 2019/11/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "LiveSectionMenuCell.h"

@implementation LiveSectionMenuCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.menuSubject = [RACSubject subject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUIWithReuseIdentifier:reuseIdentifier];
    }
    return self;
}

- (void)createUIWithReuseIdentifier:(NSString *)reuseIdentifier
{
    UIView *line = [UIView new];
    line.backgroundColor = UR_ColorFromValue(0xFFAF57);
    [self addSubview:line];
    
    NSArray *item;
    NSMutableArray *arr = [NSMutableArray array];
    
    if ([reuseIdentifier isEqualToString:@"LiveSectionMenuThreeCellIdentifier"]){// 普通用户未购买
        item = @[@[@"课程详情",@"0"],@[@"课程目录",@"1"],@[@"配套资料",@"2"]];
    } else if ([reuseIdentifier isEqualToString:@"LiveSectionMenuManagerCellIdentifier"]){ // 管理员
        item = @[@[@"直播大厅",@"3"],@[@"课程目录",@"1"],@[@"电子讲义",@"4"],@[@"在线抢答",@"5"]];
    } else if ([reuseIdentifier isEqualToString:@"LiveSectionMenuFourCellIdentifier"]){ // 普通用户已购买
        item = @[@[@"直播大厅",@"3"],@[@"课程目录",@"1"],@[@"电子讲义",@"4"],@[@"配套资料",@"2"]];
    } else if ([reuseIdentifier isEqualToString:@"LiveSectionOnlineAnswerCellIdentifier"]){
        item = @[@[@"全部",@"6"],@[@"已发送",@"7"],@[@"未发送",@"8"]];
        line.hidden = YES ;
    }
    
    [item enumerateObjectsUsingBlock:^(NSArray *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *btn = [UIButton normalBtnWithTitle:obj[0] titleColor:UR_ColorFromValue(0x333333)  titleFont:RegularFont(FontSize16)];
        [btn setTitleColor:UR_ColorFromValue(0xFFAF57) forState:UIControlStateSelected];
        
        [self.contentView addSubview:btn];
        
        CGFloat itemW = URScreenWidth() / item.count;
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(itemW);
            make.height.mas_equalTo(46*AUTO_WIDTH);
            make.top.bottom.mas_offset(0);
            make.centerX.mas_equalTo(self.contentView.mas_left).offset(itemW * idx + itemW/2.0);
        }];
        
        [arr addObject:btn];
        
        if (idx == 0) {
            btn.selected = YES;
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(69*AUTO_WIDTH, 2));
                make.centerX.mas_equalTo(btn);
                make.bottom.mas_offset(0);
            }];
        }
        
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [arr enumerateObjectsUsingBlock:^(UIButton  *  _Nonnull objbtn, NSUInteger index, BOOL * _Nonnull stop) {
                if (index == idx) {
                    objbtn.selected = YES;
                    [line mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(69*AUTO_WIDTH, 2));
                        make.bottom.mas_offset(0);
                        make.centerX.mas_equalTo(objbtn);
                    }];
                }else {
                    objbtn.selected = NO;
                }
            }];
            
            [self.menuSubject sendNext:obj[1]];
        }];
    }];
    
    [self bringSubviewToFront:line];
}
 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
