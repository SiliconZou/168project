//
//  URInputControl.m
//  URInputControl
//
//  Created by qc on 2018/4/9.
//  Copyright © 2018年 qc. All rights reserved.
//

#import "URInputControl.h"
#import <objc/runtime.h>

static  const void * profileKey = &profileKey ;
static  const void * tempDelegateKey = &tempDelegateKey ;

static BOOL judgeRegular(NSString *contentStr , NSString * regularStr){
    
    NSError * error ;
    NSRegularExpression * expression = [[NSRegularExpression  alloc] initWithPattern:regularStr options:0 error:&error];
    if (error) {
        return YES ;
    }
    
    NSArray * resultArray =[expression   matchesInString:contentStr options:0 range:NSMakeRange(0, contentStr.length)] ;
    
    return resultArray.count>0 ;
}

BOOL UR_shouldChangedCharactersIn(id target, NSRange range , NSString *  string){
    
    if (!target) {
        return YES ;
    }
    
    URInputControl * control=  objc_getAssociatedObject(target, profileKey);
    
    if (!control) {
        return YES ;
    }
    
    // 计算若输入成功的字符串
    NSString * nowStr =[target   valueForKey:@"text"] ;
    
    NSMutableString * resultStr =[NSMutableString  stringWithString:nowStr] ;
    
    if (string.length==0) {
        
        [resultStr  deleteCharactersInRange:range] ;
    }else{
        
        if (range.length==0) {
            
            [resultStr insertString:string atIndex:range.location] ;
        }else{
            
            [resultStr   replaceCharactersInRange:range withString:string] ;
            
        }
    }
    
    // 长度判断
    if (control.maxlength !=NSUIntegerMax) {
        
        if (control.cancelTextLengthControlBefore && resultStr.length > control.maxlength) {
            
            return NO ;
        }
    }
    
    // 正则表达式匹配
    if (resultStr.length>0) {
        
        if (!control.regularStr || control.regularStr.length<=0) {
            
            return YES ;
        }
        
        return judgeRegular(resultStr, control.regularStr) ;
    }
    
    return YES ;
}

void UR_textDidChanged(id _Nullable target){
    if (!target) {
        return ;
    }
    
    URInputControl * control = objc_getAssociatedObject(target, profileKey) ;
    if (!control) {
        return ;
    }
    
    // 内容适配
    if (control.maxlength !=NSUIntegerMax && [target   valueForKey:@"markedTextRange"] == nil) {
        
        NSString * resultText = [target  valueForKey:@"text"] ;
        // 先内容过滤
        if (control.inputControlType == URInputControlTypeExcludeInvisible) {
            
            resultText = [[target  valueForKey:@"text"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        
        // 再判断长度
        if (resultText.length > control.maxlength) {
            
            [target   setValue:[resultText  substringToIndex:control.maxlength] forKey:@"text"] ;
        }else {
            
            [target   setValue:resultText forKey:@"text"] ;
        }
    }
    
    // 回调
    if (control.textChangedInvocation) {
        
        [control.textChangedInvocation   setArgument:&target atIndex:2];
        
        [control.textChangedInvocation  invoke] ;
    }
    
    if (control.textChanged) {
        control.textChanged(target) ;
    }
}

@interface URInputControl ()

@property (nonatomic, assign) BOOL cancelTextLengthControlBefore;

@property (nonatomic, strong, nullable) NSInvocation *textChangedInvocation;

@end

@implementation URInputControl

-(instancetype)init{
    if (self=[super init]) {
        
        self.maxlength = NSUIntegerMax ;
    }
    return self ;
}

-(void)urAddTargetOfTextChanged:(id)target action:(SEL)action{
    
    NSInvocation * invocation = nil ;
    
    if (target && action) {
        
        invocation = [NSInvocation   invocationWithMethodSignature:[target  methodSignatureForSelector:action]] ;
        invocation.target = target ;
        invocation.selector = action ;
    }
    
    self.textChangedInvocation = invocation ;
}

-(void)setInputControlType:(URInputControlType)inputControlType{
    
    _inputControlType = inputControlType ;
    
    switch (inputControlType) {
        case URInputControlTypeNone:{
            self.regularStr = @"";
            self.keyBoardType = UIKeyboardTypeDefault;
            self.autocorrectionType = UITextAutocorrectionTypeDefault;
            self.cancelTextLengthControlBefore = YES;
        }
            break;
            
        case URInputControlTypeNumber:{
            self.regularStr = @"^[0-9]*$";
            self.keyBoardType = UIKeyboardTypeNumberPad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break ;
            
        case URInputControlTypeLetter:{
            self.regularStr = @"^[a-zA-Z]*$";
            self.keyBoardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break ;
            
        case URInputControlTypeSmallLetter:{
            self.regularStr = @"^[a-z]*$";
            self.keyBoardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break ;
            
        case URInputControlTypeBigLetter:{
            self.regularStr = @"^[A-Z]*$";
            self.keyBoardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break ;
            
        case URInputControlTypeNumberAndSmallLetter:{
            self.regularStr = @"^[0-9a-z]*$";
            self.keyBoardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break ;
            
        case URInputControlTypeNumberAndBigLetter:{
            self.regularStr = @"^[0-9A-Z]*$";
            self.keyBoardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break ;
            
        case URInputControlTypeNumberAndLetter:{
            self.regularStr = @"^[0-9a-zA-Z]*$";
            self.keyBoardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break ;
            
        case URInputControlTypeExcludeInvisible:{
            self.regularStr = @"";
            self.keyBoardType = UIKeyboardTypeDefault;
            self.autocorrectionType = UITextAutocorrectionTypeDefault;
            self.cancelTextLengthControlBefore = YES;
        }
            break ;
            
        case URInputControlTypeDecimal:{
            NSString *tempStr = self.maxlength == NSUIntegerMax?@"":[NSString stringWithFormat:@"%ld", (unsigned long)self.maxlength];
            self.regularStr = [NSString stringWithFormat:@"^(([1-9]\\d{0,%@})|0)(\\.\\d{0,2})?$", tempStr];
            self.keyBoardType = UIKeyboardTypeDecimalPad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break ;
            
        default:
            break;
    }
}

+(URInputControl *)creat{
    
    URInputControl * control = [URInputControl  new] ;
    
    return control ;
}

-(URInputControl * _Nonnull (^)(URInputControlType))setTextControlType{
    
    return ^URInputControl * (URInputControlType  controlType){
        
        self.inputControlType = controlType ;
        
        return self ;
    };
}

-(URInputControl * _Nonnull (^)(NSString * _Nonnull))setRegularStr{
    
    return ^URInputControl * (NSString * regularStr){
        
        self.regularStr = regularStr ;
        
        return self ;
        
    } ;
}

-(URInputControl * _Nonnull (^)(NSUInteger))setMaxlength{
    
    return ^URInputControl *(NSUInteger  maxlength){
        
        self.maxlength = maxlength ;
        
        return self ;
    };
}

-(URInputControl * _Nonnull (^)(void (^ _Nonnull)(id _Nonnull)))setTextChanged{
    
    return ^URInputControl * (void(^textChangedBlock)(id observe)){
        
        if (textChangedBlock) {
            
            self.textChanged = ^(id  _Nonnull observe) {
                
                textChangedBlock(observe);
            };
        }
        
        return self ;
    };
}

-(URInputControl *(^)(id target , SEL action))setTargetOfTextChanged {
    
    return ^URInputControl * (id target , SEL action){
        
        [self   urAddTargetOfTextChanged:target action:action] ;
        
        return self ;
    };
}

@end

@interface URInputControlTempDlegate :NSObject

@property (nonatomic, weak) id delegate_inside;

@property (nonatomic, weak) id delegate_outside;

@property (nonatomic, strong) Protocol *protocol;

@end

@implementation URInputControlTempDlegate

- (BOOL)respondsToSelector:(SEL)aSelector {
    struct objc_method_description des = protocol_getMethodDescription(self.protocol, aSelector, NO, YES);
    if (des.types == NULL) {
        return [super respondsToSelector:aSelector];
    }
    if ([self.delegate_inside respondsToSelector:aSelector] || [self.delegate_outside respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    BOOL isResponds = NO;
    if ([self.delegate_inside respondsToSelector:sel]) {
        isResponds = YES;
        [anInvocation invokeWithTarget:self.delegate_inside];
    }
    if ([self.delegate_outside respondsToSelector:sel]) {
        isResponds = YES;
        [anInvocation invokeWithTarget:self.delegate_outside];
    }
    if (!isResponds) {
        [self doesNotRecognizeSelector:sel];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig_inside = [self.delegate_inside methodSignatureForSelector:aSelector];
    NSMethodSignature *sig_outside = [self.delegate_outside methodSignatureForSelector:aSelector];
    NSMethodSignature *result_sig = sig_inside?:sig_outside?:nil;
    return result_sig;
}
- (Protocol *)protocol {
    if (!_protocol) {
        if ([self.delegate_inside isKindOfClass:UITextField.self]) {
            _protocol = objc_getProtocol("UITextFieldDelegate");
        }
    }
    return _protocol;
}

@end

@implementation UITextField (URInputContol)

+ (void)load {
    if ([NSStringFromClass(self) isEqualToString:@"UITextField"]) {
        Method m1 = class_getInstanceMethod(self, @selector(setDelegate:));
        Method m2 = class_getInstanceMethod(self, @selector(customSetDelegate:));
        if (m1 && m2) {
            method_exchangeImplementations(m1, m2);
        }
    }
}

- (void)customSetDelegate:(id)delegate {
    @synchronized(self) {
        if (objc_getAssociatedObject(self, profileKey)) {
            URInputControlTempDlegate *tempDelegate = [URInputControlTempDlegate new];
            tempDelegate.delegate_inside = self;
            if (delegate != self) {
                tempDelegate.delegate_outside = delegate;
            }
            [self customSetDelegate:tempDelegate];
            objc_setAssociatedObject(self, tempDelegateKey, tempDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        } else {
            [self customSetDelegate:delegate];
        }
    }
}

-(void)setIntPutCP:(URInputControl *)intPutCP{
    
    @synchronized(self) {
        if (intPutCP && [intPutCP  isKindOfClass:URInputControl.self]) {
            
            objc_setAssociatedObject(self, profileKey, intPutCP, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            self.delegate = self;
            self.keyboardType = intPutCP.keyBoardType;
            self.autocorrectionType = intPutCP.autocorrectionType;
            if (intPutCP.textChangedInvocation || intPutCP.textChanged) {
                
                [self  addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged] ;
            }
        }else{
            objc_setAssociatedObject(self, profileKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

-(URInputControl *)intPutCP{
    return objc_getAssociatedObject(self, profileKey) ;
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return UR_shouldChangedCharactersIn(textField, range, string);
}
- (void)textFieldDidChange:(UITextField *)textField {
    UR_textDidChanged(textField);
}

@end


@implementation UITextView (URInputContol)

-(void)setIntPutCP:(URInputControl *)intPutCP{
    
    @synchronized(self) {
        if (intPutCP && [intPutCP  isKindOfClass:URInputControl.self]) {
            
            objc_setAssociatedObject(self, profileKey, intPutCP, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            self.delegate = self;
            self.keyboardType = intPutCP.keyBoardType;
            self.autocorrectionType = intPutCP.autocorrectionType;
        }else{
            objc_setAssociatedObject(self, profileKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

-(URInputControl *)intPutCP{
    return objc_getAssociatedObject(self, profileKey) ;
}

#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return UR_shouldChangedCharactersIn(textView, range, text);
}
- (void)textViewDidChange:(UITextView *)textView {
    UR_textDidChanged(textView);
}

@end

