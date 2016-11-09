//
//  TJTabButton.m
//  demo
//
//  Created by lulul on 16/6/10.
//  Copyright © 2016年 TJPageController. All rights reserved.
//

#import "TJTabButton.h"

@interface TJTabButton()

@property (strong, nonatomic) UIButton* button;
@property (strong, nonatomic) UIView* underline;
@property (strong, nonatomic) UIView* selectedLine;
@property (assign, nonatomic) TJPageViewControllerButtonType type;

@end

const CGFloat kTJPageViewControllerButtonUnderLineHeight = 1.0;

@implementation TJTabButton

- (instancetype)initWithFrame:(CGRect)frame type:(TJPageViewControllerButtonType)type {
    if (self = [super initWithFrame:frame]) {
        _type = type;
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 2 * kTJPageViewControllerButtonUnderLineHeight)];
        _button.contentEdgeInsets = UIEdgeInsetsMake(12, 0, 3, 0);
        [self addSubview:_button];
        
        _underline = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - kTJPageViewControllerButtonUnderLineHeight, frame.size.width, kTJPageViewControllerButtonUnderLineHeight)];
        if (type == TJPageViewControllerButtonTypeSelected) {
            _selectedLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 2 * kTJPageViewControllerButtonUnderLineHeight, frame.size.width, kTJPageViewControllerButtonUnderLineHeight)];
            [self addSubview:_selectedLine];
        }
        [self addSubview:_underline];
    }
    return self;
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - 2 * kTJPageViewControllerButtonUnderLineHeight);
    self.underline.frame = CGRectMake(0, frame.size.height - kTJPageViewControllerButtonUnderLineHeight, frame.size.width, kTJPageViewControllerButtonUnderLineHeight);
    self.selectedLine.frame = CGRectMake(0, frame.size.height - 2 * kTJPageViewControllerButtonUnderLineHeight, frame.size.width, kTJPageViewControllerButtonUnderLineHeight);
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [self.button addTarget:target action:action forControlEvents:controlEvents];
}

- (void)setTitle:(NSString *)title {
    [self.button setTitle:title forState:UIControlStateNormal];
}


- (void)setTitleColor:(UIColor *)color {
    [self.button setTitleColor:color forState:UIControlStateNormal];
}


- (void)setTitleFont:(UIFont*)font {
    self.button.titleLabel.font = font;
}


-(void)setUnderlineColor:(UIColor*)color {
    self.underline.backgroundColor = color;
}

- (void)setSelectedLineColor:(UIColor*)color {
    self.selectedLine.backgroundColor = color;
}

@end
