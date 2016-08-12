//
//  ViewController.m
//  新闻APP
//
//  Created by qingyun on 16/6/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#define QLColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])
#define QLColorRandom QLColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define QLColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#import "MainViewController.h"
#import "NewsNavigationController.h"
#import "PressViewController.h"
//#import "ReadViewController.h"
#import "VideoViewController.h"
//#import "TopicViewController.h"
//#import "ProfileViewController.h"

//#import "SearchViewController.h"
@interface MainViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak)NewsNavigationController *vcNav;
@property (nonatomic,strong)PressViewController *vcPress;
@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDefaultSetting];
    
}


- (void)loadDefaultSetting{
    
    
    
    PressViewController *vcPress = [[PressViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    [self addViewController:vcPress imageName:@"tabbar_news" title:@"新闻"];
    _vcPress = vcPress;

//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_discover_selected"] style:0 target:self action:@selector(skipToSearch)];
//    
//    self.navigationItem.rightBarButtonItem = rightItem;
//    
//    self.tabBarController.tabBar.hidden = NO;

    
//     ReadViewController *vcRead = [ReadViewController new];
//     [self addViewController:vcRead imageName:@"tabbar_read" title:@"阅读"];
    
    VideoViewController *vcVideo = [VideoViewController new];
     [self addViewController:vcVideo  imageName:@"tabbar_video" title:@"视频"];
    
//    TopicViewController *vcTopic = [TopicViewController new];
//     [self addViewController:vcTopic imageName:@"tabbar_topic" title:@"话题"];
    
//    ProfileViewController *vcProfile = [ProfileViewController new];
//     [self addViewController:vcProfile imageName:@"tabbar_profile" title:@"我"];
    
    self.tabBar.tintColor = [UIColor redColor];


}

//- (void)skipToSearch{
//    
//    
//    SkipSearchViewController *vcSearch = [SkipSearchViewController new];
//    
//    [_vcPress.navigationController pushViewController:vcSearch animated:YES];
//    
//    
//}
//


- (void)addViewController:(UIViewController *)viewController imageName:(NSString *)imageName title:(NSString *)title{
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]];
    
    //viewController.title = title;
     viewController.tabBarItem.title = title;
    
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -1);
    
    //创建一个导航控制器
    


    NewsNavigationController *vcNav = [[NewsNavigationController alloc] initWithRootViewController:viewController];
    vcNav.view.frame = self.view.frame;
    vcNav.toolbarHidden = YES;
    
        [self addChildViewController:vcNav];
    
    
   self.vcNav = vcNav;
    
    
   
     
}


//- (BOOL)prefersStatusBarHidden{
//    
//    return YES;
//}

//- (void)skipTosearch{
//    
//    
//    SkipSearchViewController *vcSearch = [SkipSearchViewController new];
//    
//    [self.vcNav.navigationController pushViewController:vcSearch animated:YES];
//    
//    
//    
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
