//
//  NetworkService.h
//  IJKDemo
//
//  Created by lee on 16/10/9.
//  Copyright © 2016年 bird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject

+ (void)loadData:(void (^)(NSDictionary *responseData))responseData;

@end
