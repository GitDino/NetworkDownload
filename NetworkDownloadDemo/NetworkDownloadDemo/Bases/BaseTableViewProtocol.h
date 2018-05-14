//
//  BaseTableViewProtocol.h
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseTableViewProtocol <NSObject, UITableViewDataSource, UITableViewDelegate>

- (void)refreshData:(NSMutableArray *) data_array;

- (id)obtainDataWithIndex:(NSIndexPath *) indexPath;

- (NSArray *)obtainDataArray;

@end
