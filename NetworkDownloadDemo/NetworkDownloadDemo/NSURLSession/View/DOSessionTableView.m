//
//  DOSessionTableView.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/17.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOSessionTableView.h"
#import "DOSessionCell.h"

@implementation DOSessionTableView

#pragma mark - UITableViewDataSource数据源方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOSessionCell *cell = [DOSessionCell sessionCellWithTableView:tableView];
    cell.cell_model = [self obtainDataWithIndex:indexPath];
    return cell;
}

@end
