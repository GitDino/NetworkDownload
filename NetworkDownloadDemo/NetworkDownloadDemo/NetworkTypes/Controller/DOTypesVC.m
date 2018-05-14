//
//  DOTypesVC.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOTypesVC.h"
#import "DOTypesTableView.h"
#import "DOTypesCellModel.h"

@interface DOTypesVC ()

@property (nonatomic, strong) DOTypesTableView *types_tableView;

@property (nonatomic, strong) NSMutableArray *data_array;

@end

@implementation DOTypesVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"类型";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configSubViews];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.types_tableView];
    [self.types_tableView refreshData:self.data_array];
}

#pragma mark - Getter Cycle
- (DOTypesTableView *)types_tableView
{
    if (!_types_tableView)
    {
        _types_tableView = [[DOTypesTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _types_tableView;
}

- (NSMutableArray *)data_array
{
    if (!_data_array)
    {
        DOTypesCellModel *cell_model1 = [[DOTypesCellModel alloc] init];
        cell_model1.cell_title = @"NSURLConnection下载学习";
        DOTypesCellModel *cell_model2 = [[DOTypesCellModel alloc] init];
        cell_model2.cell_title = @"NSURLSession下载学习";
        
        NSArray *temp_array = @[cell_model1, cell_model2];
        
        _data_array = [NSMutableArray array];
        [_data_array addObjectsFromArray:temp_array];
    }
    return _data_array;
}

@end
