//
//  UITextField+LimitLength.m
//  HouseBaby
//
//  Created by shijinxing on 15/3/1.
//  Copyright (c) 2015年 xiao. All rights reserved.
//

#import "UITextField+LimitLength.h"

@implementation UITextField (LimitLength)

static NSString *kLimitTextLengthKey = @"kLimitTextLengthKey";
- (void)limitTextLength:(int)length
{
    objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey), [NSNumber numberWithInt:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldDidChange:(UITextField *)textField
{
    NSNumber *lengthNumber = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey));
    int length = [lengthNumber intValue];
    NSString *text = textField.text;
    //    NSString *lang = [[UITextInputMode activeInputModes] firstObject];// 键盘输入模式
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (text.length > length) {
                textField.text = [text substringToIndex:length];
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }else{
            
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    }else{
        if (text.length > length) {
            textField.text = [text substringToIndex:length];
        }
    }
}
@end
