//
//  SHCollegeCalendarController.m

//
//  Created by 石虎 on 16/7/12.
//  Copyright © 2016年 shih. All rights reserved.
//

#import "SHCollegeCalendarController.h"
#import "FDCalendar.h"//日历
#import "SHCollegeRecommendCell.h"
#import "FDCalendarItem.h"
#import <CoreGraphics/CoreGraphics.h>
#import "CKCalendarView.h"


#define SHSpacingH 35
@interface SHCollegeCalendarController ()<UITableViewDelegate,UITableViewDataSource,CKCalendarDelegate>
{
   FDCalendarCell *cellF;
    
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headerView;


@property(nonatomic,strong)UIView *dayView;
@property(nonatomic,strong)UIView *entranceView;
@property(nonatomic,strong)NSArray *weekList;

@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;

@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@end

@implementation SHCollegeCalendarController
- (NSArray *)dayArray
{
    if (!_dayArray) {
        
        _dayArray = [[NSArray alloc]init];
        
    }
    return _dayArray;
}
-(instancetype)init

{
    self = [super init];
    if (self) {
       _weekList = [[NSArray alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[SHCommonMethod sharedManager] getNumberOfDaysOneYear];
    
    [self setupNav];
    
    [self setAddCalendarView];
    
    [self setCalendarTable];
    
    [self setSameDayTitle];
    
    [self setSameDay];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(self.view.height);
        
    }];
    
    [self setThisWeek];

}
#pragma mark - 设置导航栏
- (void)setupNav
{
    [self setTitleViewText:@"高考日历"];
    
    
    // 1.设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"menu" highlightedImage:@"menu" target:self action:@selector(openOrCloseLeftList)];
    
    // 2.设置右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"我的主页" highlightedImage:@"我的主页" target:self action:@selector(meHomeViewClicK)];

    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor whiteColor];

        _tableView.tableHeaderView = _headerView;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    
    return _tableView;
}

#pragma mark - 设置 headerView 高考日历
- (UIView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = [UIColor whiteColor];
        if (iPhone4 || iPhone5 ) {
            
            _headerView.frame = CGRectMake( 0, 0, kDeviceWidth, 495);
        }else if (iPhone6plus) {
            
            _headerView.frame = CGRectMake( 0, 0, kDeviceWidth, 575);
        
        }else{
            _headerView.frame = CGRectMake( 0, 0, kDeviceWidth, 540);
        }
        
    }
    return _headerView;
}

- (void)setAddCalendarView
{
   
    //当时时间距离未来(过去)的天数
    NSString * time =[NSString stringWithFormat:@"%@-06-07",[SHCommonMethod sharedManager].startDate];

    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * date = [dateFormatter dateFromString:time];
    NSDate * currentDate = [NSDate date];
    
    NSUInteger sec = [date timeIntervalSinceDate:currentDate];
    NSLog(@"sec%zd",sec/(3600*24));
    
    NSString *secStr = [NSString stringWithFormat:@"%lu",sec/(3600*24)+1];
  
    //1.
    UILabel *calenLable = [[UILabel alloc]init];
    calenLable.backgroundColor = RGB(248, 249, 250);
    calenLable.font = [UIFont systemFontOfSize:15.f];
    
    NSString *dayYY = [NSString stringWithFormat:@"%@",[SHCommonMethod sharedManager].startDate];
    NSString *dayDD = [NSString stringWithFormat:@"%@",secStr];
    [dayDD integerValue];
    calenLable.text = [NSString stringWithFormat:@"今日距%@年高考还有%@天",dayYY,dayDD];
    //富文本
    [[SHCommonMethod sharedManager]setVC:calenLable richTextSting: calenLable.text colorR:2 colorG:128 colorB:187 singleNoRangeLoc:12 singleNoRangeLen:dayDD.length fontB:15.f fontBold:15.f];
    calenLable.numberOfLines = 1;
    calenLable.textAlignment = NSTextAlignmentCenter;
    [calenLable sizeToFit];
    calenLable.frame = CGRectMake(0, 0, kDeviceWidth,SHSpacingH);
    [self.headerView addSubview:calenLable];
    
}


#pragma mark - 当日专项练习
- (void)setSameDayTitle
{
   
    UIView *dayView = [[UIView alloc]initWithFrame:SHCGRectMake(0,_calendar.height+35 , kDeviceWidth, 35)];
    dayView.backgroundColor = RGB(248, 249, 250);
    [self.headerView addSubview:dayView];
    _dayView = dayView;
    
    //练习标题
    UILabel *dayTitle = [[UILabel alloc]initWithFrame:SHCGRectMake(14,11.5 , kDeviceWidth/2, 12)];
    dayTitle.text = [NSString stringWithFormat:@"%@",@"石虎的高考"];
    dayTitle.numberOfLines = 1;
    dayTitle.textAlignment = NSTextAlignmentLeft;
    dayTitle.font = SHFont_15;
    [dayView addSubview:dayTitle];
    
    //坚持天数
     UILabel *dayLable = [[UILabel alloc]initWithFrame:SHCGRectMake(kDeviceWidth/2,11.5 , kDeviceWidth/2 - 14, 12)];
    NSString *str = [NSString stringWithFormat:@"%ld",_dayArray.count];
    dayLable.text = [NSString stringWithFormat:@"你已坚持专项练习%@天",str];
    
     [[SHCommonMethod sharedManager]setVC:dayLable richTextSting: dayLable.text colorR:2 colorG:128 colorB:187 singleNoRangeLoc:8 singleNoRangeLen:str.length fontB:15.f fontBold:15.f];
    dayLable.numberOfLines = 1;
    dayLable.textAlignment = NSTextAlignmentRight;
    dayLable.font = SHFont_15;

    [dayView addSubview:dayLable];

}
#pragma mark - 当日完成率
- (void)setSameDay
{
    
    UIView *entranceView = [[UIView alloc]initWithFrame:SHCGRectMake(0,_calendar.height+35+35 , kDeviceWidth, 76)];
    entranceView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:entranceView];
    _entranceView = entranceView;
    
    //文科生点击
    UIButton *liberalArts = [[UIButton alloc]init];
    [liberalArts setTitle:@"文科生入口" forState:UIControlStateNormal];
    [liberalArts setTitleColor:[UIColor colorWithRed:2/255.0 green:128/255.0 blue:187/255.0 alpha:1]  forState:UIControlStateNormal];
    [liberalArts.titleLabel setFont:SHFont_15];
    [liberalArts addTarget:self action:@selector(liberalArtsClick:) forControlEvents:UIControlEventTouchUpInside];
    liberalArts.layer.borderWidth = 1;
    liberalArts.layer.borderColor = [UIColor colorWithRed:2/255.0 green:128/255.0 blue:187/255.0 alpha:1].CGColor;
    liberalArts.layer.cornerRadius = 5;
    liberalArts.tag = 100;
    [entranceView addSubview:liberalArts];
    [liberalArts mas_makeConstraints:^(MASConstraintMaker *make) {
    
        //大于或等于mas_greaterThanOrEqualTo
       make.centerX.mas_lessThanOrEqualTo(self.view.centerX).mas_offset(-75);
       make.top.mas_equalTo(@15);
       make.size.mas_equalTo(CGSizeMake(100, 30));
       make.left.mas_lessThanOrEqualTo(55);
        
    }];
    
    //理科生点击
    UIButton *science = [[UIButton alloc]init];
    [science setTitle:@"理科生入口" forState:UIControlStateNormal];
    [science setTitleColor:[UIColor colorWithRed:2/255.0 green:128/255.0 blue:187/255.0 alpha:1]  forState:UIControlStateNormal];
    [science.titleLabel setFont:SHFont_15];
    [science addTarget:self action:@selector(liberalArtsClick:) forControlEvents:UIControlEventTouchUpInside];
    science.layer.borderWidth = 1;
    science.layer.borderColor = [UIColor colorWithRed:2/255.0 green:128/255.0 blue:187/255.0 alpha:1].CGColor;
    science.layer.cornerRadius = 5;
    science.tag = 101;
    [entranceView addSubview:science];
    [science mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_lessThanOrEqualTo(self.view.centerX).mas_offset(75);
        make.top.mas_equalTo(@15);
        make.width.mas_equalTo(liberalArts.mas_width);
        make.height.mas_equalTo(liberalArts.mas_height);
        make.right.mas_lessThanOrEqualTo(55);
    }];

    
    //完成正确率
    UILabel *correctRate = [[UILabel alloc]init];
    correctRate.text = [NSString stringWithFormat:@"完成当日专项练习%@,即可点亮日历",@"60%正确率"];
    [[SHCommonMethod sharedManager]setVC:correctRate richTextSting:correctRate.text colorR:2 colorG:128 colorB:187 singleNoRangeLoc:8 singleNoRangeLen:6 fontB:15.f fontBold:15.f];
    correctRate.numberOfLines = 1;
    correctRate.textAlignment = NSTextAlignmentLeft;
    correctRate.font = SHFont_15;
    [correctRate sizeToFit];
    [entranceView addSubview:correctRate];
    [correctRate mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(liberalArts.mas_left).offset(-5);
        make.top.mas_equalTo(liberalArts.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(kDeviceWidth -50);
       
    }];
        
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _weekList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     SHCollegeRecommendCell *cell = [SHCollegeRecommendCell cellWithTableView:tableView];
       
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 35)];

    view.backgroundColor = RGB(248, 249, 250);
    
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"%@",@"本周名师专题推荐"];
    label.frame = CGRectMake(14,12.5, kDeviceWidth, 12);
    label.font = SHFont_15;
    [view addSubview:label];
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//点击后取消-点击颜色
    
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - 本周名师专题推荐
- (void)setThisWeek
{
   
}

- (void)liberalArtsClick:(UIButton *)btn
{
    
    if (btn.tag == 100) {//理科
        
        
    }else if (btn.tag == 101){//文科
        
             
    }
    
}


#pragma mark - 日历
#pragma mark - 设置
- (void)setCalendarTable
{
  
    //日历
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
    
    self.disabledDates = @[
                           [self.dateFormatter dateFromString:@"05/01/2013"],
                           [self.dateFormatter dateFromString:@"06/01/2013"],
                           [self.dateFormatter dateFromString:@"07/01/2013"]
                           ];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    calendar.frame = CGRectMake(0, 35, [UIScreen mainScreen].bounds.size.width, 399);
    [self.headerView addSubview:calendar];
    
    //显示下面的时间
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    [self.headerView addSubview:self.dateLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
  
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date) {
        
        self.calendar.backgroundColor = [UIColor whiteColor];
        return YES;
    } else {
        self.calendar.backgroundColor = [UIColor redColor];
        return NO;
    }
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}
@end

