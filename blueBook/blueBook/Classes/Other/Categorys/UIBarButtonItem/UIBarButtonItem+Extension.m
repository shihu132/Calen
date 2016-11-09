//
//  UIBarButtonItem+Extension.m
//
//
//  Created by apple on
//  Copyright (c) 2015年 ix. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Frame.h"
@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action
{
    // 创建右边按钮
    UIButton *btn = [[UIButton alloc] init];
    // 设置当前按钮默认状态和高亮状态的图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    // 设置按钮的size
    btn.size =btn.currentBackgroundImage.size;
    // 监听按钮的点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 2.将按钮包装为UIBarButtonItem
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

/**
 *  创建item
 *
 *  @param norimage 默认状态的图片
 *  @param higImage 高亮状态的图片
 *  @param title    标题
 *
 *  @return item
 */
- (UIBarButtonItem *)initWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title target:(id)target action:(SEL)action
{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // 2.设置按钮的默认图片和高亮图片
    if (norimage != nil &&
        ![norimage isEqualToString:@""]) {
        
        [btn setImage:[UIImage imageNamed:norimage] forState:UIControlStateNormal];
    }
    if (higImage != nil &&
        ![higImage isEqualToString:@""]) {
        
        [btn setImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
    }
    // 设置标题
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    // 3.监听按钮的点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 4.设置按钮的frame
    // 可以调用控件的sizeToFit方法来自动调整控件的大小
    [btn sizeToFit];
//    if ([btn.currentTitle isEqualToString:@""]) {
//        btn.frame = CGRectMake(0, 0, 30, 30);
//    }
    
    // 5.根据按钮创建BarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)itemWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title target:(id)target action:(SEL)action
{
    return [[self alloc] initWithNorImage:norimage higImage:higImage title:title target:target action:action];
}

@end
