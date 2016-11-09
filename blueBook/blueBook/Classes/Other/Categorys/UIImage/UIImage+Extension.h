//
//  UIImage+Extension.h
//  Weibo
//
//  Created by Vincent_Guo on 15-3-16.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


+(instancetype)imageWithName:(NSString *)imgName;


/**
 *  自动从中间拉伸图片
 *
 *  @param imgName 图片名称
 */
+(instancetype)resizeImgWithName:(NSString *)imgName;
@end
