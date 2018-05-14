//
//  DOTypesCellModel.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOTypesCellModel.h"

@implementation DOTypesCellModel

+ (instancetype)typesCellModelWithTitle:(NSString *) cell_title pushClass:(Class) push_class
{
    DOTypesCellModel *cell_model = [[DOTypesCellModel alloc] init];
    cell_model.cell_title = cell_title;
    cell_model.push_class = push_class;
    return cell_model;
}

@end
