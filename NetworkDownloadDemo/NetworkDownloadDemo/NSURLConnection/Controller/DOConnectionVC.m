//
//  DOConnectionVC.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOConnectionVC.h"
#import "DOConnectionTableView.h"
#import "DOConnectionCellModel.h"

@interface DOConnectionVC ()

@property (nonatomic, strong) DOConnectionTableView *connection_tableView;

@property (nonatomic, strong) NSMutableArray *data_array;

@end

@implementation DOConnectionVC

#pragma mark - Life Cycle
- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configSubViews];
    
    [self configAboutBlock];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.connection_tableView];
    [self.connection_tableView refreshData:self.data_array];
}

- (void)configAboutBlock
{
    __weak typeof(self) weakSelf = self;
    self.connection_tableView.clickIndexCellBlock = ^(NSIndexPath *indexPath, NSMutableArray *data_array) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        DOConnectionCellModel *cell_model = data_array[indexPath.row];
        switch (cell_model.type) {
            case ConnectionTypeBlock:
                [strongSelf blockDownloadWithURL:[NSURL URLWithString:@""]];
                break;
            case ConnectionTypeDelegate:
                
                break;
                
            default:
                break;
        }
    };
}

#pragma mark - -------------------- Block 方式 --------------------
- (void)blockDownloadWithURL:(NSURL *) url
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
    }];
}


#pragma mark - -------------------- Delgate 方式 --------------------

#pragma mark - Getter Cycle
- (DOConnectionTableView *)connection_tableView
{
    if (!_connection_tableView)
    {
        _connection_tableView = [[DOConnectionTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _connection_tableView;
}

- (NSMutableArray *)data_array
{
    if (!_data_array)
    {
        DOConnectionCellModel *cell_model1 = [DOConnectionCellModel connectionCellModelWithTitle:@"Block下载" type:ConnectionTypeBlock];
        DOConnectionCellModel *cell_model2 = [DOConnectionCellModel connectionCellModelWithTitle:@"Delegate下载" type:ConnectionTypeDelegate];
        
        NSArray *temp_array = @[cell_model1, cell_model2];
        
        _data_array = [NSMutableArray array];
        [_data_array addObjectsFromArray:temp_array];
    }
    return _data_array;
}

@end
