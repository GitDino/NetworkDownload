//
//  DOSessionVC.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//  压缩、解压的框架 SSZipArchive

#import "DOSessionVC.h"
#import "DOSessionTableView.h"
#import "DOSessionCellModel.h"

@interface DOSessionVC ()

@property (nonatomic, strong) DOSessionTableView *session_tableView;

@property (nonatomic, strong) NSMutableArray *data_array;

@property (nonatomic, strong) MBProgressHUD *progress_HUD;

@end

@implementation DOSessionVC

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
    [self.view addSubview:self.session_tableView];
    [self.session_tableView refreshData:self.data_array];
}

- (void)configAboutBlock
{
    __weak typeof(self) weakSelf = self;
    self.session_tableView.clickIndexCellBlock = ^(NSIndexPath *indexPath, NSMutableArray *data_array) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        DOSessionCellModel *cell_model = data_array[indexPath.row];
        switch (cell_model.type) {
            case SessionTypeBlock:
                [strongSelf blockDownloadWithURL:[NSURL URLWithString:MovieFile_URL]];
                break;
            case SessionTypeDelegate:
                
                break;
                
            default:
                break;
        }
    };
}

#pragma mark - -------------------- Block 方式 --------------------
- (void)blockDownloadWithURL:(NSURL *) download_url
{
    NSLog(@"%@", Cache_Path);
    __weak typeof(self) weakSelf = self;
    self.progress_HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progress_HUD];
    self.progress_HUD.label.text = @"正在下载...";
    self.progress_HUD.mode = MBProgressHUDModeText;
    [self.progress_HUD showAnimated:YES];
    [[[NSURLSession sharedSession] downloadTaskWithURL:download_url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", location.path);
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.progress_HUD hideAnimated:YES];
        });
        
        if (!error)
        {
            NSString *file_name = [Desktop_Path stringByAppendingString:response.suggestedFilename];
            NSFileManager *file_manager = [NSFileManager defaultManager];
            [file_manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:file_name] error:nil];
        }
        else
        {
            NSLog(@"%@", error);
        }
    }] resume];
}

#pragma mark - Getter Cycle
- (DOSessionTableView *)session_tableView
{
    if (!_session_tableView)
    {
        _session_tableView = [[DOSessionTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _session_tableView;
}

- (NSMutableArray *)data_array
{
    if (!_data_array)
    {
        DOSessionCellModel *cell_model1 = [DOSessionCellModel sessionCellModelWithTitle:@"Block 下载" type:SessionTypeBlock];
        DOSessionCellModel *cell_model2 = [DOSessionCellModel sessionCellModelWithTitle:@"Delegate 下载" type:SessionTypeDelegate];
        
        NSArray *temp_array = @[cell_model1, cell_model2];
        
        _data_array = [NSMutableArray array];
        [_data_array addObjectsFromArray:temp_array];
    }
    return _data_array;
}

@end
