//
//  PlayingViewController.m
//  新闻APP
//
//  Created by qingyun on 16/8/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PlayingViewController.h"

@interface PlayingViewController ()
@end

@implementation PlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self playVedio];
   
}
-(void)playVedio{
  
     //设置播放器的对象
    AVPlayer *player=[[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.strURL]];
    self.player=player;
    //设置样式
   self.videoGravity=AVLayerVideoGravityResizeAspect;
    //播放
    [self.player play];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


@end
