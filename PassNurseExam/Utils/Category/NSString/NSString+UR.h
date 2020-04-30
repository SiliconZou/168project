//
//  NSString+UR.h
//  PassNurseExam
//
//  Created by qc on 2018/8/20.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UR)

// 计算字符串所占size
- (CGSize)ur_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


/**
 姓名格式: 超过三位显示'...'
 
 @return 姓名格式: 超过三位显示'...'
 */
- (NSString *)ur_formaterName;

- (NSString *)ur_formaterLength:(NSUInteger)length;

// 截取至指定长度，已处理表情情形
- (NSString *)ur_limitLength:(int)length;


// url 参数解析
- (NSDictionary *)ur_urlQueryParse;

- (NSDictionary*)ur_URLQueryDictionary ;

//设置一个label里面不同字样
+(NSMutableAttributedString *)numremobertion:(NSString *)str number:(NSInteger)num;

- (NSString *)ur_urlEncode;

// 银行卡号前9位
- (NSString *)ur_bankcardHeadNine;

// 银行卡号后4位
- (NSString *)ur_bankcardTail;

@end
