// 
//  UIButton+Extension.m
//  chebanlv-standard
//
//  Created by Rocky Ao on 15/3/3.
//  Copyright (c) 2015年 zcbl. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
#pragma mark 创建按钮
+ (UIButton*)buttonWithName:(NSString*)name normalBackImage:(NSString*)image andHilightBackImage:(NSString*)hilightImage
{
    
    
    UIImage *normalImage = [UIImage imageNamed:image];
    UIImage *hightlightImage = [UIImage imageNamed:hilightImage];
    normalImage = [normalImage stretchableImageWithLeftCapWidth:55 topCapHeight:17];
    hightlightImage = [hightlightImage stretchableImageWithLeftCapWidth:55 topCapHeight:17];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitle:name forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont fontWithName:@"STHeiti" size:15.0f];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:hightlightImage forState:UIControlStateHighlighted];
    return btn;
}

+ (UIButton*)buttonWithNormalImage:(NSString*)image andHilightImage:(NSString*)hilightImage
{
    
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hilightImage] forState:UIControlStateHighlighted];
    return btn;
}
+ (UIButton*)buttonWithNormalImage:(NSString*)image andSelectedImage:(NSString*)selectedImage
{

    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    return btn;
}
+ (UIButton *)buttonWithName:(NSString *)name{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitle:name forState:UIControlStateHighlighted];
    return btn;
}

+ (UIButton *)buttonWithName:(NSString *)name normalImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitle:name forState:UIControlStateSelected];
    [btn setTitleColor:RGB(73, 73, 73) forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    return btn;

}
@end
