//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by 石虎 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "SHHomePageViewController.h"
#import "SHEditorialIntroductionViewController.h"
#import "SHMeHomeViewController.h"
#import "SHHighFrequencyViewController.h"
#import "SHExerciseViewController.h"
#import "SHEditorialTeacherViewController.h"
#import "SHBoutiqueClassViewController.h"
#import "SHCollegeCalendarController.h"//日历
#import "SHWinSpecialViewController.h"
#import "SHFormaBookController.h"
#import "SHLeftSortsCell.h"
#import "SHEditorialIntroductionViewController.h"//临时测试控制器


@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *titles;
@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addTableview];
   
  
}
- (NSArray *)titles
{
    if (!_titles) {
        _titles = [[NSArray alloc]init];
        _titles = @[@"首页",@"赢考专题",@"备考宝典",@"高频考点",@"测评练习",@"名师主编",@"线下精品班",@"高考日历",@"编委介绍测试",@" ",@" ",@" ",@" ",@" ",@"",@"",@"",@"",@""];
    }
    return _titles;
}

#pragma mark - 设置添加 table
- (void)addTableview
{
//    self.view.backgroundColor = RGB(2, 183, 227);
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
//        imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor blackColor];
    
    UITableView *tableview = [[UITableView alloc]init];
    self.tableview = tableview;
    tableview.separatorColor = [UIColor whiteColor];
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.bounces = NO;
    tableview.opaque = NO;
    
    /**
     *   UITableViewCellSeparatorStyleNone,
     UITableViewCellSeparatorStyleSingleLine,
     UITableViewCellSeparatorStyleSingleLineEtched
     */
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableview];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.titles.count;
    return 19;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    SHLeftSortsCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
   
    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
        
         cell = SHLoadNibNamed(@"SHLeftSortsCell");
        
        //cell 右侧的小箭头
        //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
//        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.imageView.backgroundColor = [UIColor whiteColor];
    }

    NSArray *images = @[@"首页icon",@"赢考专题icon",@"备考宝典-备",@"高频考点",@"测评练习",@"名师主编-名",@"线下精品班",@"高考日历",@"首页icon",@" ",@" ",@" ",@" ",@" ",@"",@"",@"",@"",@""];
    
    if (self.titles >0) {
        
        cell.textLabel.text = self.titles[indexPath.row];        
    }
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    if (indexPath.row >= 9) {
        cell.lineLable.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//点击后取消-点击颜色
    //首页
    SHHomePageViewController *homePageView = [[SHHomePageViewController alloc]init];
    
    SHLog(@"--indexPath.row)%ld---",(long)indexPath.row);
    if (indexPath.row == 0) {
     

//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SHMeHomeViewController" bundle:nil];
//        SHMeHomeViewController *meHomeView= sb.instantiateInitialViewController;
//        
//        [self presentViewController:meHomeView animated:YES completion:nil];
        
        
      //主页
//    SHMeHomeViewController *meHomeView = [[SHMeHomeViewController alloc]init];
//        [self setUpAddController:meHomeView];
       
        //首页
        [self setUpAddController:homePageView];
        
    }else if (indexPath.row == 1) {
        //赢考专题
        
        SHWinSpecialViewController *winExpertView = [[SHWinSpecialViewController alloc]init];
        
        [homePageView requestSubjectSubject];
        [self setUpAddController:winExpertView];
        
    }  else if (indexPath.row == 2) {
    //备考宝典
        
        SHFormaBookController *formaBookViewController = [[SHFormaBookController alloc]init];
        [self setUpAddController:formaBookViewController];

    } else if (indexPath.row == 3) {
    //高频考点
        
        SHHighFrequencyViewController *highFrequencyViewController = [[SHHighFrequencyViewController alloc]init];
        
        [homePageView requestHighFrequency];
        [self setUpAddController:highFrequencyViewController];
        
    } else if (indexPath.row == 4) {
    //测试练习
        
        SHExerciseViewController *evaluationExerciseView = [[SHExerciseViewController alloc]init];
        [self setUpAddController:evaluationExerciseView];
        
    } else if (indexPath.row == 5) {
    //名师主编
        
        SHEditorialTeacherViewController *editorialTeacherViewController = [[SHEditorialTeacherViewController alloc]init];
        
        [homePageView requestTeacherEditor];
        [self setUpAddController:editorialTeacherViewController];
      
    } else if (indexPath.row == 6) {
    //线下精品班
        
        SHBoutiqueClassViewController *boutiqueClassViewController = [[SHBoutiqueClassViewController alloc]init];
        
        [homePageView requestBoutiqueClassList];
        [self setUpAddController:boutiqueClassViewController];
    
    } else if (indexPath.row == 7) {
    //高考日历
        
        SHCollegeCalendarController *collegeCalendar = [[SHCollegeCalendarController alloc]init];
        [homePageView requestHighCalendar];
        [self setUpAddController:collegeCalendar];
        
    }else if (indexPath.row == 8) {
      //临时测试控制器
        SHEditorialIntroductionViewController *editorialIntroductionView = [[SHEditorialIntroductionViewController alloc]init];
        [self setUpAddController:editorialIntroductionView];
        
    }


}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor whiteColor];
//    view.backgroundColor = RGB(2, 183, 227);
    
//    UILabel *label = [[UILabel alloc]init];
//    NSString *str = [NSString stringWithFormat:@"%@",@"小蓝书"];
//    label.text = str;
//    label.frame = CGRectMake(15, 20, 150, 30);
//    [view addSubview:label];
    
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/**
 *  添加主控制器
 */
- (void)setUpAddController:(UIViewController *)vc
{
    
    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
    SHNavigationController *nav = [[SHNavigationController alloc]initWithRootViewController:vc];
    
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:nav];
    [[UINavigationBar appearance] setBarTintColor:RGB(2, 176, 247)];
    [UIApplication sharedApplication].keyWindow.rootViewController = self.LeftSlideVC;
    
}

@end
