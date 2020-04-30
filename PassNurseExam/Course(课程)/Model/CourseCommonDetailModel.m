//
//  CourseCommonDetailModel.m
//  PassNurseExam
//
//  Created by qc on 2019/9/16.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseCommonDetailModel.h"

@implementation CourseCommonDetailModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"data":[CourseCommonDetailDataModel  class] ,
             @"data1":[BaseCourseModel  class]
             } ;
}

@end

@implementation CourseCommonDetailDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"curriculums":[CourseCommonDetailDataCurriculumsModel  class]
             } ;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}


@end

@implementation CourseCommonDetailDataCurriculumsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idStr":@"id"
             };
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"download_address"]) {
        NSString *urlString = value;
        //汉字转码
        urlString = [urlString  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        self.download_address = urlString;
        return;
    }
    [super setValue:value forKey:key];
}
@end
