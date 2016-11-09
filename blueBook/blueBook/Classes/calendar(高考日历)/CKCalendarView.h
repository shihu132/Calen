
//
//  AppDelegate.h

//
//  Created by 石虎 on 16/5/4.
//  Copyright © 2016年 shih. All rights reserved.
//
@protocol CKCalendarDelegate;

@interface CKDateItem : NSObject

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@end

typedef enum {
    startSunday = 1,
    startMonday = 2,
} CKCalendarStartDay;

@interface CKCalendarView : UIView

- (id)initWithStartDay:(CKCalendarStartDay)firstDay;
- (id)initWithStartDay:(CKCalendarStartDay)firstDay frame:(CGRect)frame;

@property (nonatomic) CKCalendarStartDay calendarStartDay;
@property (nonatomic, strong) NSLocale *locale;

@property (nonatomic, readonly) NSArray *datesShowing;

@property (nonatomic) BOOL onlyShowCurrentMonth;
@property (nonatomic) BOOL adaptHeightToNumberOfWeeksInMonth;

@property (nonatomic, weak) id<CKCalendarDelegate> delegate;

// Theming
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *dateOfWeekFont;
@property (nonatomic, strong) UIColor *dayOfWeekTextColor;
@property (nonatomic, strong) UIFont *dateFont;

- (void)setMonthButtonColor:(UIColor *)color;
- (void)setInnerBorderColor:(UIColor *)color;
- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor;

- (void)selectDate:(NSDate *)date makeVisible:(BOOL)visible;
- (void)reloadData;
- (void)reloadDates:(NSArray *)dates;

// Helper methods for delegates, etc.
- (BOOL)date:(NSDate *)date1 isSameDayAsDate:(NSDate *)date2;
- (BOOL)dateIsInCurrentMonth:(NSDate *)date;

@end

@protocol CKCalendarDelegate <NSObject>

@optional
- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date;
- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date;
- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date;
- (BOOL)calendar:(CKCalendarView *)calendar willDeselectDate:(NSDate *)date;
- (void)calendar:(CKCalendarView *)calendar didDeselectDate:(NSDate *)date;

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date;
- (void)calendar:(CKCalendarView *)calendar didChangeToMonth:(NSDate *)date;

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame;

@end