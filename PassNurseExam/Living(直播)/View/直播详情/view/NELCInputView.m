//
//  NELCInputView.m
//  PassTheNurseExam
//
//  Created by ZFBest on 2019/2/17.
//  Copyright © 2019 LeFu. All rights reserved.
//

#import "NELCInputView.h"

@interface NELCInputView () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *bannedingL;

///0用户个人未禁言 1用户个人被禁言
@property (nonatomic, assign) BOOL perBanned;
///0未全体禁言 1全体用户禁言
@property (nonatomic, assign) BOOL allBanned;

@end

@implementation NELCInputView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.delegate = self;
    
    [self.textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    if (@available(iOS 11.0, *)) {
        self.textView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }  
}

- (IBAction)shareBtnClick:(id)sender {
    if (_shareBlock) {
        _shareBlock();
    }
}

- (IBAction)sendBtnClick:(id)sender {
    if (_sendBlock) {
        _sendBlock(self.textView.text);
    }
}

-(void)handlePerBanned:(BOOL)perBanned allBanned:(BOOL)allBanned {
	self.perBanned = perBanned;
	self.allBanned = allBanned;

	[self bannedWithAll:NO banneding:NO];

	if (self.allBanned) {
		[self bannedWithAll:YES banneding:self.allBanned];
	}

	if (self.perBanned) {
		///个人禁言不能解除
		[self bannedWithAll:NO banneding:self.perBanned];
	}
}

///禁言
- (void)bannedWithAll:(BOOL)all banneding:(BOOL)banneding {
	self.bannedingL.hidden = !banneding;
	self.bannedingL.text = all ? @"全体禁言中" : @"禁言中";

	self.textView.text = @"";
	self.textView.userInteractionEnabled = !banneding;
}

///清空输入框
- (void)clearText {
	self.textView.text = @"";
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView {
    [self changeText:textView.text];

}

#pragma mark - addObserver
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        NSString *nValue = [change safeObjectForKey:NSKeyValueChangeNewKey];
        [self changeText:nValue];
    }
}

- (void)changeText:(NSString *)text {
    self.sendBtn.enabled = ![NSString  isBlank:text];
    UIColor *bgColor = self.sendBtn.enabled ? RGB(242,113,79) : RGB(191,191,191);
    [self.sendBtn setBackgroundColor:bgColor];
}

-(void)dealloc {
}

@end
