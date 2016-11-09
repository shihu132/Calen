//
//  NSString+File.h
//  MaiQuan
//
//  Created by 王圆的Mac on 14-1-23.
//  Copyright (c) 2014年 王圆的Mac. All rights reserved.
//字符串拼接一个字符串方法

#import <Foundation/Foundation.h>

@interface NSString (File)

//拼接方法
- (NSString *)filenameAppend:(NSString *)append;
+ (int)lengthToHanZi:(NSString *)strtemp;
-(id)JSONValue;
@end
