//
//  SHCommonMethod.m
//
//  Created by 石虎 on 16/6/30.
//  Copyright © 2016年 shih. All rights reserved.
//

#import "SHCommonMethod.h"

@implementation SHCommonMethod
/**
 *  1. 线程安全
 *  2. 满足静态分析器的要求。
 * 3. 兼容了ARC
 */
+ (SHCommonMethod *)sharedManager
{
    static SHCommonMethod *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

//文本缩进--方法
- (void)setTextAlignment:(NSTextAlignment)textAlignment headIndent:(CGFloat)headIndent firstLineHeadIndent:(CGFloat)firstLineHeadIndent tailIndent:(CGFloat)tailIndent textStr:(NSString *)textStr attributedText:(UILabel *)attributedText
{
    NSMutableParagraphStyle *styleWorks =  [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] autorelease];
    styleWorks.alignment = textAlignment;            //对齐
    styleWorks.headIndent = headIndent;                 //行首缩进
    styleWorks.firstLineHeadIndent = firstLineHeadIndent;     //首行缩进
    styleWorks.tailIndent = tailIndent;            //行尾缩进
    //把请求的数据添加到数组中
    NSAttributedString *attrTextWorks = [[NSAttributedString alloc] initWithString:textStr attributes:@{ NSParagraphStyleAttributeName : styleWorks}];
    
    //赋值显示数据
    attributedText.attributedText = attrTextWorks;
    
    
}
/**
 *  富文本封装---
 *  @param   vc        控件
 *  @param strng    初始化字符串
 *  @param colorR   colorR
 *  @param colorG   colorG
 *  @param colorB   colorB
 *  @param loc      指定从第几个数值开始
 *  @param len      几个数值是要改变的颜色
 *  @param fontB    字体大小
 *  @param fontBold 字体加粗
 */
- (void)setVC:(UILabel *)lable richTextSting:(NSString *)strng colorR:(int)colorR colorG:(int)colorG colorB:(int)colorB singleNoRangeLoc:(int)loc singleNoRangeLen:(int)len fontB:(int)fontB fontBold:(int)fontBold
{
    if (lable == nil) {
        lable = [[UILabel alloc]init];
    }
    UIColor *color = [UIColor colorWithRed:(colorR)/255.0 green:(colorG)/255.0 blue:(colorB)/255.0 alpha:1.0];
    NSRange singleNoRange = NSMakeRange(loc,len);//指定字的长度
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:strng];//初始化富文本
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:singleNoRange];//颜色
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontB]range:singleNoRange];//字体大小
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:fontBold]range:singleNoRange];//加粗字体
    lable.attributedText = attributedString;
}
#pragma mark - 获取某个日期所在年份的天数
- (void)getNumberOfDaysOneYear
{
    //得到当前的时间
    NSDate * date = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [dateFormatter setDateFormat:@"yyyy"];
    
    //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
    NSTimeInterval time = 365 * 24 * 60 * 60;//一年的秒数
    //得到一年之前的当前时间（-：表示向前的时间间隔（即去年），如果没有，则表示向后的时间间隔（即明年））
    
    NSDate * lastYear = [date dateByAddingTimeInterval:+time];
    
    //转化为字符串
    NSString * startDate = [dateFormatter stringFromDate:lastYear];
    
    _startDate = startDate;
    
}
#pragma mark - 获取当时时间距离未来(过去)的天数
- (void)getTimeFromTheFutureDayNum
{
    //当时时间距离未来(过去)的天数
    NSString * time = @"2017-06-07";
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * date = [dateFormatter dateFromString:time];
    NSDate * currentDate = [NSDate date];
    
    NSUInteger sec = [date timeIntervalSinceDate:currentDate];
    NSLog(@"sec%zd",sec/(3600*24));
    
    NSString *secStr = [NSString stringWithFormat:@"%ld",sec/(3600*24)];
    
    _secStr = secStr;

}

@end
