//
//  SHTabBar.m
//
//  Created by 石虎 on 16/5/4.
//  Copyright © 2016年 shih. All rights reserved.
//

#import "SHTabBar.h"
#import "SHTabBarButton.h"

@interface SHTabBar ()


@end

@implementation SHTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 当前索引
    NSUInteger buttonIndex = 0;
    // 1.遍历所有子控件
    for (UIView *child in self.subviews) {
        // 判断是否继承UIControl, 并且不是UIButton
        // 因为加号按钮是UIButton, 但是加号按钮并不需要在这里面设置frame
        if ([child isKindOfClass:[UIControl class]] &&
            ![child isKindOfClass:[UIButton class]]) {
            // 计算按钮的frame
            CGFloat width = self.width / 3;
            CGFloat height = self.height;
            CGFloat y = 0;
            CGFloat x = buttonIndex * width;
            buttonIndex++;
            
            child.frame = CGRectMake(x, y, width, height);
        }
    }
    
 }



@end
