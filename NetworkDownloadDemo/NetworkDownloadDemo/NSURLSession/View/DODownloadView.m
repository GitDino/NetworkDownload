//
//  DODownloadView.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/17.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DODownloadView.h"

@interface DODownloadView ()

/**
 下载进度
 */
@property (nonatomic, strong) UIProgressView *progress_view;

/**
 进度显示
 */
@property (nonatomic, strong) UILabel *progress_label;

/**
 操作按钮
 */
@property (nonatomic, strong) UIButton *operate_btn;

@end

@implementation DODownloadView

#pragma mark - Life Cycle
+ (instancetype)downloadView
{
    DODownloadView *download_view = [[DODownloadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    return download_view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.progress_view];
        [self addSubview:self.progress_label];
        [self addSubview:self.operate_btn];
        [self.operate_btn addTarget:self action:@selector(clickOperationAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - Event Cycle
- (void)clickOperationAction:(UIButton *) operate_btn
{
    if (self.operationBlock)
    {
        self.operationBlock(self.load_state);
    }
    
    switch (self.load_state) {
        case DownloadStateFinish:
            [self.operate_btn setTitle:@"下载" forState:UIControlStateNormal];
            break;
            
        case DownloadStateStart:
            [self.operate_btn setTitle:@"继续" forState:UIControlStateNormal];
            break;
            
        case DownloadStatePause:
            [self.operate_btn setTitle:@"暂停" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

#pragma mark - Getter Cycle
- (UIProgressView *)progress_view
{
    if (!_progress_view)
    {
        _progress_view = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 40, 2)];
    }
    return _progress_view;
}

- (UILabel *)progress_label
{
    if (!_progress_label)
    {
        _progress_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 117, SCREEN_WIDTH - 40, 30)];
        _progress_label.textAlignment = NSTextAlignmentCenter;
        _progress_label.text = @"0.00%";
    }
    return _progress_label;
}

- (UIButton *)operate_btn
{
    if (!_operate_btn)
    {
        _operate_btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 90) * 0.5, 180, 90, 44)];
        _operate_btn.layer.masksToBounds = YES;
        _operate_btn.layer.cornerRadius = 3.0;
        _operate_btn.layer.borderWidth = 1.0;
        _operate_btn.layer.borderColor = Main_Color.CGColor;
        [_operate_btn setTitleColor:Main_Color forState:UIControlStateNormal];
        [_operate_btn setTitle:@"下载" forState:UIControlStateNormal];
    }
    return _operate_btn;
}

@end
