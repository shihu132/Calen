//
//  NSString+Extension.h
//  chebanlv-standard
//
//  Created by Rocky Ao on 15/3/8.
//  Copyright (c) 2015年 zcbl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (NSString*)videoNameWithCurrentDate;

+ (NSString *)dictionaryToJsonString:(NSDictionary *)dict;
+(BOOL)isValide:(NSString *)value;

//UTF-8转码
+ (NSString *)UTF8StringWithString:(NSString *)string;

+ (NSString *)imageWithBase64:(UIImage *)image;
//生成SN
+(NSString *)snWithString:(NSString *)userid;

//验证身份证
+ (BOOL)verifyIDCardNumber:(NSString *)value; //验证身份证

//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;

//用户名
+ (BOOL) validateUserName:(NSString *)name;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

+(NSString *)getCurrentDate;

//获取本机时间
+ (NSString *)stringWithCurrenDate;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//车牌号验证
+ (BOOL) validateEnginno:(NSString *)enginno;

/**
 *  验证中文汉字字母
 */
+(BOOL)validateString:(NSString *)regStr;
/**
 *  以当前时间为图片名称
 *
 *  @return 图片名称.jpeg
 */
+ (NSString *)imageNameWithCurrentDate;

/**
 *  验证手机号码是否符合规则
 *
 *  @param mobileNum 电话号码
 *
 *  @return YES符合、NO不符合
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/**
 *  检查密码是否是6-20位 允许特殊字符
 *
 *  @param _text 密码字符串
 *
 *  @return 是否符合符合YES、不符合NO
 */
+ (BOOL)CheckInput:(NSString*)_text;
/**
 *  获取本机唯一标识(deviceToken + bundleID MD5)
 *
 *  @return md5字符串
 */
+ (NSString *)getDeviceMd5ID;


+ (NSData *)decodeWithBase64String:(NSString *)str;

/**
 *  UTF-8  转 GB2132
 *
 *  @param utf8string 编码串
 *
 *  @return string
 */
+ (NSString*)UTF8_To_GB2312:(NSString*)utf8string;

/**
 *  判断字符串中是否只有中文、英文和数字
 */
+ (BOOL)judgeOnlyIncludeCEN:(NSString *)str;
/**
 *  判断是否只有英文字母和数字
 *
 *  @param str
 *
 *  @return yes or no
 */
+ (BOOL)isEnglishWordOrNumber:(NSString *)str;
/**
 *  只有数字
 *
 *  @param str
 *
 *  @return yes or no
 */
+ (BOOL)isOnlyNumber:(NSString *)str;

/**
 *  判断是否有emoj表情
 *
 *  @param string 字符串
 *
 *  @return yes/no
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  data转base64
 *
 *  @param data 原始数据
 *
 *  @return base64串
 */
+ (NSString *)base64WithData:(NSData *)data;
/**
 *  验证是否符合时间格式
 *
 *  @param string 原始串
 *
 *  @return 是否
 */
+ (BOOL)stringisDate:(NSString *)string;
/**
 *  获取到当前年月日
 *
 *  @return N年N月N日
 */
+ (NSString *)stringWithCurrenday;


@end
