1, 引入头文件
#import "PPX_VideoPlayer.h"

2,代理
PPX_VideoPlayerDelegate
-(void)back
-(void)backClick

3,屏幕横屏纵屏
-(BOOL)shouldAutorotate

4, 创建播放器
 //播放器
    _player=[[PPX_VideoPlayer alloc] initWithFrame:CGRectMake(0,120,SWIDTH,SWIDTH*3/4) //位置
                                              url:@"http://f01.v1.cn/group2/M00/01/62/ChQB0FWBQ3SAU8dNJsBOwWrZwRc350-m.mp4" //网址
                                         delegate:self]; //代理
    [self.view addSubview:_player];

5,销毁
-(void)dealloc{
    //关闭播放器并销毁当前播放view
    //一定要在退出时使用,否则内存可能释放不了
    [_player close];
}
