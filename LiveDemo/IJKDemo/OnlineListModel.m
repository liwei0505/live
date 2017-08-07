//
//  OnlineListModel.m
//  IJKDemo
//
//  Created by lee on 16/10/9.
//  Copyright © 2016年 bird. All rights reserved.
//

#import "OnlineListModel.h"
#import "NetworkService.h"

@implementation ListModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        
        NSDictionary *creator = [dict objectForKey:@"creator"];
        self.portrait = [creator objectForKey:@"portrait"];
        self.nick = [creator objectForKey:@"nick"];
        self.share_addr = [dict objectForKey:@"share_addr"];
        self.stream_addr = [dict objectForKey:@"stream_addr"];
        
    }
    return self;
    
}

@end

@implementation OnlineListModel

+ (void)queryListData:(void (^)(NSArray *contentList))list {

    [NetworkService loadData:^(NSDictionary *responseData) {
        
        int status = [[responseData objectForKey:@"dm_error"] intValue];
        if (!status) {
            
            NSArray *listArray = [responseData objectForKey:@"lives"];
            NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:listArray.count];
            for (NSDictionary *dict in listArray) {
                ListModel *model = [[ListModel alloc] initWithDict:dict];
                [tempArray addObject:model];
            }
            list(tempArray);
        }
        
    }];
}


@end
