//
//  AppDelegate.h

//
//  Created by 石虎 on 16/5/4.
//  Copyright © 2016年 shih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCalendarDayM.h"

@interface FDCalendar : UIView

- (instancetype)initWithCurrentDate:(NSDate *)date zhengquelv:(SHCalendarDayM *)calendarDayM;

@end
