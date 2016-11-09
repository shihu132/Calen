//
//  SHBaseClassViewController.h

//
//  Created by 石虎 on 16/5/23.
//  Copyright © 2016年 shih. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SHAppDelegate.h"

@interface SHBaseClassViewController : UIViewController
//侧滑
@property (nonatomic,strong) LeftSlideViewController *LeftSlideVC;
/** 设置导航栏 title*/
- (void) setTitleViewText:(NSString *)text;



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
- (void)setVC:(UILabel *)lable richTextSting:(NSString *)strng colorR:(int)colorR colorG:(int)colorG colorB:(int)colorB singleNoRangeLoc:(int)loc singleNoRangeLen:(int)len fontB:(int)fontB fontBold:(int)fontBold;

@end


@interface SHBaseTableViewController : UITableViewController

//侧滑
@property (nonatomic,strong) LeftSlideViewController *LeftSlideVC;
@property (nonatomic, assign) NSInteger page;

/** 设置导航栏 title*/
- (void) setTitleViewText:(NSString *)text;




@end
