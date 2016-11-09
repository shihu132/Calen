//
//  SHTableViewController.m
//
//  Created by 石虎 on 16/5/4.
//  Copyright © 2016年 shih. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHTabBar.h"

@interface SHTableViewController ()<UITabBarControllerDelegate>

/**自定义tabbar*/
@property(nonatomic, weak)SHTabBar *customTabBar;

@end

@implementation SHTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /*
     1.自定义tabBar替换掉系统自带的tabBar
     */
    SHTabBar *tabBar = [[SHTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    // 2.添加所有子控制器
    [self setupAllChildViewController];
    
    self.delegate = self;

}
- (void)setupTabBar
{
    //1.系统的tabbar
    SHTabBar *tabBar = [[SHTabBar alloc]initWithFrame:self.tabBar.bounds];
    
    //把自定义的 tabbar 添加到系统的tabbar里面
    [self.tabBar addSubview:tabBar];
    
    self.customTabBar = tabBar;
    
    tabBar.delegate = self;
    
}

/**
 *  添加所有的子控制器
 */
- (void)setupAllChildViewController
{

}

/**
 *  添加一个子控制器
 */
- (void)setupOneChildViewController:(UIViewController *)vc  image:(UIImage *)image selectedImage:(UIImage *)selImage title:(NSString *)title
{
    // 1.设置tabBarItem相关属性
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selImage;
    // 2.包装一个导航控制器
    self.nav = [[SHNavigationController alloc] initWithRootViewController:vc];
    
    //2.1导航栏的颜色
      self.nav.navigationBar.barTintColor = RGB(2, 183, 227);
//     [[UINavigationBar appearance] setBarTintColor:[UIColor purpleColor]];
    //2.2 设置导航默认标题的颜色及字体大小
    self.nav.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor], UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    [self addChildViewController:self.nav];
}

@end
