//
//  UIImage+MJ.h
//  04-图片裁剪
//
//  Created by apple on 14-4-14.
//  Copyright (c). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NJ)
/**
 *  生成一张圆形图片
 *
 *  @param name        需要生成的图片名称
 *  @param borderWidth 生成的圆形图片的边框
 *  @param borderColor 边框的颜色
 *
 *  @return 圆形图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  将当前图片变成圆形图片
 *
 *  @param borderWidth 生成的圆形图片的边框
 *  @param borderColor 边框的颜色
 *
 *  @return 圆形图片
 */
- (instancetype)circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
