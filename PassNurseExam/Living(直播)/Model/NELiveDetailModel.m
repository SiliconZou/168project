//
//  NELiveDetailModel.m
//  PassTheNurseExam
//
//  Created by Best on 2019/2/15.
//  Copyright © 2019 LeFu. All rights reserved.
//

#import "NELiveDetailModel.h"

@implementation NELiveDetailUserItem


@end


@implementation NELiveAppointmentModel


@end

@implementation NELiveDetailItem

+(NSDictionary *)mj_objectClassInArray {
    return @{@"userList": NELiveDetailUserItem.class
             };
}

-(void)mj_keyValuesDidFinishConvertingToObject {
    self.userNumberStr = [NSString stringWithFormat:@"%@人在线", self.userNumber];

    [self setupState];
    
}

-(void)setState:(NELiveDetailState)state {
	_state = state;

	[self setupState];
}

- (void)setupState {
    self.stateTitle = @"立即预约";
    self.stateColor = RGB(239, 114, 85);
    
    switch (self.state) {
        case NELiveDetailStateAppointment:
            self.stateTitle = @"已预约";
            self.stateColor = RGB(95, 183, 96);
            break;
            
        case NELiveDetailStateManager:
            self.stateTitle = [NSString stringWithFormat:@"  %@  ", self.userNumberStr];
            self.stateColor = RGB(69, 195, 232);
            break;
            
        default:
            break;
    }
}


@end

@implementation NELiveUrlModel

-(void)mj_keyValuesDidFinishConvertingToObject {
	self.videoSourceType = ([self.nameUrl containsString:@"/DSHZS"]) ? 2 : 1;
}



@end


@implementation NELiveDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"detailItem": @"beanList"};
}

//+ (NSDictionary *)getTestData {
//    NSString *filePath = [[NSBundle bundleForClass:self.class] pathForResource:@"直播详情" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    return [data mj_JSONObject];
//}


@end
