//
//  HomePageNewsInforMoreModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019年 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class HomePageNewsInforMoreListModel ;

NS_ASSUME_NONNULL_BEGIN

@interface HomePageNewsInforMoreModel : URCommonObject

@property (nonatomic,copy) NSString * current_page;

@property (nonatomic,copy) NSString * first_page_url;

@property (nonatomic,copy) NSString * from;

@property (nonatomic,copy) NSString * next_page_url;

@property (nonatomic,copy) NSString * path;

@property (nonatomic,copy) NSString * per_page;

@property (nonatomic,copy) NSString * prev_page_url;

@property (nonatomic,copy) NSString * to;

@property (nonatomic,strong) NSArray <HomePageNewsInforMoreListModel *> * data;

@end

@interface HomePageNewsInforMoreListModel : URCommonObject

@property (nonatomic,copy) NSString * category_id;

@property (nonatomic,copy) NSString * click;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * thumb;

@property (nonatomic,copy) NSString * path;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * url;

@end

NS_ASSUME_NONNULL_END
