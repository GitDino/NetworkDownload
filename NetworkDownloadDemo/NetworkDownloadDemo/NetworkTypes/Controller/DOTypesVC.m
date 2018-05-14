//
//  DOTypesVC.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOTypesVC.h"
#import "DOConnectionVC.h"
#import "DOSessionVC.h"

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
    
    [self configAboutBlock];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.types_tableView];
    [self.types_tableView refreshData:self.data_array];
}

- (void)configAboutBlock
{
    __weak typeof(self) weakSelf = self;
    self.types_tableView.clickIndexCellBlock = ^(NSIndexPath *indexPath, NSMutableArray *data_array) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        DOTypesCellModel *cell_model = data_array[indexPath.row];
        UIViewController *push_vc = [[[cell_model push_class] alloc] init];
        push_vc.title = cell_model.cell_title;
        [strongSelf.navigationController pushViewController:push_vc animated:YES];
    };
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
        DOTypesCellModel *cell_model1 = [DOTypesCellModel typesCellModelWithTitle:@"NSURLConnection下载学习" pushClass:[DOConnectionVC class]];
        DOTypesCellModel *cell_model2 = [DOTypesCellModel typesCellModelWithTitle:@"NSURLSession下载学习" pushClass:[DOSessionVC class]];
        
        NSArray *temp_array = @[cell_model1, cell_model2];
        
        _data_array = [NSMutableArray array];
        [_data_array addObjectsFromArray:temp_array];
    }
    return _data_array;
}

@end
