//
//  SHNavigationControllerViewController.m

//
//  Created by 石虎 on 16/5/4.
//  Copyright © 2016年 shih. All rights reserved.
//

#import "SHNavigationController.h"

@interface SHNavigationController ()

@end

@implementation SHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏的背景颜色
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];
    }
    //设置导航栏前景样色-和文字字体大小-颜色
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:17],NSFontAttributeName,nil]];

}


//首选状态栏样式-为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    /** UIStatusBarStyleDefault =状态栏样式-黑色
     *  UI Status Bar Style Light Conte = 用户界面状态栏样式的轻量
     *  UIStatusBarStyleBlackTranslucent =状态栏样式-半 黑色
     */
    return UIStatusBarStyleLightContent;
}


+ (void)initialize
{
    
    // 设置UIBarButtonItem的主题
    // 1.拿到主题对象
    UIBarButtonItem *item =  [UIBarButtonItem appearance];
    // 2.设置主题
    // 创建字典保持UIBarButtonItem需要设置的属性
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSForegroundColorAttributeName] = [UIColor orangeColor];
    // 设置UIBarButtonItem的属性
    [item setTitleTextAttributes:md forState:UIControlStateNormal];
    
    // 设置不可用状态的颜色主题
    // 创建字典保持UIBarButtonItem需要设置的属性
    NSMutableDictionary *disabledMd = [NSMutableDictionary dictionary];
    disabledMd[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 设置UIBarButtonItem的属性
    [item setTitleTextAttributes:disabledMd forState:UIControlStateDisabled];
}
//返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        //隐藏UITabBarController控制器下栏-
        viewController.hidesBottomBarWhenPushed = YES;
    }

    // 0.判断是否是栈底控制器
    if (self.viewControllers.count > 0) {
        // 不是栈底控制器, 需要添加左边和右边按钮
        // 1.设置左边按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回" highlightedImage:@"返回" target:self action:@selector(back)];
        
//        // 2.设置右边按钮
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)back
{
    SHLog(@"__func__%s", __func__);
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    SHLog(@"%s", __func__);
    [self popToRootViewControllerAnimated:YES];
}

@end
