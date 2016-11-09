//
//  UITextField+LimitLength.h
//  HouseBaby
//
//  Created by shijinxing on 15/3/1.
//  Copyright (c) 2015年 xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LimitLength)

/**
 *  使用时只要调用此方法，加上一个长度(int)，就可以实现了字数限制,汉字不可以
 *
 *  @param length
 */
- (void)limitTextLength:(int)length;
@end
