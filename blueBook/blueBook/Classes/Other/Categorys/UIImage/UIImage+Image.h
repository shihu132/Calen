//
//  UIImage+Image.h
//  MaiQuan
//
//  Created by 王圆的Mac on 14-1-23.
//  Copyright (c) 2014年 王圆的Mac. All rights reserved.
//拉伸图片用

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)resizedImage:(NSString *)name;
+ (UIImage *)resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
+ (UIImage *)stretchImageWithName:(NSString *)name;
+ (UIImage *)stretchImageWithNames:(NSString *)name;
+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (UIImage *)imageWithOriginalMode:(NSString *)imageName;
@end
