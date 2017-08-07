//
//  ViewController.m
//  IJKDemo
//
//  Created by lee on 16/10/9.
//  Copyright © 2016年 bird. All rights reserved.
//

#import "ViewController.h"
#import "OnlineListModel.h"
#import "UIImageView+WebCache.h"
#import "PlayerViewController.h"
#import "LiveViewController.h"
#import "BeautyOriginController.h"
#import "BeautyFilterController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *contentList;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self loadData];

}

#pragma mark - UI

- (void)prepareUI {

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"主播列表";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"直播" style:UIBarButtonItemStylePlain target:self action:@selector(captureVideo)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)captureVideo {
    
//系统摄像头
//    LiveViewController *live = [[LiveViewController alloc] init];
//    [self.navigationController pushViewController:live animated:YES];
    
//GPUImage原生美颜
    BeautyOriginController *beauty = [[BeautyOriginController alloc] init];
    [self.navigationController pushViewController:beauty animated:YES];
    
//利用美颜滤镜实现
//    BeautyFilterController *beauty = [[BeautyFilterController alloc] init];
//    [self.navigationController pushViewController:beauty animated:YES];
//    
}

#pragma mark - tableview datasource and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.contentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ListModel *model = self.contentList[indexPath.row];
    cell.textLabel.text = model.nick;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",model.portrait]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ListModel *model = self.contentList[indexPath.row];
    if (model) {
        PlayerViewController *player = [[PlayerViewController alloc] init];
        player.title = model.nick;
        player.stream_addr = model.stream_addr;
        [self.navigationController pushViewController:player animated:YES];
    }

}

#pragma mark - private

- (void)loadData {

    __weak typeof(self)weakSelf = self;
    [OnlineListModel queryListData:^(NSArray *contentList) {
        
        weakSelf.contentList = contentList;
        [weakSelf.tableView reloadData];
        
    }];

}


- (void)setContentList:(NSArray *)contentList {

    if (_contentList != contentList) {
       _contentList = contentList;
    }
}




@end
