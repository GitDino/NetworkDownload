//
//  DOTypesCellModel.h
//  NetworkDownloadDemo
//
//  Created by 魏欣宇 on 2018/5/15.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOTypesCellModel : NSObject

@property (nonatomic, copy) NSString *cell_title;

@property (nonatomic, assign) Class push_class;

+ (instancetype)typesCellModelWithTitle:(NSString *) cell_title pushClass:(Class) push_class;

@end
