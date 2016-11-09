//
//  UIView+Extension.h
//
//
//  Created by apple on 15/4/26.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

// 在分类中添加了一个属性
// 如果通过@property给分类新增属性, 那么@property只会生成该属性的getter/setter方法, 而不会生成属性
@property(nonatomic, assign)CGFloat x;
/*
- (void)setX:(CGFloat)x;
- (CGFloat)x;
 */

@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@end
