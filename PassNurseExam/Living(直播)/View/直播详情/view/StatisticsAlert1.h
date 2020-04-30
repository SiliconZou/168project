//
//  StatisticsAlert1.h
//  PassNurseExam
//
//  Created by helingmin on 2019/11/24.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsAlert1 : UIView

@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UILabel *correctNumberLb;

@property (nonatomic,strong) NSArray * personalList;

- (void)showWithStaticsList:(NSArray *)list commit:(void(^)(void))commit cancel:(void(^)(void))cancel;

@end

NS_ASSUME_NONNULL_END
