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

- (void)refreshData:(NSMutableArray *) data_array indexSection:(NSInteger) section indexRow:(NSInteger) row;

- (id)obtainDataWithIndex:(NSIndexPath *) indexPath;

- (NSArray *)obtainDataArray;

@end
