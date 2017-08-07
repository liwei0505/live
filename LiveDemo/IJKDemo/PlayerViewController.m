//
//  PlayerViewController.m
//  IJKDemo
//
//  Created by lee on 16/10/10.
//  Copyright © 2016年 bird. All rights reserved.
//

#import "PlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface PlayerViewController ()

@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation PlayerViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self preparePlayer];
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    //界面消失前停止播放
    [self.player pause];
    [self.player stop];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI

- (void)preparePlayer {

    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.stream_addr] withOptions:nil];
    [playerVc prepareToPlay];
    playerVc.view.frame = self.view.frame;
    self.player = playerVc;
    [self.view addSubview:self.player.view];
    
}




@end
