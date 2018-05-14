//
//  DOTypesCell.h
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DOTypesCellModel;

@interface DOTypesCell : UITableViewCell

@property (nonatomic, strong) DOTypesCellModel *cell_model;

+ (instancetype)typesCellWithTableView:(UITableView *) tableView;

@end
