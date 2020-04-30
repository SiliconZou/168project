//
//  CourseDownloadTableViewCell.h
//  PassNurseExam
//
//  Created by qc on 2019/9/19.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^backVideoBlock)(NSString *str);


@interface CourseDownloadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

@property (nonatomic, assign) NSInteger net;

@property (nonatomic, strong) UIViewController *currentController;

@property (nonatomic, strong) CourseCommonDetailDataCurriculumsModel * curriculumsModel;

@property (nonatomic, copy) backVideoBlock bBackVideoBlock;

- (void)start;
- (void)resume;
- (void)pause;


@end

NS_ASSUME_NONNULL_END
