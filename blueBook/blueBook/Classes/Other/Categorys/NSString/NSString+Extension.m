//
//  NSString+Extension.m
//  chebanlv-standard
//
//  Created by Rocky Ao on 15/3/8.
//  Copyright (c) 2015年 zcbl. All rights reserved.
//

#import "NSString+Extension.h"
#import "GTMBase64.h"

@implementation NSString (Extension)
+ (NSString*)dictionaryToJsonString:(NSDictionary*)dict
{

    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //    str = [[str stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    str = (__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
    //                                                                      (CFStringRef)str,
    //                                                                      (CFStringRef) @"!$&'()*+,-./:;=?@_~%#[]",
    //                                                                      NULL,
    //                                                                      kCFStringEncodingUTF8);
    return str;
}

+ (BOOL)isValide:(NSString*)value
{
    if (value == nil || [value isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

//+ (NSString*)snWithString:(NSString*)userid
//{
//    NSString* sign = [NSString stringWithFormat:@"%@%@%@", kAppKey, kToken, userid];
//    return [sign md5String];
//}

//验证身份证
//必须满足以下规则
//1. 长度必须是18位，前17位必须是数字，第十八位可以是数字或X
//2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
//3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
//4. 第17位表示性别，双数表示女，单数表示男
//5. 第18位为前17位的校验位
//算法如下：
//（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
//（2）余数 ＝ 校验和 % 11
//（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
//6. 出生年份的前两位必须是19或20
+ (BOOL)verifyIDCardNumber:(NSString*)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString* mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString* leapMmdd = @"0229";
    NSString* year = @"(19|20)[0-9]{2}";
    NSString* leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString* yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString* leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString* yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString* area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString* regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd, @"[0-9]{3}[0-9Xx]"];

    NSPredicate* regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0, 1)].intValue + [value substringWithRange:NSMakeRange(10, 1)].intValue) * 7
        + ([value substringWithRange:NSMakeRange(1, 1)].intValue + [value substringWithRange:NSMakeRange(11, 1)].intValue) * 9
        + ([value substringWithRange:NSMakeRange(2, 1)].intValue + [value substringWithRange:NSMakeRange(12, 1)].intValue) * 10
        + ([value substringWithRange:NSMakeRange(3, 1)].intValue + [value substringWithRange:NSMakeRange(13, 1)].intValue) * 5
        + ([value substringWithRange:NSMakeRange(4, 1)].intValue + [value substringWithRange:NSMakeRange(14, 1)].intValue) * 8
        + ([value substringWithRange:NSMakeRange(5, 1)].intValue + [value substringWithRange:NSMakeRange(15, 1)].intValue) * 4
        + ([value substringWithRange:NSMakeRange(6, 1)].intValue + [value substringWithRange:NSMakeRange(16, 1)].intValue) * 2
        + [value substringWithRange:NSMakeRange(7, 1)].intValue * 1 + [value substringWithRange:NSMakeRange(8, 1)].intValue * 6
        + [value substringWithRange:NSMakeRange(9, 1)].intValue * 3;
    NSInteger remainder = summary % 11;
    NSString* checkBit = @"";
    NSString* checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder, 1)]; // 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17, 1)] uppercaseString]];
}

//银行卡
+ (BOOL)validateBankCardNumber:(NSString*)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString* regex2 = @"^(\\d{15,18})";
    NSPredicate* bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

//用户名
+ (BOOL)validateUserName:(NSString*)name
{
    NSString* userNameRegex = @"^[A-Za-z0-9]{4,20}+$";
    NSPredicate* userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//密码
+ (BOOL)validatePassword:(NSString*)passWord
{
    NSString* passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate* passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
//昵称
+ (BOOL)validateNickname:(NSString*)nickname
{
    NSString* nicknameRegex = @"^[a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate* passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

+ (NSString*)getCurrentDate
{
    NSDateFormatter* dateFormtter = [[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString = [dateFormtter stringFromDate:[NSDate date]];

    return dateString;
}

+ (NSString*)stringWithCurrenDate
{

    NSDate* date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    NSInteger second = [comps second];

    NSString* str = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld:%ld", (long)year, (long)month, (long)day, (long)hour, (long)minute, (long)second];
    return str;
}

//手机号码验证
+ (BOOL)validateMobile:(NSString*)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString* phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (NSString*)UTF8StringWithString:(NSString*)string
{

    NSString* UTF8String = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, NULL, kCFStringEncodingUTF8));

    return UTF8String;
}

//+ (NSString*)imageWithBase64:(UIImage*)image
//{
//
//    NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
//    if (imageData.length / 1024 > 200) {
//
//        imageData = UIImageJPEGRepresentation(image, 1024 * 200 / imageData.length);
//    }
//    NSString* imageStr = [GTMBase64 stringByEncodingData:imageData];
//
//    return imageStr;
//}

//车牌号验证
+ (BOOL)validateCarNo:(NSString*)carNo
{
    NSString* carRegex = @"^([a-z]|[A-Z]|[0-9]|[\u4e00-\u9fa5])$";
    NSPredicate* carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carRegex];
    SHLog(@"carTest is %@", carTest);
    return [carTest evaluateWithObject:carNo];
}

//发动机验证
+ (BOOL)validateEnginno:(NSString*)enginno
{
    NSString* userNameRegex = @"^([a-z]|[A-Z]|[0-9]){4,20}$";
    NSPredicate* userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:enginno];
    return B;
}

//验证中文汉字字母
+ (BOOL)validateString:(NSString*)regStr
{
    NSString* userNameRegex = @"^[a-zA-Z0-9\u4e00-\u9fa5]+$";
    NSPredicate* userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:regStr];
    return B;
}
//图片名称
+ (NSString*)imageNameWithCurrentDate
{

    NSDate* date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    NSInteger second = [comps second];
    NSInteger nanosecond = [comps nanosecond];
    NSString* str = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%ld%ld.jpg", (long)year, (long)month, (long)day, (long)hour, (long)minute, (long)second, (long)nanosecond];
    return str;
}

+ (NSString*)videoNameWithCurrentDate
{
    
    NSDate* date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    NSInteger second = [comps second];
    NSString* str = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%ld.mp4", (long)year, (long)month, (long)day, (long)hour, (long)minute, (long)second];
    return str;
}


+ (BOOL)isMobileNumber:(NSString*)mobileNum
{

    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString* MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10 * 中国移动：China Mobile
     11 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12 */
    NSString* CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15 * 中国联通：China Unicom  和177 170 虚拟运营商
     16 * 130,131,132,152,155,156,185,186
     17 */
    NSString* CU = @"^1(3[0-2]|5[256]|8[56]|7[0-9])\\d{8}$";
    /**
     20 * 中国电信：China Telecom
     21 * 133,1349,153,180,189
     22 */
    NSString* CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25 * 大陆地区固话及小灵通
     26 * 区号：010,020,021,022,023,024,025,027,028,029
     27 * 号码：七位或八位
     28 */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSString* phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";

    NSPredicate* regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate* regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate* regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate* regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //兼容14开头
    NSPredicate* regextestPhoneRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestPhoneRegex evaluateWithObject:mobileNum])) {
        return YES;
    }
    else {
        return NO;
    }
}
+ (BOOL)CheckInput:(NSString*)text
{
    if (text.length < 6) {
        return NO;
    }else{
    
        return YES;
    }
}

//+(NSString *)getDeviceMd5ID{
//
//    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
//    NSString *str = [dict objectForKey:(__bridge NSString *)kCFBundleIdentifierKey];
////    ZLog(@"%@",str);
//    NSString *iden = [NSString stringWithFormat:@"%@%@",[UserDateSingleton shareUserDateInstance].deviceToken,str];
////    ZLog(@"%@",iden);
////    ZLog(@"%@",iden.md5String);
//    
//    return iden.md5String;
//}


//+ (NSData *)decodeWithBase64String:(NSString *)str{
//    
//      NSData *data = [GTMBase64 decodeString:str];
//    
//    return data;
//}


+ (NSString*)UTF8_To_GB2312:(NSString*)utf8string
{
//    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSData* gb2312data = [utf8string dataUsingEncoding:-2147482063];
//    NSString *gbkstring = [[NSString alloc] initWithData:gb2312data encoding:-2147482063];
//    NSString* gbkString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)utf8string, NULL, NULL, kCFStringEncodingGB_18030_2000));
   NSString *str = (NSString*)CFBridgingRelease( CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)utf8string, NULL, kCFStringEncodingUTF8));
    return  str;
}


+ (BOOL)judgeOnlyIncludeCEN:(NSString *)str
{
    NSString * regex = @"[a-zA-Z0-9\u3400-\u9fff]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

+ (BOOL)isEnglishWordOrNumber:(NSString *)str{

    NSString* userNameRegex = @"^[A-Za-z0-9]+$";
    NSPredicate* userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:str];
    return B;
}

+ (BOOL)isOnlyNumber:(NSString *)str{

    NSString* userNameRegex = @"^[0-9]+$";
    NSPredicate* userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:str];
    return B;
}


+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

//+(NSString *)base64WithData:(NSData *)data{
//
//    return [GTMBase64 stringByEncodingData:data];
//}

+ (BOOL)stringisDate:(NSString *)string{

    NSString * regex = @"/^((((19|20)\d{2})-(0?[13-9]|1[012])-(0?[1-9]|[12]\d|30))|(((19|20)\d{2})-(0?[13578]|1[02])-31)|(((19|20)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|((((19|20)([13579][26]|[2468][048]|0[48]))|(2000))-0?2-29))$/";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];

}

+ (NSString *)stringWithCurrenday {
    
    NSDateFormatter* dateFormtter = [[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"yyyy年MM月dd日"];
    return [dateFormtter stringFromDate:[NSDate date]];
}
@end
