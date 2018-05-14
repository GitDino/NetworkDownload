//
//  DOConnectionCellModel.h
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ConnectionType) {
    ConnectionTypeBlock = 0,  //Block方式
    ConnectionTypeDelegate    //Delegate方式
};

@interface DOConnectionCellModel : NSObject

@property (nonatomic, copy) NSString *cell_title;

@property (nonatomic, assign) ConnectionType type;

@property (nonatomic, assign) float progress;

+ (instancetype)connectionCellModelWithTitle:(NSString *) cell_title type:(ConnectionType) type;

@end
