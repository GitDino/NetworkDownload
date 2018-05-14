//
//  DOConnectionCell.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOConnectionCell.h"
#import "DOConnectionCellModel.h"

@interface DOConnectionCell ()

@end

@implementation DOConnectionCell

#pragma mark - Life Cycle
+ (instancetype)connectionCellWithTableView:(UITableView *) tableView
{
    static NSString *ID = @"DOConnectionCell";
    DOConnectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[DOConnectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    return self;
}

#pragma mark - Setter Cycle
- (void)setCell_model:(DOConnectionCellModel *)cell_model
{
    _cell_model = cell_model;
    
    self.textLabel.text = _cell_model.cell_title;
}

@end
