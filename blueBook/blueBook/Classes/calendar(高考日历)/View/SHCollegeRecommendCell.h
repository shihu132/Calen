//
//  SHCollegeRecommendCell.h

//
//  Created by 石虎 on 16/7/11.
//  Copyright © 2016年 shih. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCollegeRecommendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
