//
//  SHCollegeRecommendCell.m

//
//  Created by 石虎 on 16/7/11.
//  Copyright © 2016年 shih. All rights reserved.
//

#import "SHCollegeRecommendCell.h"

@implementation SHCollegeRecommendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *Identifier = @"SHCollegeRecommendCell";
    SHCollegeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (cell == nil) {
        cell = SHLoadNibNamed(@"SHCollegeRecommendCell");
        
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }

     cell.name.textColor = RGB(113, 211, 244);
    return cell;
}
@end
