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
#import "DOConnectionCell.h"

@interface DOConnectionVC () <NSURLConnectionDataDelegate, MBProgressHUDDelegate>

@property (nonatomic, strong) DOConnectionTableView *connection_tableView;

@property (nonatomic, strong) NSMutableArray *data_array;

@property (nonatomic, strong) MBProgressHUD *progress_HUD;

#warning 代理方式 --- 进度监听
/**
 下载路径
 */
@property (nonatomic, copy) NSString *download_path;

/**
 数据总长度
 */
@property (nonatomic, assign) long long expectedContent_length;

/**
 当前下载长度
 */
@property (nonatomic, assign) long long currentContent_length;

/**
 输出流
 */
@property (nonatomic, strong) NSOutputStream *file_stream;

/**
 下载线程的运行循环
 */
@property(assign,nonatomic)CFRunLoopRef download_runloop;

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
                [strongSelf blockDownloadWithURL:[NSURL URLWithString:MovieFile_URL]];
                break;
            case ConnectionTypeDelegate:
                [strongSelf delegateDownloadWithURL:[NSURL URLWithString:MovieFile_URL]];
                break;
                
            default:
                break;
        }
    };
}

#pragma mark - -------------------- Block 方式 --------------------
- (void)blockDownloadWithURL:(NSURL *) url
{
    __weak typeof(self) weakSelf = self;
    self.progress_HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progress_HUD];
    self.progress_HUD.label.text = @"正在下载...";
    self.progress_HUD.mode = MBProgressHUDModeText;
    [self.progress_HUD showAnimated:YES];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.progress_HUD hideAnimated:YES];
        });
        
        if (!connectionError)
        {
            [data writeToFile:[Desktop_Path stringByAppendingString:response.suggestedFilename] atomically:YES];
        }
        else
        {
            NSLog(@"下载出错：%@", connectionError);
        }
    }];
}


#pragma mark - -------------------- Delgate 方式 --------------------
- (void)delegateDownloadWithURL:(NSURL *) url
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
        [connection setDelegateQueue:[[NSOperationQueue alloc] init]];
        [connection start];
        
        self.download_runloop = CFRunLoopGetCurrent();
        
        CFRunLoopRun();
    });
}

#pragma mark - NSURLConnectionDataDelegate代理方法
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.expectedContent_length = response.expectedContentLength;
    self.currentContent_length = 0;
    
    self.download_path = [Desktop_Path stringByAppendingString:response.suggestedFilename];
    
    //removeItemAtPath 如果文件存在,则删除
    [[NSFileManager defaultManager] removeItemAtPath:self.download_path error:nil];
    
    self.file_stream = [[NSOutputStream alloc] initToFileAtPath:self.download_path append:YES];
    //打开文件流
    [self.file_stream open];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.currentContent_length += data.length;
    
    float progress = (float)self.currentContent_length / self.expectedContent_length;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        DOConnectionCell *cell = (DOConnectionCell *)[self.connection_tableView cellForRowAtIndexPath:indexPath];
        cell.progress_view.progress = progress;
    });
    
    NSLog(@"%f  %@", progress, [NSThread currentThread]);
    
    [self.file_stream write:data.bytes maxLength:data.length];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"下载完成！");
    [self.file_stream close];
    
    CFRunLoopStop(self.download_runloop);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}


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
