//
//  LiveSectionCatalogCell.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/11.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionCatalogCell : UITableViewCell

@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UILabel *timeLb;
@property (nonatomic,strong) UIButton *stateBtn;

@property (nonatomic,strong) LiveSectionDetailData1SectionModel *model;

@end

NS_ASSUME_NONNULL_END
