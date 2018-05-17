//
//  DOSessionCell.m
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/17.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DOSessionCell.h"
#import "DOSessionCellModel.h"

@implementation DOSessionCell

#pragma mark - Life Cycle
+ (instancetype)sessionCellWithTableView:(UITableView *) tableView
{
    static NSString *ID = @"DOSessionCell";
    DOSessionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[DOSessionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){}
    return self;
}

#pragma mark - Setter Cycle
- (void)setCell_model:(DOSessionCellModel *)cell_model
{
    _cell_model = cell_model;
    
    self.textLabel.text = _cell_model.cell_title;
}

@end
