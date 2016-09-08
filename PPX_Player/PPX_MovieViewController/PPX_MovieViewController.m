//
//  PPX_MovieViewController.m
//  PPX_ Player
//
//  Created by pipixia on 16/9/6.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "PPX_MovieViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#define PPX_MoiveUrl @"http://v.theonion.com/onionstudios/video/3158/640.mp4"


@interface PPX_MovieViewController ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIActivityIndicatorView *activity;    //菊花


@end


@implementation PPX_MovieViewController

#pragma mark - 横屏代码
- (BOOL)shouldAutorotate{
    return NO;
}
#pragma mark 旋转屏幕
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}
- (BOOL)prefersStatusBarHidden
{
    return NO; // 返回NO表示要显示，返回YES将hiden
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _width = [[UIScreen mainScreen]bounds].size.height;
    _height = [[UIScreen mainScreen]bounds].size.width;
    
    //1.创建Item，添加url
    _playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:PPX_MoiveUrl]];
    
    //2.创建player，添加Item
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    
    //3.创建player的layer
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    layer.frame = CGRectMake(0, 0, _width, _height);
    
    //设置视频以什么方式显示在layer上
    layer.videoGravity = AVLayerVideoGravityResize;//拉伸填充为主
    [self.view.layer addSublayer:layer];
    
    //4.添加到视图的layer上后，开始播放
    [_player play];
    
    //5.添加kvo，监听视频状态
    [self addObserver];
    
    //6.视频上的视图
    [self makeUpMovieView];
    
    
    //添加菊花
    [self createActivity];
   
    
    //计时器
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(Stack) userInfo:nil repeats:YES];
    
    
}

#pragma mark -----------------------------
#pragma mark - 视频播放相关
#pragma mark -----------------------------
#pragma mark - KVO - 监测视频状态, 视频播放的核心部分
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"])
    {        //获取到视频信息的状态, 成功就可以进行播放, 失败代表加载失败
        if (self.playerItem.status == AVPlayerItemStatusReadyToPlay)
        {   //准备好播放
            NSLog(@"AVPlayerItemStatusReadyToPlay: 视频成功播放");
        }
        else if(self.playerItem.status == AVPlayerItemStatusFailed)
        {    //加载失败
            NSLog(@"AVPlayerItemStatusFailed: 视频播放失败");
        }
        else if(self.playerItem.status == AVPlayerItemStatusUnknown)
        {   //未知错误
        }
    }
    else if([keyPath isEqualToString:@"loadedTimeRanges"])
    { //当缓冲进度有变化的时候
        NSLog(@"当缓冲进度有变化的时候");
    }
    else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"])
    { //当视频播放因为各种状态播放停止的时候, 这个属性会发生变化
        NSLog(@"playbackLikelyToKeepUp change : %@", change);
    }
    else if([keyPath isEqualToString:@"playbackBufferEmpty"])
    {  //当没有任何缓冲部分可以播放的时候
        NSLog(@"playbackBufferEmpty");
    }
    else if ([keyPath isEqualToString:@"playbackBufferFull"])
    {
        NSLog(@"playbackBufferFull: change : %@", change);
    }
    else if([keyPath isEqualToString:@"presentationSize"])
    {      //获取到视频的大小的时候调用
        NSLog(@"presentationSize");
    }
}
- (void)makeUpMovieView
{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    [self.view addSubview:_backView];
}
- (void)createActivity
{
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activity.center = _backView.center;
    [self.view addSubview:_activity];
    [_activity startAnimating];
}
#pragma mark - 计时器事件
- (void)Stack{
    if (_playerItem.duration.timescale != 0) {
        
        
    }
    
    //控制菊花
    if (_player.status == AVPlayerStatusReadyToPlay) {
        //菊花停止
        [_activity stopAnimating];
    }else{
        //菊花开始
        [_activity startAnimating];
    }
}

//添加KVO监控
-(void)addObserver{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_playerItem addObserver:self forKeyPath:@"playbackBufferFull" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_playerItem addObserver:self forKeyPath:@"presentationSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}
- (void)moviePlayDidEnd:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
