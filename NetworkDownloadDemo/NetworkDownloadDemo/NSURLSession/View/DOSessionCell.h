//
//  DOSessionCell.h
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/17.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DOSessionCellModel;

@interface DOSessionCell : UITableViewCell

@property (nonatomic, strong) DOSessionCellModel *cell_model;

+ (instancetype)sessionCellWithTableView:(UITableView *) tableView;

@end
