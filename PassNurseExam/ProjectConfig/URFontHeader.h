//
//  URFontHeader.h
//  PassNurseExam
//
//  Created by qc on 2018/8/16.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#ifndef URFontHeader_h
#define URFontHeader_h

//适配
#define AUTO_WIDTH [UIScreen mainScreen].bounds.size.width/375.0f
#define AUTO_HEIGHT [UIScreen mainScreen].bounds.size.height/667.0f


//细体
#define Font(fontsize) \
[UIFont fontWithName:@"PingFangSC-Light" size:fontsize]

//常规体 主用这个
#define RegularFont(fontsize) \
[UIFont fontWithName:@"PingFangSC-Regular" size:fontsize]
//[UIFont fontWithName:@"HiraginoSansGB-W3" size:fontsize]

//中粗体
#define BoldFont(fontsize) \
[UIFont fontWithName:@"PingFang-SC-Medium" size:fontsize]

// MARK: - Font size based on 750 width
#define FontSize8  8.f  * AUTO_WIDTH
#define FontSize9  9.f  * AUTO_WIDTH
#define FontSize10 10.f  * AUTO_WIDTH
#define FontSize11 11.f * AUTO_WIDTH
#define FontSize12 12.f * AUTO_WIDTH
#define FontSize13 13.f * AUTO_WIDTH
#define FontSize14 14.f * AUTO_WIDTH
#define FontSize15 15.f * AUTO_WIDTH
#define FontSize16 16.f * AUTO_WIDTH
#define FontSize17 17.f * AUTO_WIDTH
#define FontSize18 18.f * AUTO_WIDTH
#define FontSize19 19.f * AUTO_WIDTH
#define FontSize20 20.f * AUTO_WIDTH
#define FontSize21 21.f * AUTO_WIDTH
#define FontSize22 22.f * AUTO_WIDTH
#define FontSize23 23.f * AUTO_WIDTH
#define FontSize24 24.f * AUTO_WIDTH
#define FontSize25 25.f * AUTO_WIDTH
#define FontSize26 26.f * AUTO_WIDTH
#define FontSize27 27.f * AUTO_WIDTH
#define FontSize28 28.f * AUTO_WIDTH
#define FontSize29 29.f * AUTO_WIDTH
#define FontSize30 30.f * AUTO_WIDTH
#define FontSize31 31.f * AUTO_WIDTH
#define FontSize32 32.f * AUTO_WIDTH
#define FontSize35 35.f * AUTO_WIDTH
#define FontSize36 36.f * AUTO_WIDTH
#define FontSize37 37.f * AUTO_WIDTH
#define FontSize42 42.f * AUTO_WIDTH


#endif /* URFontHeader_h */
