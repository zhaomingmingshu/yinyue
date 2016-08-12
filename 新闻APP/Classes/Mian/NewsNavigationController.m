//
//  NewNavigationController.m
//  新闻APP
//
//  Created by qingyun on 16/6/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsNavigationController.h"

@interface NewsNavigationController ()

@end

@implementation NewsNavigationController

+(void)initialize{
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.translucent = NO;
    
   [navBar setBarTintColor:[UIColor orangeColor]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}



@end
