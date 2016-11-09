//
//  SHCommonMethod.h

//
//  Created by 石虎 on 16/6/30.
//  Copyright © 2016年 shih. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHCommonMethod : NSObject
/**
 * 公用方法
 */
+ (SHCommonMethod *)sharedManager;
/**
 *  年份的天数
 */
@property(nonatomic,strong)NSString * startDate;
/**
 *  (过去)的天数
 */
@property(nonatomic,strong)NSString *secStr;


/** 文本缩进--方法 */
- (void)setTextAlignment:(NSTextAlignment)textAlignment headIndent:(CGFloat)headIndent firstLineHeadIndent:(CGFloat)firstLineHeadIndent tailIndent:(CGFloat)tailIndent textStr:(NSString *)textStr attributedText:(UILabel *)attributedText;

/** 富文本--方法 */
- (void)setVC:(UILabel *)lable richTextSting:(NSString *)strng colorR:(int)colorR colorG:(int)colorG colorB:(int)colorB singleNoRangeLoc:(int)loc singleNoRangeLen:(int)len fontB:(int)fontB fontBold:(int)fontBold;

/**  获取某个日期所在年份的天数*/
- (void)getNumberOfDaysOneYear;

/**  获取当时时间距离未来(过去)的天数*/
- (void)getTimeFromTheFutureDayNum;
@end
