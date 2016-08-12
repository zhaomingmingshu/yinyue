//
//  PlayingViewController.h
//  新闻APP
//
//  Created by qingyun on 16/8/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface PlayingViewController :AVPlayerViewController
@property (nonatomic, copy)NSString *strURL;
@end
