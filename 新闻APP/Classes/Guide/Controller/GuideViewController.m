//
//  GuideViewController.m
//  新闻APP
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"

@interface GuideViewController ()

@property (nonatomic,weak) UIScrollView *scrollView;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self loadDefaultSetting];
    
    
}


- (void)loadDefaultSetting{
    
    UIScrollView *scrollView = [UIScrollView new];
    
    scrollView.frame = self.view.frame;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //给scrollView添加图片控件
    NSArray *arrImageNames = @[@"News1.jpg"];
    
    NSUInteger count = arrImageNames.count;
     CGFloat width = scrollView.bounds.size.width;
    
    for(NSUInteger index = 0;index < count; index++){
        
        UIImageView *imageView = [UIImageView new];
        
        imageView.image = [UIImage imageNamed:arrImageNames[index]];
        
        imageView.contentMode = UIViewContentModeCenter;
        
        imageView.frame = CGRectMake(index*width, 0,width , scrollView.bounds.size.height);
        [scrollView addSubview:imageView];
        if(index == count -1){
            
            [self loadEnjoyButton:imageView];
            
        }
        
    }
    
    [scrollView setContentSize:CGSizeMake(count*width, 0)];
    
}

- (void)loadEnjoyButton:(UIImageView*)imageView{
    
    UIButton *btnEnjoy = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [btnEnjoy setTitle:@"Enjoy" forState:UIControlStateNormal];
    
    [btnEnjoy setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    btnEnjoy.titleLabel.font = [UIFont systemFontOfSize:40];
    
    CGFloat width = 150;
    
    CGFloat X = (self.view.frame.size.width - width)*0.5 + CGRectGetMinX(imageView.frame);
    
    CGFloat Y = self.view.frame.size.height - 100;
    btnEnjoy.frame = CGRectMake(X, Y, width, 50);
    
    [self.scrollView addSubview:btnEnjoy];
    
    [btnEnjoy.layer setCornerRadius:5];
    
    [btnEnjoy.layer setBorderColor:[UIColor redColor].CGColor];
    
    [btnEnjoy.layer setBorderWidth:1.0];
    [btnEnjoy.layer setMasksToBounds:YES];
    
    [btnEnjoy addTarget:self action:@selector(tapEnjoyAction) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)tapEnjoyAction{
    
    NSString *strVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    [[NSUserDefaults standardUserDefaults] setObject:strVersion forKey:@"oldVersionKey"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    AppDelegate *delegae = [UIApplication sharedApplication].delegate ;
    
    [delegae loadMainController];
    
}


@end
