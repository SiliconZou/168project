//
//  LiveSectionPDFTableViewCell.h
//  PassNurseExam
//
//  Created by quchao on 2019/11/18.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveSectionPDFTableViewCell : UITableViewCell

@property (nonatomic,strong) UIViewController * currentViewController;

@property (nonatomic,strong) LiveSectionDetailData1SectionModel * sectionModel;

@end

NS_ASSUME_NONNULL_END
