//
//  URColorHeader.h
//  PassNurseExam
//
//  Created by qc on 2018/8/16.
//  Copyright © 2018年 ucmed. All rights reserved.
//

#ifndef URColorHeader_h
#define URColorHeader_h

//获取 RGB 对应的颜色（UIColor）
#define UR_ColorFromRGBA(r,g,b,a)        [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define UR_ColorFromRGB(r,g,b)           UR_ColorFromRGBA(r,g,b,1.0f)
#define UR_ColorFromValueA(rgbValue,a)   UR_ColorFromRGBA((rgbValue & 0xff0000) >> 16,(rgbValue & 0xff00) >> 8,rgbValue & 0xff,a)
#define UR_ColorFromValue(rgbValue)      UR_ColorFromValueA(rgbValue,1.0f)

#define RGB(R,G,B) [UIColor colorWithRed: R/ 255.0 green: G / 255.0 blue: B /255.0 alpha:1.0]

#define RGBA(R,G,B,A) [UIColor colorWithRed: R/ 255.0 green: G / 255.0 blue: B /255.0 alpha:A]

#define NORMAL_COLOR                  UR_ColorFromValue(0xFF754C)
//主题色
#define START_COLOR                   UR_ColorFromValue(0xA9A6FF)
#define END_COLOR                     UR_ColorFromValue(0x57A2FF)

//软件大背景色、页面背景色
#define UR_COLOR_BACKGROUND_ALL        UR_ColorFromValue(0xEEEEEE)

//线的颜色
#define UR_COLOR_LINE                 UR_ColorFromValue(0xDDDDDD)

//默认字颜色
#define UR_COLOR_DEFAULT          UR_ColorFromValue(0x005198)

// 按钮不可点击颜色
#define UR_COLOR_DISABLE_CLICK         UR_ColorFromValue(0xf0f3f5)

// 按钮可点击颜色
#define UR_COLOR_CLICK                 UR_ColorFromValue(0xf0f3f5)

// UITableView的颜色
#define UR_COLOR_TABLEVIEW             UR_ColorFromValue(0xf0f3f5)

// 弹窗提示语字体颜色
#define UR_ALERT_TITLE_COLOR           UR_ColorFromValue(0x333333)

#define UR_ALERT_CONTENT_COLOR         UR_ColorFromValue(0x333333)

#define UR_ALERT_SURE_COLOR            UR_ColorFromValue(0x2FB727)

#define UR_ALERT_CANCLE_COLOR          UR_ColorFromValue(0x666666)

#define UR_ContDownTime_Color          UR_ColorFromValue(0x999999)


#endif /* URColorHeader_h */
