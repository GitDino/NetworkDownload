//
//  DOTypesTableView.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOTypesTableView.h"
#import "DOTypesCell.h"

@implementation DOTypesTableView

#pragma mark - UITableViewDataSource数据源方法

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOTypesCell *cell = [DOTypesCell typesCellWithTableView:tableView];
    cell.cell_model = [self obtainDataWithIndex:indexPath];
    return cell;
}

@end
