//
//  PlayerViewController.m
//  PPX_Player
//
//  Created by pipixia on 16/9/7.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "PlayerViewController.h"
#import "PPX_VideoPlayer.h"

#define SWIDTH   [UIScreen mainScreen].bounds.size.width
#define SHEIGHT  [UIScreen mainScreen].bounds.size.height

@interface PlayerViewController () <PPX_VideoPlayerDelegate> {
    PPX_VideoPlayer *_player;
    
}

@end

@implementation PlayerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor brownColor];
    
    [self createUI];
    
}
-(void)dealloc{
    //关闭播放器并销毁当前播放view
    //一定要在退出时使用,否则内存可能释放不了
    [_player close];
}
-(BOOL)shouldAutorotate{
    return !_player.isSwitch;
}
#pragma mark - 创建UI
-(void)createUI{
    
    //播放器
    _player=[[PPX_VideoPlayer alloc] initWithFrame:CGRectMake(0,120,SWIDTH,SWIDTH*3/4)
                                              url:@"http://f01.v1.cn/group2/M00/01/62/ChQB0FWBQ3SAU8dNJsBOwWrZwRc350-m.mp4"
                                         delegate:self];
    [self.view addSubview:_player];
    
}

#pragma mark - PPX_VideoPlayerDelegate
//非全屏下返回点击(仅限默认UI)
-(void)back{
    [self backClick];
}
#pragma mark - 点击事件
//返回
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
