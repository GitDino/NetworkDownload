//
//  DODownloadView.h
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/17.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DownloadState) {
    DownloadStateStart,
    DownloadStatePause,
    DownloadStateFinish
};

typedef void(^operationBlock)(DownloadState load_state);

@interface DODownloadView : UIView

@property (nonatomic, assign) DownloadState load_state;

@property (nonatomic, copy) operationBlock operationBlock;

+ (instancetype)downloadView;

@end
