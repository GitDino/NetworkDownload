//
//  DOBaseTableView.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOBaseTableView.h"

@interface DOBaseTableView ()

@property (nonatomic, strong) NSMutableArray *data_array;

@end

@implementation DOBaseTableView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _data_array = [NSMutableArray array];
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - BaseTableViewProtocol协议方法
- (void)refreshData:(NSMutableArray *)data_array
{
    if (self.data_array == nil)
    {
        self.data_array = data_array;
    }
    else
    {
        [self.data_array removeAllObjects];
        [self.data_array addObjectsFromArray:data_array];
    }
    
    [self reloadData];
}

- (void)refreshData:(NSMutableArray *)data_array indexSection:(NSInteger)section indexRow:(NSInteger)row
{
    if (self.data_array == nil)
    {
        self.data_array = data_array;
    }
    else
    {
        [self.data_array removeAllObjects];
        [self.data_array addObjectsFromArray:data_array];
    }
    
    NSIndexPath *index_path = [NSIndexPath indexPathForRow:row inSection:section];
    [self reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index_path, nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (id)obtainDataWithIndex:(NSIndexPath *)indexPath
{
    return self.data_array[indexPath.row];
}

- (NSArray *)obtainDataArray
{
    return self.data_array;
}

#pragma mark - UITableViewDataSource数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data_array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"BaseTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - UITableViewDelegate代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.clickIndexCellBlock)
    {
        self.clickIndexCellBlock(indexPath, self.data_array);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}



@end
