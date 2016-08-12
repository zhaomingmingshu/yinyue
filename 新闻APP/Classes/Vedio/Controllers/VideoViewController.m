//
//  VideoViewController.m
//  新闻APP
//
//  Created by qingyun on 16/6/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VideoViewController.h"
#import "HTTPRequest.h"
#import "VideoViewController.h"
#import "VidioModel.h"
#import "PlayingViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#define Video @"http://c.3g.163.com/recommend/getChanListNews?channel=T1457068979049&size=10&passport=&devId=nLeYcdlqundGX7ytVcYERg%3D%3D&lat=LR15AKgvh00crMMZmBa3rA%3D%3D&lon=jf3tXLvhbo6tjr10h837%2FA%3D%3D&version=11.0&net=wifi&ts=1470398051&sign=3JdLnV0NVKAIixYgqkSsmXVAbCWDPXp26p1lOXodvet48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=jinli_store2014_news&mac=Or9fMlg4dXHNSK1lGQHkuHQK12UJXvC0oRsEs%2BTxdA0%3D"
static NSString *strCell = @"strCell";
static NSString *strHeader = @"strHeader";
static NSString *strFooter = @"strFooter";
@interface VideoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *arrVideo;
@property (nonatomic, assign) NSInteger page;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parseJson];
    [self loadDefualtSetting];
    [self setUpRefresh];
    [self setUpFooterRefresh];
}

- (void)setUpFooterRefresh{
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(parseJson)];
    [self.collectionView.mj_footer beginRefreshing];
}
- (void)setUpRefresh{
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(parseJson)];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)parseJson{
    __weak VideoViewController *vc = self;
    self.page = 0;
    [[HTTPRequest sharedInstance] Get:Video withPage:self.page success:^(NSDictionary *dic) {
         NSLog(@"%@",dic);
        NSArray *arr = dic[@"视频"];
        NSUInteger count = arr.count;
        NSMutableArray *arrMdata = [NSMutableArray arrayWithCapacity:count];
        for (NSUInteger index = 0;index < count ; index ++) {
            NSDictionary *dicData = arr[index];
            VidioModel *model = [[VidioModel alloc] initWithDictionary:dicData];
            [arrMdata addObject:model];
        }
        vc.arrVideo = arrMdata;
        dispatch_async(dispatch_get_main_queue(), ^{
            [vc.collectionView reloadData];
            [vc.collectionView.mj_header endRefreshing];
            [vc.collectionView.mj_footer endRefreshing];

        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
- (void)loadDefualtSetting{
    self.view.backgroundColor = [UIColor colorWithRed:245 green:245 blue:253 alpha:1.0];
    self.tabBarController.tabBar.translucent = NO;
    UICollectionViewFlowLayout *flViewCollection = [UICollectionViewFlowLayout new];
    flViewCollection.itemSize = CGSizeMake(160,170);
    flViewCollection.minimumLineSpacing = 10;
    flViewCollection.sectionInset = UIEdgeInsetsMake(10,20,20,20);
    flViewCollection.sectionFootersPinToVisibleBounds = YES;
    flViewCollection.headerReferenceSize = CGSizeMake(10, 10);
    flViewCollection.footerReferenceSize = CGSizeMake(5, 5);
    flViewCollection.sectionHeadersPinToVisibleBounds = YES;
    flViewCollection.minimumInteritemSpacing = 10;
    flViewCollection.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *viewCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100) collectionViewLayout:flViewCollection];
    self.collectionView = viewCollection;
    viewCollection.dataSource = self;
    viewCollection.delegate = self;
    //注册一个cell
    viewCollection.backgroundColor = [UIColor whiteColor];
    [viewCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:strCell];
    //注册一个header
    [viewCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:strHeader];
    //注册一个footer
    [viewCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:strFooter];
    [self.view addSubview:viewCollection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrVideo.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VidioModel *model = self.arrVideo[indexPath.row];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:strCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in [cell.contentView subviews])
    {
        [view removeFromSuperview];
    }
    UIImageView *imgView = [[UIImageView alloc] init];
    [cell.contentView addSubview:imgView];
    //imgView.backgroundColor = [UIColor orangeColor];
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    imgView.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height *0.7);

    UIImageView *playImg = [[UIImageView alloc] init];
    playImg.center = imgView.center;
    playImg.image = [UIImage imageNamed:@"playing.png"];
    playImg.bounds = CGRectMake(0, 0, 50, 50);
    [imgView addSubview:playImg];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = model.title;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:titleLabel];
   // titleLabel.backgroundColor = [UIColor cyanColor];
      titleLabel.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame), cell.contentView.frame.size.width, cell.contentView.frame.size.height * 0.25);
    
    UILabel *sourceLable = [[UILabel alloc] init];
    sourceLable.text = model.videosource;
    [cell.contentView addSubview:sourceLable];
    //sourceLable.backgroundColor = [UIColor magentaColor];
    sourceLable.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame), cell.contentView.frame.size.width, cell.contentView.frame.size.height * 0.05);
    sourceLable.font = [UIFont systemFontOfSize:12];
    [sourceLable setTextColor:[UIColor grayColor]];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headerFooterView = nil;
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        headerFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:strHeader forIndexPath:indexPath];
}
    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        headerFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:strFooter forIndexPath:indexPath];
        
    }
    return headerFooterView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VidioModel *model = self.arrVideo[indexPath.row];
    NSLog(@"hehehe%@",model.mp4_url);
    PlayingViewController *playingVc = [[PlayingViewController alloc] init];
    playingVc.strURL = model.mp4_url;
    [self.navigationController pushViewController:playingVc animated:YES];
}
@end
