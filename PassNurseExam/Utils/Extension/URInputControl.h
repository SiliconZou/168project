//
//  URInputControl.h
//  URInputControl
//
//  Created by qc on 2018/4/9.
//  Copyright © 2018年 qc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

BOOL UR_shouldChangedCharactersIn(id _Nullable target, NSRange range , NSString * _Nullable string) ;

void UR_textDidChanged(id _Nullable target);

/**
 输入限制的类型
 */
typedef NS_ENUM(NSInteger ,URInputControlType) {
    URInputControlTypeNone=0 , // 无限制
    URInputControlTypeNumber , // 数字
    URInputControlTypeLetter , // 字母（包含大小写）
    URInputControlTypeSmallLetter , // 小写字母
    URInputControlTypeBigLetter , // 大写字母
    URInputControlTypeNumberAndSmallLetter , // 数字+小写字母
    URInputControlTypeNumberAndBigLetter , // 数字+大写字母
    URInputControlTypeNumberAndLetter , // 数字+字母
    URInputControlTypeExcludeInvisible , // 去除不可见字符（包括空格、制表符、换页符等）
    URInputControlTypeDecimal , // 小数
    
};

@interface URInputControl : NSObject

/**
 限制输入长度，NSUIntegerMax表示不限制（默认不限制）
 */
@property (nonatomic,assign) NSInteger maxlength;

/**
 限制输入的文本类型（单选，在内部其实是配置了regularStr属性）
 */
@property (nonatomic,assign) URInputControlType inputControlType;

/**
 限制输入的正则表达式字符串
 */
@property (nonatomic,copy,nullable) NSString * regularStr;

/**
 文本变化回调（observer为UITextFiled或UITextView）
 */
@property (nonatomic,copy,nullable) void(^textChanged)(id observe);

/**
 键盘索引和键盘类型，当设置了 textControlType 内部会自动配置，当然你也可以自己配置
 */
@property (nonatomic)UITextAutocorrectionType  autocorrectionType ;

/**
 设置键盘样式
 */
@property (nonatomic)UIKeyboardType keyBoardType ;

/**
 取消输入前回调的长度判断
 */
@property (nonatomic,assign,readonly) BOOL cancelTextLengthControlBefore;

/**
 文本变化方法体
 */
@property (nonatomic,strong,readonly,nullable) NSInvocation * textChangedInvocation;

/**
 添加文本变化监听
 
 @param target 方法接收者
 @param action 方法（方法参数为UITextFiled或UITextView）
 */
-(void)urAddTargetOfTextChanged:(id)target action:(SEL)action ;

/**
 链式配置方法(对应属性设置)
 */
+(URInputControl *)creat ;

-(URInputControl *(^)(URInputControlType  controlType))setTextControlType ;

-(URInputControl *(^)(NSString * regularStr))setRegularStr ;

-(URInputControl * (^)(NSUInteger  maxlength))setMaxlength ;

-(URInputControl *(^)(void(^textChanged)(id observe)))setTextChanged ;

-(URInputControl *(^)(id target , SEL action))setTargetOfTextChanged ;

@end

@interface UITextField (URInputContol)<UITextFieldDelegate>

@property (nonatomic,strong,nullable) URInputControl * intPutCP;

@end

@interface UITextView (URInputContol)<UITextViewDelegate>

@property (nonatomic,strong,nullable) URInputControl * intPutCP;

@end

NS_ASSUME_NONNULL_END

