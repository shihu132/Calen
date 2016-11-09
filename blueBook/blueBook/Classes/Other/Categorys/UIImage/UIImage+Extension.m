//
//  UIImage+Extension.m
//  Weibo
//
//  Created by Vincent_Guo on 15-3-16.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+(instancetype)imageWithName:(NSString *)imgName{
    // 如果系统大于ios7,使用带有ios7的图片
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0){
        NSString *ios7ImgName = [imgName stringByAppendingString:@"_os7"];
        return [UIImage imageNamed:ios7ImgName];
    }
    
    return [UIImage imageNamed:imgName];
}

+(instancetype)resizeImgWithName:(NSString *)imgName{
    UIImage *img = [UIImage imageNamed:imgName];
    return [img stretchableImageWithLeftCapWidth:img.size.width * 0.5 topCapHeight:img.size.height * 0.5];
}
@end
