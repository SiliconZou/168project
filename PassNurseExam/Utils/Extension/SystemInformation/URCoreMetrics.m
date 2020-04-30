//
//  URCoreMetrics.m
//  MSSpeed
//
//  Created by qc on 2017/11/28.
//  Copyright © 2017年 qc. All rights reserved.
//

#import "URCoreMetrics.h"

CGRect URScreenBounds(void){
    
    return [UIScreen   mainScreen].bounds ;
}

CGFloat URScreenHeight(void){
    
    return [UIScreen   mainScreen].bounds.size.height ;
}

CGFloat  URScreenWidth(void){
    
    return [UIScreen  mainScreen].bounds.size.width ;
}


CGRect  URContentFrame(void){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [UIScreen  mainScreen].applicationFrame ;
#pragma clang diagnostic pop

}

CGFloat  URContentHeight(void){
    return [UIScreen   mainScreen].bounds.size.height ;
}
CGFloat  URContentWidth (void){
    return [UIScreen   mainScreen].bounds.size.width ;
}

CGFloat  URNavigationBarHeight(void){
    
    return  44.0f ;
}

CGFloat  URTabBarHeight (void){
    
    return 49.0f ;
}

CGFloat  URStatusBarHeight (void){
    
    return [UIApplication  sharedApplication].statusBarFrame.size.height ;
}

CGFloat URScreenScale (void){
    return [UIScreen   mainScreen].scale ;
}

CGFloat URAdaptiveCofficient (){
    
    static  CGFloat coffient = 0 ;
    if (coffient ==0) {
        coffient = URScreenWidth() / 320.0 ;
        coffient = [[NSString   stringWithFormat:@"%.2f",coffient] floatValue];
    }
    return coffient ;
}

CGFloat URAdJustedWidthHeight(CGFloat wh){
    return wh * URAdaptiveCofficient() ;
}

CGFloat URDefaultValueWidth (UIFont * font){
    NSString * string = @"-10.00%" ;
    NSDictionary * attributes = @{
                                  NSFontAttributeName : font
                                  } ;
    return [string   sizeWithAttributes:attributes].width ;
}

CGFloat URSafeAreaNavHeight (void) {
   return  URScreenHeight()>=812.0f ? 88 : 64 ;
}

CGFloat URSafeAreaStateHeight (void) {
    
    return URScreenHeight()>=812.0f ? 44 :20 ;
}

CGFloat URSafeAreaTabBarHeight (void) {
    
    return URScreenHeight()>=812.0f?83:49 ;
}

CGFloat URSafeAreaTabBarIncreaseHeight (void) {
    
    return URScreenHeight()>=812.0f?34:0 ;
}


