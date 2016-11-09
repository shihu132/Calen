//
//  TJPageViewController.h
//  demo
//
//  Created by lulul on 16/6/10.
//  Copyright © 2016年 TJPageController. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat kHeaderViewHeight;

@protocol TJPageViewControllerPageChangedDelegate <NSObject>

- (void) pageChanged:(NSString*) tab;

@end

@interface TJPageViewController : UIViewController

@property (nonatomic, copy) NSArray* titles;
@property (nonatomic, copy) NSArray* controllers;
@property (nonatomic, weak) id<TJPageViewControllerPageChangedDelegate> delegate;

@property (nonatomic, strong) UIColor *selectedStateColor;
@property (nonatomic, strong) UIColor *normalStateColor;
@property (nonatomic, assign) NSUInteger fontSize;

@end
