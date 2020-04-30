//
//  ReportErrorsVC.m
//  PassNurseExam
//
//  Created by qc on 2019/9/18.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "ReportErrorsVC.h"

@interface ReportErrorsVC ()

@property (nonatomic,strong) UITextView *errorTextView;

@end

@implementation ReportErrorsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cSuperTitle = @"报错内容";
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImg = [UIImageView new];
    [self.view addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_offset(0);
    }];
    
    UIScrollView *scro = [[UIScrollView alloc] init];
    scro.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scro];
    [scro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(URSafeAreaNavHeight(), 0, 0, 0));
    }];
    
    UILabel *titleLb = [UILabel normalLabelWithTitle:@"问题类型：" titleColor:UR_ColorFromValue(0x333333) font:RegularFont(FontSize16) textAlignment:NSTextAlignmentLeft numberLines:1];
    [scro addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30 * AUTO_WIDTH);
        make.top.mas_offset(20 * AUTO_WIDTH);
    }];
    
    NSMutableArray *btnArr = [NSMutableArray array];
    NSArray *textArr = @[@"有错别字",@"答案不符或有疑问",@"知识错误",@"解析不对",@"超纲或不属于本章节",@"内容侵权"];
    for (int i = 0; i < textArr.count; i++)
    {
        UIButton *btn = [UIButton normalBtnWithTitle:textArr[i] titleColor:UR_ColorFromValue(0x333333) titleFont:RegularFont(FontSize16)];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:[UIImage imageNamed:@"box_n"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"box_s"] forState:UIControlStateSelected];
        
        [scro addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(65 * AUTO_WIDTH);
            make.right.mas_offset(65 * AUTO_WIDTH);
            make.top.mas_offset(66 * AUTO_WIDTH + 50 * AUTO_WIDTH * i);
        }];
        [btn layoutButtonWithEdgeInsetsStyle:URButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        
        btn.tag = 10 + i;
        [btnArr addObject:btn];
        
        if (i == textArr.count - 1)
        {
            EaseTextView *textView = [EaseTextView new];
            textView.textColor = UR_ColorFromValue(0x333333);
            textView.font = RegularFont(FontSize15);
            textView.layer.borderColor = UR_COLOR_LINE.CGColor;
            textView.layer.borderWidth = 1;
            textView.layer.cornerRadius = 8;
            textView.layer.masksToBounds = YES;
            textView.placeHolder = @"请在此输入您反馈的信息内容";

            [scro addSubview:textView];
            [textView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(315 * AUTO_WIDTH, 140 * AUTO_WIDTH));
                make.centerX.mas_equalTo(self.view);
                make.top.mas_equalTo(btn.mas_bottom).offset(20 * AUTO_WIDTH);
            }];
            
            self.errorTextView = textView;
            
            UIButton *commitBtn = [UIButton cornerBtnWithRadius:5 title:@"提交" titleColor:[UIColor whiteColor] titleFont:RegularFont(16) backColor:UR_ColorFromValue(0x59A2FF)];
            [scro addSubview:commitBtn];
            [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(90 * AUTO_WIDTH, 40 * AUTO_WIDTH));
                make.right.mas_equalTo(textView.mas_right).offset(-40 * AUTO_WIDTH);
                make.top.mas_equalTo(self.errorTextView.mas_bottom).offset(25 * AUTO_WIDTH);
                make.bottom.mas_offset(-30 * AUTO_WIDTH);
            }];
            
            [[commitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                [self reportError];
            }];
        }
        
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            btn.selected = !btn.isSelected;
            
            __block NSString *errorContent = @"";
            
            [btnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (obj.selected == YES)
                {
                    errorContent = [[errorContent stringByAppendingString:textArr[idx]] stringByAppendingString:@"，"];
                }
            }];
            
            self.errorTextView.text = errorContent;

        }];
    }
    
}

- (void)reportError
{
    [[URCommonApiManager sharedInstance] reportErrorWithItemid:self.itemIdStr describeStr:self.errorTextView.text token:[URUserDefaults  standardUserDefaults].userInforModel.api_token?:@"" requestSuccessBlock:^(id response, NSDictionary *responseDict) {
        
        [URToastHelper showErrorWithStatus:@"提交成功"];
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } requestFailureBlock:^(NSError *error, id response) {
        
    }];
}

@end
