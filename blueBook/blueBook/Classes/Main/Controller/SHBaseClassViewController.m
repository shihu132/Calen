//
//  SHBaseClassViewController.m
//  blueBook
//
//  Created by 石虎 on 16/5/23.
//  Copyright © 2016年 shih. All rights reserved.
//

#import "SHBaseClassViewController.h"


@interface SHBaseClassViewController ()

@end

@implementation SHBaseClassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
}
#pragma mark - 初始化导航条
- (void)setupNav
{
    self.view.backgroundColor = [UIColor purpleColor];
    
    // 1.设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"分类" highlightedImage:@"分类" target:self action:@selector(openOrCloseLeftList)];
    // 2.设置右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"我的主页" highlightedImage:@"我的主页" target:self action:@selector(rightClick)];
}
#pragma mark - 监听右侧导航栏按钮
- (void)rightClick
{
    SHLog(@"2222");
    
   
    
}
#pragma mark - 打开左侧列表
- (void)openOrCloseLeftList
{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"SHBaseClassViewController" object:self];
}
// title
- (void)setTitleViewText:(NSString *)text {
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.title = text;
}
@end

@interface SHBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation SHBaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     self.tableView.showsHorizontalScrollIndicator = NO;
     self.tableView.showsVerticalScrollIndicator = NO;
    _page = 1;
    
    [self hiddenCellLine:self.tableView];
    
}
#pragma mark - 初始化导航条
- (void)setupNav
{
    self.view.backgroundColor = [UIColor redColor];
    
    // 1.设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"分类" highlightedImage:@"分类" target:self action:@selector(openOrCloseLeftList)];
    // 2.设置右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"我的主页" highlightedImage:@"我的主页" target:self action:@selector(meHomeViewClicK)];
}
#pragma mark - 打开左侧列表
- (void)openOrCloseLeftList
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SHBaseClassViewController" object:self];
}
- (void)meHomeViewClicK
{
       

}
/** 导航栏-文字*/
- (void)setTitleViewText:(NSString *)text {
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.title = text;
}


@end
