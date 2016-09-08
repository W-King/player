//
//  ViewController.m
//  PPX_Player
//
//  Created by pipixia on 16/9/6.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "ViewController.h"
#import "PPX_MovieViewController.h"
#import "PlayerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"点我进播放器" forState:UIControlStateNormal];
    btn.frame = CGRectMake((self.view.frame.size.width-100)/2, (self.view.frame.size.height-100)/2, 100, 100);
    [btn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
}
- (void)buttonAction
{
//    PPX_MovieViewController *movie = [[PPX_MovieViewController alloc]init];
//    [self presentViewController:movie animated:YES completion:nil];
    
    PlayerViewController *movie = [[PlayerViewController alloc]init];
    [self presentViewController:movie animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
