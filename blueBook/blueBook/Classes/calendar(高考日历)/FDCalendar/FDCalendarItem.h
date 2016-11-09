//
//  AppDelegate.h

//
//  Created by 石虎 on 16/5/4.
//  Copyright © 2016年 shih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCollegeCalendarController.h"
#import "SHCalendarDayM.h"


#define DeviceWidth [UIScreen mainScreen].bounds.size.width

@protocol FDCalendarItemDelegate;

@interface FDCalendarItem : UIView


@property(nonatomic,strong)SHCollegeCalendarController *calendarC;
@property(nonatomic,strong)SHCalendarDayM *calendarDayM;
@property(nonatomic,copy)NSString *zhengquelv;


@property (weak, nonatomic) NSDate *date;
@property (weak, nonatomic) id<FDCalendarItemDelegate> delegate;

- (NSDate *)nextMonthDate;
- (NSDate *)previousMonthDate;

@end

@protocol FDCalendarItemDelegate <NSObject>



- (void)calendarItem:(FDCalendarItem *)item didSelectedDate:(NSDate *)date;

@end

@interface FDCalendarCell : UICollectionViewCell

- (UILabel *)dayLabel;
- (UILabel *)chineseDayLabel;
@property(nonatomic,strong)UIImageView *imageVieWroundFace;//圆脸

@end
