//
//  UIButton+Extension.h
//  chebanlv-standard
//
//  Created by Rocky Ao on 15/3/3.
//  Copyright (c) 2015年 zcbl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
/**
 *  创建带文字图片按钮
 *
 *  @param name         按钮文字
 *  @param image        普通状态的背景图片
 *  @param hilightImage 高亮状态的背景图片
 *
 *  @return 按钮
 */
+ (UIButton *)buttonWithName:(NSString *)name normalBackImage:(NSString *)image andHilightBackImage:(NSString *)hilightImage;

/**
 *  创建只有图片的按钮
 *
 *  @param image        普通状态图片
 *  @param hilightImage 高亮状态图片
 *
 *  @return 按钮
 */
+ (UIButton *)buttonWithNormalImage:(NSString *)image andHilightImage:(NSString *)hilightImage;

/**
 *  创建选择按钮
 *
 *  @param image         普通状态图片
 *  @param SelectedImage 选择状态图片
 *
 *  @return 按钮
 */
+ (UIButton *)buttonWithNormalImage:(NSString *)image andSelectedImage:(NSString *)selectedImage;

/**
 *  创建文字按钮
 *
 *  @param name 按钮名字
 *
 *  @return 按钮
 */
+ (UIButton *)buttonWithName:(NSString *)name;

+ (UIButton *)buttonWithName:(NSString *)name normalImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName;
@end
