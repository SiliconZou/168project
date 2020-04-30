//
//  HomeArticleSearchModel.h
//  PassNurseExam
//
//  Created by quchao on 2019/10/8.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URCommonObject.h"

@class HomeArticleSearchDataModel , HomeArticleSearchDataDataModel ;

NS_ASSUME_NONNULL_BEGIN

@interface HomeArticleSearchModel : URCommonObject

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * msg;

@property (nonatomic,strong) HomeArticleSearchDataModel * data;

@end

@interface HomeArticleSearchDataModel : URCommonObject

@property (nonatomic,copy) NSString * current_page;

@property (nonatomic,copy) NSString * first_page_url;

@property (nonatomic,copy) NSString * from;

@property (nonatomic,copy) NSString * next_page_url;

@property (nonatomic,copy) NSString * path;

@property (nonatomic,copy) NSString * per_page;

@property (nonatomic,copy) NSString * prev_page_url;

@property (nonatomic,copy) NSString * to;

@property (nonatomic,strong) NSArray <HomeArticleSearchDataDataModel *> * data;


@end

@interface HomeArticleSearchDataDataModel : URCommonObject

@property (nonatomic,copy) NSString * idStr;

@property (nonatomic,copy) NSString * category_id;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * click;

@property (nonatomic,copy) NSString * thumb;

@property (nonatomic,copy) NSString * updated_at;

@property (nonatomic,copy) NSString * url;


@end

NS_ASSUME_NONNULL_END
