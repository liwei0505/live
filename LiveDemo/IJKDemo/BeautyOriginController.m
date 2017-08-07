//
//  BeautyOriginController.m
//  IJKDemo
//
//  Created by lee on 16/10/12.
//  Copyright © 2016年 bird. All rights reserved.


/***
 
 GPUImage 原生美颜实现
 
 */

#import "BeautyOriginController.h"
#import <GPUImage.h>

@interface BeautyOriginController ()

@property (nonatomic, strong) UISlider *brightnessSlider;
@property (nonatomic, strong) UISlider *bilateralSlider;

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageBilateralFilter *bilateralFilter;
@property (nonatomic, strong) GPUImageBrightnessFilter *brightnessFilter;

@end

@implementation BeautyOriginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareFilter];
    [self prepareUI];
    
}

- (void)prepareUI {

    UISlider *bright = [[UISlider alloc] initWithFrame:CGRectMake(20, 100, 300, 20)];
    [self.view addSubview:bright];
    [bright addTarget:self action:@selector(brightnessFilter:) forControlEvents:UIControlEventValueChanged];
    self.brightnessSlider = bright;
    
    
    UISlider *bilateral = [[UISlider alloc] initWithFrame:CGRectMake(20, 150, 300, 20)];
    [self.view addSubview:bilateral];
    [bilateral addTarget:self action:@selector(bilateralFilter:) forControlEvents:UIControlEventValueChanged];
    self.bilateralSlider = bilateral;

}

//美颜
- (void)brightnessFilter:(UISlider *)sender {
    self.brightnessFilter.brightness = sender.value;
}

//磨皮
- (void)bilateralFilter:(UISlider *)sender {
    // 值越小，磨皮效果越好
    CGFloat maxValue = 10;
    [self.bilateralFilter setDistanceNormalizationFactor:maxValue - sender.value * 10];
}


- (void)prepareFilter {

    // 创建视频源
    // SessionPreset:屏幕分辨率，AVCaptureSessionPresetHigh会自适应高分辨率
    // cameraPosition:摄像头方向
    
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    //代表前置的时候不是镜像
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.videoCamera = videoCamera;
    
    // 创建最终预览View
    GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.frame];
    [self.view insertSubview:captureVideoPreview atIndex:0];
    
    // 创建滤镜：磨皮，美白，组合滤镜
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc] init];
    
    // 磨皮滤镜
    GPUImageBilateralFilter *bilateralFilter = [[GPUImageBilateralFilter alloc] init];
    [groupFilter addTarget:bilateralFilter];
    self.bilateralFilter = bilateralFilter;
    
    // 美白滤镜
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    [groupFilter addTarget:brightnessFilter];
    self.brightnessFilter = brightnessFilter;
    
    // 设置滤镜组链
    [bilateralFilter addTarget:brightnessFilter];
    [groupFilter setInitialFilters:@[bilateralFilter]];
    groupFilter.terminalFilter = brightnessFilter;
    
    // 设置GPUImage响应链，从数据源 => 滤镜 => 最终界面效果
    [videoCamera addTarget:groupFilter];
    [groupFilter addTarget:captureVideoPreview];
    
    // 必须调用startCameraCapture，底层才会把采集到的视频源，渲染到GPUImageView中，就能显示了。
    // 开始采集视频
    [videoCamera startCameraCapture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
