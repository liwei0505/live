//
//  NetworkService.m
//  IJKDemo
//
//  Created by lee on 16/10/9.
//  Copyright © 2016年 bird. All rights reserved.
//

#import "NetworkService.h"
#import "AFNetworking.h"

@interface NetworkService()

//@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation NetworkService

+ (void)loadData:(void (^)(NSDictionary *responseData))responseData {

    NSString *url = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        //NSLog(@"%@",responseObject);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            responseData(responseObject);
            
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"requst error");
    }];
    
}



@end
