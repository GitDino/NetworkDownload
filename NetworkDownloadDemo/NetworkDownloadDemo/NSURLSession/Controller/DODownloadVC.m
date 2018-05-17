//
//  DODownloadVC.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/17.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DODownloadVC.h"
#import "DODownloadView.h"

@interface DODownloadVC () <NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

#warning --------- UI ---------
@property (nonatomic, strong) DODownloadView *download_view;

#warning --------- 下载 ---------

/**
 全局会话
 */
@property (nonatomic, strong) NSURLSession *url_session;

/**
 全局下载任务
 */
@property (nonatomic, strong) NSURLSessionDownloadTask *load_task;

/**
 记录续传下载的数据
 */
@property (nonatomic, strong) NSData *resume_data;

@end

@implementation DODownloadVC

#pragma mark - Life Cycle
- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"断点下载";
    
    [self configSubViews];
    [self configAboutBlock];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self releaseSession];
}

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.download_view];
}

- (void)configAboutBlock
{
    NSLog(@"%@", Cache_Path);
    __weak typeof(self) weakSelf = self;
    self.download_view.operationBlock = ^(DownloadState load_state) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        switch (load_state) {
            case DownloadStateStart:
                strongSelf.download_view.load_state = DownloadStatePause;
                [strongSelf downloadStart];
                break;
            case DownloadStatePause:
                strongSelf.download_view.load_state = DownloadStateContinue;
                [strongSelf downloadPasue];
                break;
            case DownloadStateContinue:
                strongSelf.download_view.load_state = DownloadStatePause;
                [strongSelf downloadContinue];
                break;
                
            default:
                break;
        }
    };
}

/**
 释放Session及置空
 */
- (void)releaseSession
{
    [self.url_session invalidateAndCancel];
    self.url_session = nil;
}

#pragma mark - ---------- 下载 ----------

/**
 开始下载
 */
- (void)downloadStart
{
    self.load_task = [self.url_session downloadTaskWithURL:[NSURL URLWithString:MovieFile_URL]];
    [self.load_task resume];
}

/**
 继续下载
 */
- (void)downloadContinue
{
    if (self.resume_data == nil)
    {
        return;
    }
    
    self.load_task = [self.url_session downloadTaskWithResumeData:self.resume_data];
    [self.load_task resume];
    
    self.resume_data = nil;
}

/**
 暂停下载
 */
- (void)downloadPasue
{
    __weak typeof(self) weakSelf = self;
    [self.load_task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.resume_data = resumeData;
        strongSelf.load_task = nil;
    }];
}

#pragma mark - NSURLSessionDownloadDelegate代理方法
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *data = [NSData dataWithContentsOfFile:location.path];
    [data writeToFile:[Desktop_Path stringByAppendingString:downloadTask.response.suggestedFilename] atomically:YES];
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.download_view.load_progress = progress;
    });
}

#pragma mark - Getter Cycle
- (DODownloadView *)download_view
{
    if (!_download_view)
    {
        _download_view = [DODownloadView downloadView];
    }
    return _download_view;
}

- (NSURLSession *)url_session
{
    if (!_url_session)
    {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _url_session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _url_session;
}

@end
