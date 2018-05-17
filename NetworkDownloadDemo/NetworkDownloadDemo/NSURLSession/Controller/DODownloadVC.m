//
//  DODownloadVC.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/17.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DODownloadVC.h"
#import "DODownloadView.h"

@interface DODownloadVC ()

@property (nonatomic, strong) DODownloadView *download_view;

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

#pragma mark - Custom Cycle
- (void)configSubViews
{
    [self.view addSubview:self.download_view];
}

- (void)configAboutBlock
{
    __weak typeof(self) weakSelf = self;
    self.download_view.operationBlock = ^(DownloadState load_state) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        switch (load_state) {
            case DownloadStateStart:
                strongSelf.download_view.load_state = DownloadStatePause;
                NSLog(@"开始下载");
                break;
            case DownloadStatePause:
                strongSelf.download_view.load_state = DownloadStateStart;
                NSLog(@"暂停下载");
                break;
            case DownloadStateFinish:
                NSLog(@"下载完成");
                break;
                
            default:
                break;
        }
    };
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

@end
