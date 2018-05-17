//
//  DOSessionCellModel.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/17.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOSessionCellModel.h"

@implementation DOSessionCellModel

+ (instancetype)sessionCellModelWithTitle:(NSString *) cell_title type:(SessionType) type
{
    DOSessionCellModel *cell_model = [[DOSessionCellModel alloc] init];
    cell_model.cell_title = cell_title;
    cell_model.type = type;
    return cell_model;
}

@end
