//
//  UIViewController+TableView.m
//  Wenwanmi
//
//  Created by Chai on 15/6/4.
//  Copyright (c) 2015年 wenwanmi. All rights reserved.
//

#import "UIViewController+TableView.h"

@implementation UIViewController (TableView)


#pragma mark 隐藏多余的线
-(void)hiddenCellLine: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
