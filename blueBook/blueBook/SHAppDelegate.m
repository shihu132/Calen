//
//  AppDelegate.m

//
//  Created by 石虎 on 16/5/4.
//  Copyright © 2016年 shih. All rights reserved.
//

#import "SHAppDelegate.h"
#import "SHCollegeCalendarController.h"
#define SHVersionKey @"version"

@interface SHAppDelegate ()

@end

@implementation SHAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self setMainController];
    
    [self setSlidingFunction];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
//    [self registerShareApps];
    

    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
   }

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
#warning 版本升级还要写网络请求判断
}

- (void)applicationWillTerminate:(UIApplication *)application {
  }
#pragma mark - 主控制器
- (void)setMainController
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.tbVc = [[SHTableViewController alloc]init];
//     self.window.rootViewController = self.tbVc;
//    [self.window makeKeyAndVisible];
}
#pragma mark - 包装侧滑功能--登录
- (void)setSlidingFunction
{
 
    
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tbVc = [[SHTableViewController alloc]init];

               SHCollegeCalendarController *homePage = [[SHCollegeCalendarController alloc]init];
            SHNavigationController *nav = [[SHNavigationController alloc]initWithRootViewController:homePage];
            [[UINavigationBar appearance] setBarTintColor:RGB(2, 176, 247)];
            self.window.rootViewController = nav;
            
             
           [self.window makeKeyAndVisible];
}

#pragma mark - 接收到内存警告就会调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 1.停止当前下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 2.清空内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
