//
//  DOConnectionCellModel.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOConnectionCellModel.h"

@implementation DOConnectionCellModel

+ (instancetype)connectionCellModelWithTitle:(NSString *) cell_title type:(ConnectionType) type
{
    DOConnectionCellModel *cell_model = [[DOConnectionCellModel alloc] init];
    cell_model.cell_title = cell_title;
    cell_model.type = type;
    return cell_model;
}

@end
