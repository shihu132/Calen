//
//  TJPageViewController.m
//  demo
//
//  Created by lulul on 16/6/10.
//  Copyright © 2016年 TJPageController. All rights reserved.
//

#import "TJPageViewController.h"
#import "TJTabButton.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.width

const CGFloat kHeaderViewHeight = 35;

@interface TJPageViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerBackGroundView;
@property (weak, nonatomic) IBOutlet UIScrollView *body;
@property (weak, nonatomic) IBOutlet UIView *headerTopView;
@property (strong, nonatomic) UIView *headerTopViewMaskView;

@property (strong, nonatomic) NSMutableArray* tabButtons;
@property (strong, nonatomic) NSMutableArray* pages;
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation TJPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout  = UIRectEdgeNone;
    [self.body setPagingEnabled:YES];
    self.body.showsVerticalScrollIndicator = NO;
    self.body.showsHorizontalScrollIndicator = NO;
    self.body.delegate = self;
    self.body.scrollsToTop = NO;
    self.headerTopView.userInteractionEnabled = NO;
}

- (void)viewDidLayoutSubviews {
    if (self.tabButtons.count > 0) {
        CGFloat width = self.headerBackGroundView.frame.size.width / self.tabButtons.count;
        for (NSInteger i = 0; i < self.tabButtons.count; i++) {
            CGRect rect = CGRectMake(i * width, 0, width, self.headerBackGroundView.frame.size.height);
            TJTabButton* button = [self.tabButtons objectAtIndex:i];
            button.frame = rect;
        }
    }
    
    if (self.headerTopView.subviews.count > 0) {
        CGFloat width = self.headerTopView.frame.size.width / self.tabButtons.count;
        for (NSInteger i = 0; i < self.headerTopView.subviews.count; i++) {
            CGRect rect = CGRectMake(i * width, 0, width, self.headerTopView.frame.size.height);
            TJTabButton* button = self.headerTopView.subviews[i];
            button.frame = rect;
        }
    }
    
    if (self.pages.count > 0) {
        for (int i=0; i < self.pages.count; i++) {
            UIViewController* controller = [self.pages objectAtIndex:i];
            controller.view.frame = CGRectMake(i * self.body.frame.size.width, 0, self.body.frame.size.width, self.body.frame.size.height);
        }
        [self.body setContentSize:CGSizeMake(self.pages.count * self.body.frame.size.width, self.body.frame.size.height)];
    }
}

- (UIColor *)selectedStateColor {
    if (!_selectedStateColor) {
        _selectedStateColor = [UIColor colorWithRed:56 / 255.0 green:132 / 255.0 blue:224 / 255.0 alpha:1.0];
    }
    return _selectedStateColor;
}

- (UIColor *)normalStateColor {
    if (!_normalStateColor) {
        _normalStateColor = [UIColor lightGrayColor];
    }
    return _normalStateColor;
}

- (NSUInteger)fontSize {
    if (!_fontSize) {
        _fontSize = 14;
    }
    return _fontSize;
}

- (void)setupTopViewMasks {
    CGFloat itemWidth = kScreenWidth / self.tabButtons.count;
    UIView *topMaskView = [[UIView alloc]initWithFrame:CGRectMake(self.currentIndex * itemWidth, 0 , itemWidth, self.headerTopView.frame.size.height)];
    topMaskView.backgroundColor = [UIColor blackColor];
    self.headerTopViewMaskView = topMaskView;
    self.headerTopView.layer.mask = self.headerTopViewMaskView.layer;
}

-(void)setTitles:(NSArray *)titles {
    if (titles.count > 0) {
        _titles = [titles copy];
        self.tabButtons = [NSMutableArray array];
        CGFloat width = self.view.frame.size.width / titles.count;
        for (NSUInteger i = 0; i < titles.count; i++) {
            CGRect rect = CGRectMake(i * width, 0, width, self.headerBackGroundView.frame.size.height);
            TJTabButton * button = [[TJTabButton alloc]initWithFrame:rect type:TJPageViewControllerButtonTypeNormal];
            button.index = i;
            [button addTarget:self action:@selector(titleTap:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:titles[i]];
            [button setTitleColor:self.normalStateColor];
            [button setTitleFont:[UIFont systemFontOfSize:self.fontSize]];
            [button setUnderlineColor:self.normalStateColor];
            [self.headerBackGroundView addSubview:button];
            [self.tabButtons addObject:button];
            TJTabButton * topButton = [[TJTabButton alloc]initWithFrame:rect type:TJPageViewControllerButtonTypeSelected];
            [topButton setTitle:titles[i]];
            [topButton setTitleColor:self.selectedStateColor];
            [topButton setTitleFont:[UIFont boldSystemFontOfSize:self.fontSize]];
            [topButton setUnderlineColor:self.normalStateColor];
            [topButton setSelectedLineColor:self.selectedStateColor];
            [self.headerTopView addSubview:topButton];
        }
    }
    self.currentIndex = 0;
    self.headerBackGroundView.backgroundColor = [UIColor clearColor];
    [self setupTopViewMasks];
}

-(void) setControllers:(NSArray *)controllers {
    _controllers = controllers;
    if (controllers.count > 0) {
        self.pages = [NSMutableArray array];
        for (NSUInteger i = 0; i < controllers.count; i++) {
            UIViewController* controller = [controllers objectAtIndex:i];
            controller.view.frame = CGRectMake(i * self.body.frame.size.width, 0, self.body.frame.size.width, self.body.frame.size.height);
            [self addChildViewController:controller];
            [self.pages addObject:controller];
            [self.body addSubview:controller.view];
            [controller didMoveToParentViewController:self];
        }
        [self.body setContentSize:CGSizeMake(controllers.count * self.body.frame.size.width, self.body.frame.size.height)];
    }
}

-(void)titleTap: (UIButton*) sender {
    NSInteger index = 0;
    for (TJTabButton *button in self.tabButtons) {
        if (button.button == sender) {
            index = button.index;
            
            break;
        }
    }
    [self goToPage:index animated:NO];
}

- (void)goToPage:(NSInteger) index animated:(BOOL)animated {
    if (index < 0 || index >= self.tabButtons.count || index >= self.controllers.count) {
        return;
    }
    
    if (self.currentIndex != index) {
        self.currentIndex = index;
        if (self.delegate != nil) {
            [self.delegate pageChanged:self.titles[index]];
        }
        [self.body setContentOffset:CGPointMake(index * self.body.frame.size.width, 0) animated:animated];
    }
    
}


#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentWidth = scrollView.contentOffset.x;
    self.headerTopViewMaskView.frame = CGRectMake(currentWidth / scrollView.contentSize.width * self.view.frame.size.width, self.headerTopViewMaskView.frame.origin.y, self.headerTopViewMaskView.frame.size.width, self.headerTopViewMaskView.frame.size.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = (NSInteger)(self.body.contentOffset.x / self.body.frame.size.width + 0.5);
    [self goToPage:index animated:NO];
}

@end
