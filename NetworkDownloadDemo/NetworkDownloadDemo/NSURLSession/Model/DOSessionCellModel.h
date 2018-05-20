//
//  DOSessionCellModel.h
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/17.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SessionType) {
    SessionTypeBlock = 0,   //Block 方式
    SessionTypeDelegate,    //Delegate 方式
};

@interface DOSessionCellModel : NSObject

@property (nonatomic, copy) NSString *cell_title;

@property (nonatomic, assign) SessionType type;

+ (instancetype)sessionCellModelWithTitle:(NSString *) cell_title type:(SessionType) type;

@end
