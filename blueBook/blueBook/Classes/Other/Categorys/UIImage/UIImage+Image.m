//
//  UIImage+Image.m
//  MaiQuan
//
//  Created by 王圆的Mac on 14-1-23.
//  Copyright (c) 2014年 王圆的Mac. All rights reserved.
//

#import "UIImage+Image.h"
#import "NSString+File.h"

@implementation UIImage (Image)

+ (UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {
        NSString *newName = [name filenameAppend:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        
        if (!image) {
            image = [UIImage imageNamed:name];
        }
        
        return image;
    } else {
    
        return [self imageNamed:name];
    
    }

}

+ (UIImage *)resizedImage:(NSString *)name
{
    return [self resizedImage:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];

    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
    
}

+ (UIImage *)stretchImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

//底层拉伸
+ (UIImage *)stretchImageWithNames:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.8];
}


//根据色值返回图片
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
+ (UIImage *)imageWithOriginalMode:(NSString *)imageName
{
    
    UIImage *image = [UIImage imageNamed:imageName];
    // 告诉这张图片保持原有的图片样式
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

@end
