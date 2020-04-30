//
//  HomePageNewsInforModel.h
//  PassNurseExam
//
//  Created by qc on 2019/9/11.
//  Copyright © 2019 ucmed. All rights reserved.
//  最新资讯model

#import "URCommonObject.h"

@class HomePageNewsInforClassListModel , HomePageNewsInforFirstClassArticleListModel , HomePageNewsInforNavModel ;

NS_ASSUME_NONNULL_BEGIN

@interface HomePageNewsInforModel : URCommonObject

@property (nonatomic,strong) NSMutableArray <HomePageNewsInforClassListModel *> *classList;

@property (nonatomic,strong) NSArray <HomePageNewsInforFirstClassArticleListModel *> *firstClassArticleList;

@property (nonatomic,strong) NSArray <HomePageNewsInforNavModel *> * nav;

@end

@interface HomePageNewsInforClassListModel : URCommonObject

@property (nonatomic,copy) NSString * category_id;

@property (nonatomic,copy) NSString * category_name;

@end

@interface HomePageNewsInforFirstClassArticleListModel : URCommonObject

@property (nonatomic,copy) NSString * category_id;

@property (nonatomic,copy) NSString * click;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * thumb;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * url;

@end

@interface HomePageNewsInforNavModel : URCommonObject

@property (nonatomic,copy) NSString * category_id;

@property (nonatomic,copy) NSString * click;

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * thumb;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * url;

@end

NS_ASSUME_NONNULL_END
