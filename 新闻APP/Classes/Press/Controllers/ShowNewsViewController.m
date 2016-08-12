//
//  ShowNewsViewController.m
//  新闻APP
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ShowNewsViewController.h"

@interface ShowNewsViewController ()

@end

@implementation ShowNewsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

- (void)loadDefaultSetting{
    self.navigationController.navigationBar.translucent = NO;
    
    UIWebView *webView = [[UIWebView alloc] init];
       webView.frame = self.view.bounds;
    webView.scalesPageToFit = YES;
       [self.view addSubview:webView];
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    view.backgroundColor = [UIColor redColor];
    [webView addSubview:view];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 5, 150, 40);
    label.text = @"简单新闻";
    [label setTextColor:[UIColor blackColor]];
    [view addSubview:label];
    
    NSURL *url = [NSURL URLWithString:self.strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

@end
