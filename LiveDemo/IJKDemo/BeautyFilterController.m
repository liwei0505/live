//
//  BeautyFilterController.m
//  IJKDemo
//
//  Created by lee on 16/10/13.
//  Copyright © 2016年 bird. All rights reserved.

/***
 
 GPUImage 利用美颜滤镜实现
 
 */

#import "BeautyFilterController.h"
#import "GPUImage.h"
#import "GPUImageBeautifyFilter.h"

@interface BeautyFilterController ()

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *captureVideoPreview;
@property (nonatomic, strong) UISwitch *beautySwitch;

@end

@implementation BeautyFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.beautySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(20, 80, 30, 30)];
    [self.beautySwitch addTarget:self action:@selector(openBeautifyFilter:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.beautySwitch];
    
    [self prepareVideo];
    
}

- (void)prepareVideo {

    // 创建视频源
    // SessionPreset:屏幕分辨率，AVCaptureSessionPresetHigh会自适应高分辨率
    // cameraPosition:摄像头方向
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera = videoCamera;
    
    // 创建最终预览View
    GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.frame];
    [self.view insertSubview:captureVideoPreview atIndex:0];
    self.captureVideoPreview = captureVideoPreview;
    
    // 设置处理链
    [self.videoCamera addTarget:self.captureVideoPreview];
    
    // 必须调用startCameraCapture，底层才会把采集到的视频源，渲染到GPUImageView中，就能显示了。
    // 开始采集视频
    [self.videoCamera startCameraCapture];


}

- (void)openBeautifyFilter:(UISwitch *)sender {

    // 切换美颜效果原理：移除之前所有处理链，重新设置处理链
    if (sender.on) {
        
        // 移除之前所有处理链
        [self.videoCamera removeAllTargets];
        
        // 创建美颜滤镜
        GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
        
        // 设置GPUImage处理链，从数据源 => 滤镜 => 最终界面效果
        [self.videoCamera addTarget:beautifyFilter];
        [beautifyFilter addTarget:self.captureVideoPreview];
        
    } else {
    
        // 移除之前所有处理链
        [self.videoCamera removeAllTargets];
        [self.videoCamera addTarget:self.captureVideoPreview];
        
    }

}



@end
