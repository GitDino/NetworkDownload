//
//  DOTypesCell.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOTypesCell.h"
#import "DOTypesCellModel.h"

@implementation DOTypesCell

#pragma mark - Life Cycle
+ (instancetype)typesCellWithTableView:(UITableView *) tableView
{
    static NSString *ID = @"DOTypesCell";
    DOTypesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[DOTypesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){}
    return self;
}

#pragma mark - Setter Cycle
- (void)setCell_model:(DOTypesCellModel *)cell_model
{
    _cell_model = cell_model;
    
    self.textLabel.text = _cell_model.cell_title;
}

@end
