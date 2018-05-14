//
//  DOConnectionCell.h
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DOConnectionCellModel;

@interface DOConnectionCell : UITableViewCell

@property (nonatomic, strong) DOConnectionCellModel *cell_model;

+ (instancetype)connectionCellWithTableView:(UITableView *) tableView;

@end
