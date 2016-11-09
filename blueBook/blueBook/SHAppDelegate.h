//
//  AppDelegate.h

//
//  Created by 石虎 on 16/5/4.
//  Copyright © 2016年 shih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "SHTableViewController.h"
#import "LeftSortsViewController.h"
#import "SHNavigationController.h"


@interface SHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)SHTableViewController *tbVc;
@property (nonatomic,strong)SHNavigationController *navigation;
//侧滑
@property (nonatomic,strong) LeftSlideViewController *LeftSlideVC;

@end

