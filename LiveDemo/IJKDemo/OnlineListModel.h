//
//  OnlineListModel.h
//  IJKDemo
//
//  Created by lee on 16/10/9.
//  Copyright © 2016年 bird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property (nonatomic, strong) NSString *portrait;       //头像
@property (nonatomic, strong) NSString *nick;           //昵称
@property (nonatomic, strong) NSString *share_addr;     //
@property (nonatomic, strong) NSString *stream_addr;    //拉流地址

@end

@interface OnlineListModel : NSObject

+ (void)queryListData:(void (^)(NSArray *contentList))list;

@end
