//
//  ConfirmPapersCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/29.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmPapersCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *cycleImageView;
@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UILabel *correctValueLb;//正确率值
@property (nonatomic,strong) UILabel *correctTitleLb;//正确率文字

@property (nonatomic,strong) UILabel *timeLb;//用时
@property (nonatomic,strong) UILabel *answeredNumLb;//已答
@property (nonatomic,strong) UILabel *correctNumLb;//准确

@property (nonatomic,strong) UIButton *timeUsedBtn;//答题用时
@property (nonatomic,strong) UIButton *answeredNumBtn;//已答题数
@property (nonatomic,strong) UIButton *correctNumBtn;//正确题数

@property (nonatomic,strong) UIButton *timeAllBtn;//总共时间
@property (nonatomic,strong) UIButton *allNumBtn1;//总共题数
@property (nonatomic,strong) UIButton *allNumBtn2;//总共题数

@property (nonatomic,strong) UIButton *checkAnswerBtn;//查看答题卡


@end

NS_ASSUME_NONNULL_END
