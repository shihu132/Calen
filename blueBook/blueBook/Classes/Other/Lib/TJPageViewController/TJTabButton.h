//
//  TJTabButton.h
//  demo
//
//  Created by lulul on 16/6/10.
//  Copyright © 2016年 TJPageController. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TJPageViewControllerButtonType) {
    TJPageViewControllerButtonTypeNormal = 0,
    TJPageViewControllerButtonTypeSelected = 1
};

@interface TJTabButton : UIView

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic, readonly) UIButton* button;

- (instancetype)initWithFrame:(CGRect)frame type:(TJPageViewControllerButtonType)type;
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)setTitle:(NSString *)title;
- (void)setTitleColor:(UIColor *)color;
- (void)setTitleFont:(UIFont *)font;
- (void)setUnderlineColor:(UIColor*)color;
- (void)setSelectedLineColor:(UIColor*)color;

@end
