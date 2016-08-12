//
//  HotspotTableViewCell.h
//  新闻APP
//
//  Created by qingyun on 16/7/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ParseJsonModel;
@interface PressTableViewCell : UITableViewCell
@property (nonatomic, strong) ParseJsonModel *parseJsonModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath;

@end
