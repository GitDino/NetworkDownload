//
//  DOBaseTableView.h
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewProtocol.h"

typedef void(^clickIndexCellBlock)(NSIndexPath *indexPath, NSMutableArray *data_array);

@interface DOBaseTableView : UITableView <BaseTableViewProtocol>

@property (nonatomic, copy) clickIndexCellBlock clickIndexCellBlock;

@end
