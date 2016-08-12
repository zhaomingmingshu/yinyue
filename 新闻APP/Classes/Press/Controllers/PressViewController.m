//
//  ViewController.m
//  Demo04_QYNews
//
//  Created by qingyun on 16/7/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PressViewController.h"
#import "Header.h"
@interface PressViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

/** 控制器的索引 */
@property (nonatomic, assign) NSInteger indexController;
@property (nonatomic, copy) NSArray *arrCellData;
@property (nonatomic, copy) NSArray *arrTitles;
@property (nonatomic, copy) NSArray *arrControllers;
@property (nonatomic, weak) QYItemView *itemView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy) NSArray *arrEntertainment;
@property (nonatomic, copy) NSArray *arrSports;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, copy) NSArray *arrCars;
@property (nonatomic, copy) NSArray *arrTechonogy;
@property (nonatomic, copy) NSArray *arrMilitary;
@property (nonatomic, copy) NSArray *arrEnconomics;
@property (nonatomic, copy) NSArray *arrFashion;
@property (nonatomic, copy) NSArray *arrHealth;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIRefreshControl *control;
@end

@implementation PressViewController

- (NSArray *)arrTitles {
    if (!_arrTitles) {
        _arrTitles = @[@"头条", @"娱乐", @"体育", @"汽车",  @"科技", @"军事",@"财经",@"时尚",@"健康"];
    }
    return _arrTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    
}
- (void)setUpFootRefresh:(UITableView *)tableView{
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(paraseJson:)];
//    [tableView.mj_footer beginRefreshing];
}
- (void)setupRefreshWithTableView:(UITableView *)tableView{
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(paraseJson:) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:control];
    [control beginRefreshing];
    [self paraseJson:control ];
    
}
#pragma mark - paraseJson
- (void)paraseJson:(UIRefreshControl *)control{
     __weak PressViewController *vc = self;
    [[HTTPRequest sharedInstance] Get:Nestease_Headline withPage:self.page success:^(NSDictionary *dic) {
        NSMutableArray *arrMute = [NSMutableArray array];
        NSLog(@"headline%@",dic);
        NSMutableArray *arrMData = dic[@"T1348647909107"];

        for (NSInteger index = 1; index < arrMData.count; index++) {
            NSDictionary *dict = arrMData[index];
            ParseJsonModel *model = [[ParseJsonModel alloc] initWithDictionary:dict];
            [arrMute addObject:model];
        }
        _arrCellData = [arrMute copy];
        if(self.tableView.tag == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
               [vc.tableView reloadData];
            });
           
            [vc.tableView.mj_footer endRefreshing];
        }
          [control endRefreshing];
          
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
         [control endRefreshing];
    }];
    [[HTTPRequest sharedInstance] Get:HostPot withPage:self.page success:^(NSDictionary *dic) {
        //NSLog(@"%@",dic);
         vc.arrEntertainment = [vc strKey:@"T1348648517839" addDictionary:dic];

        [control endRefreshing];
//        if(vc.tableView.tag == 1){
//            [vc.tableView.mj_footer endRefreshing];
//        }
        } failure:^(NSError *error) {
        NSLog(@"%@",error);
            [control endRefreshing];
            
    }];
    [[HTTPRequest sharedInstance] Get:sport  withPage:self.page success:^(NSDictionary *dic) {
       // NSLog(@"%@",dic);
        vc.arrSports = [vc strKey:@"T1348649079062" addDictionary:dic];

        [control endRefreshing];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        // [control endRefreshing];
    }];
    [[HTTPRequest sharedInstance] Get:cars withPage:self.page success:^(NSDictionary *dic) {
       // NSLog(@"%@",dic);
        vc.arrCars = [vc strKey:@"list" addDictionary:dic];

         [control endRefreshing];

} failure:^(NSError *error) {
    NSLog(@"%@",error);
    [control endRefreshing];
}];
[[HTTPRequest sharedInstance] Get:Technology withPage:self.page success:^(NSDictionary *dic) {
    
         vc.arrTechonogy = [vc strKey:@"T1348649580692" addDictionary:dic];

        [control endRefreshing];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
         [control endRefreshing];
    }];
    [[HTTPRequest sharedInstance] Get:Military withPage:self.page success:^(NSDictionary *dic) {
        //NSLog(@"%@",dic);
        vc.arrMilitary = [vc strKey:@"T1348648141035" addDictionary:dic];

        [control endRefreshing];
//        if(vc.tableView.tag == 5){
//            [vc.tableView.mj_footer endRefreshing];
//        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
         [control endRefreshing];
    }];
    [[HTTPRequest sharedInstance] Get:Economics withPage:self.page success:^(NSDictionary *dic) {
       // NSLog(@"%@",dic);
        vc.arrEnconomics = [vc strKey:@"T1348648756099" addDictionary:dic];

        [control endRefreshing];
//        if(vc.tableView.tag == 6){
//            [vc.tableView.mj_footer endRefreshing];
//        }
        } failure:^(NSError *error) {
        NSLog(@"%@",error);
         [control endRefreshing];
    }];
    [[HTTPRequest sharedInstance] Get:Fashion withPage:self.page success:^(NSDictionary *dic) {
       // NSLog(@"%@",dic);
        vc.arrFashion = [vc strKey:@"T1348650593803" addDictionary:dic];

        [control endRefreshing];
//        if(vc.tableView.tag == 7){
//            [vc.tableView.mj_footer endRefreshing];
//        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [control endRefreshing];
    }];
    [[HTTPRequest sharedInstance] Get:Health withPage:self.page success:^(NSDictionary *dic) {
      // NSLog(@"%@",dic);
          vc.arrHealth = [vc strKey:@"T1414389941036" addDictionary:dic];
         [control endRefreshing];
//         if(vc.tableView.tag == 8){
//            [vc.tableView.mj_footer endRefreshing];
//        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
         [control endRefreshing];
    }];
}
- (NSMutableArray *)strKey:(NSString *)key addDictionary:(NSDictionary *)dic {
    NSMutableArray *arrMdata = dic[key];
    NSUInteger count = arrMdata.count;
    NSMutableArray *arrMModel = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger index = 0; index < count; index ++) {
        NSDictionary *dicData = arrMdata[index];
        ParseJsonModel *model = [[ParseJsonModel alloc] initWithDictionary:dicData];
        [arrMModel addObject:model];
    }
    return arrMModel;
}

- (void)loadDefaultSetting {
//      UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_discover_selected"] style:0 target:self action:@selector(skipToSearch)];
//    self.navigationItem.rightBarButtonItem = rightItem;
    // vcDetail.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    // 创建控制器数组
    NSUInteger count = self.arrTitles.count;
    NSMutableArray *arrMTemp = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger index = 0; index < count; index ++) {
        QYDetailViewController *vcDetail = [QYDetailViewController new];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 150) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tag = index;
        [self setupRefreshWithTableView:tableView];
        [self setUpFootRefresh:tableView];
        
        [vcDetail.view addSubview:tableView];
        if(tableView.tag == 0){
        self.tableView = tableView;
            self.tableView.contentInset = UIEdgeInsetsMake(60, 0, 70, 0);
            tableView.tableFooterView.frame = CGRectMake(0, 0, 0, 0);
        }
       
        vcDetail.title = self.arrTitles[index];
        [arrMTemp addObject:vcDetail];
    }
    _arrControllers = [arrMTemp copy];
    
    self.dataSource = self;
    self.delegate = self;
    // 加载滚动视图
    QYItemView *itemView = [QYItemView new];
    itemView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    itemView.arrTitles = self.arrTitles;
    [self.view addSubview:itemView];
    self.itemView = itemView;
    __weak typeof(self) selfWeak = self;
    [itemView setBlkDidChooseButtonAtIndex:^(NSUInteger index){
        [selfWeak chooseViewControllerAtIndex:index];
    }];
    
}
//- (void)skipToSearch{
//    SearchViewController *vcSearch = [SearchViewController new];
//    [self  presentViewController:vcSearch animated:YES completion:nil];
//}

- (void)chooseViewControllerAtIndex:(NSInteger)index {
    UIPageViewControllerNavigationDirection direction;
    if (index > self.indexController) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    QYDetailViewController *vcDetail = self.arrControllers[index];
    [self setViewControllers:@[vcDetail] direction:direction animated:YES completion:nil];
    self.indexController = index;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowNewsViewController *vcShowNews = [[ShowNewsViewController alloc] init];
    [self.navigationController pushViewController:vcShowNews animated:YES];
    
        if (tableView.tag == 0){
        ParseJsonModel *contentModel = self.arrCellData[indexPath.row];
        vcShowNews.strURL = contentModel.url;
        }else if (tableView.tag == 1){
        ParseJsonModel *entertainmentModel = self.arrEntertainment[indexPath.row];
        vcShowNews.strURL = entertainmentModel.url;
        }else if (tableView.tag == 2){
        ParseJsonModel *sportsModel = self.arrSports[indexPath.row];
            vcShowNews.strURL = sportsModel.url;
        }else if (tableView.tag == 3){
             ParseJsonModel *carsModel = self.arrCars[indexPath.row];
            vcShowNews.strURL = carsModel.url;
        }else if (tableView.tag == 4){
             ParseJsonModel *techonogyModel = self.arrTechonogy[indexPath.row];
            vcShowNews.strURL = techonogyModel.url;
        }else if (tableView.tag == 5){
             ParseJsonModel *militaryModel = self.arrMilitary[indexPath.row];
            vcShowNews.strURL = militaryModel.url;
        }else if (tableView.tag == 6){
             ParseJsonModel *econamicsModel = self.arrEnconomics[indexPath.row];
            vcShowNews.strURL = econamicsModel.url;
        }else if (tableView.tag == 7){
             ParseJsonModel *fashionModel = self.arrFashion[indexPath.row];
            vcShowNews.strURL = fashionModel.url;
        }else if (tableView.tag == 8){
            ParseJsonModel *healthModel = self.arrHealth[indexPath.row];

            vcShowNews.strURL = healthModel.url;
        }
   
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if(tableView.tag == 0){
//         return self.arrCellData.count;
//    }else if (tableView.tag == 1){
//        return self.arrEntertainment.count;
//    }else if (tableView.tag == 2){
//        return self.arrSports.count;
//    }else if (tableView.tag == 3){
//        return self.arrCars.count;
//    }else if (tableView.tag == 4){
//        return self.arrTechonogy.count;
//    }else if (tableView.tag == 5){
//        return self.arrMilitary.count;
//    }else if (tableView.tag == 6){
//        return self.arrEnconomics.count;
//    }else if (tableView.tag == 7){
//        return self.arrFashion.count;
//    }else{
//        return self.arrHealth.count;
//    }
    
    switch (tableView.tag) {
        case 0:
            return self.arrCellData.count;
            break;
           case 1:
            return self.arrEntertainment.count;
            break;
           case 2:
            return self.arrSports.count;
            break;
        case 3:
            return self.arrCars.count;
            break;
        case 4:
            return self.arrTechonogy.count;
            break;
        case 5:
            return self.arrMilitary.count;
            break;
        case 6:
            return self.arrEnconomics.count;
            break;
        case 7:
            return self.arrFashion.count;
            break;
        
        default:
          return self.arrHealth.count;
            break;
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if(tableView.tag == 0){
//        return [self arrModel:self.arrCellData withTableView:tableView andIndexPath:indexPath];
//        
//    }else if(tableView.tag == 1){
//        return [self arrModel:self.arrEntertainment withTableView:tableView andIndexPath:indexPath];
//    }else if (tableView.tag == 2){
//        
//        return [self arrModel:self.arrSports withTableView:tableView andIndexPath:indexPath];
//    }else if (tableView.tag == 3){
//        return [self arrModel:self.arrCars withTableView:tableView andIndexPath:indexPath];
//    }else if (tableView.tag == 4){
//        
//        return [self arrModel:self.arrTechonogy withTableView:tableView andIndexPath:indexPath];
//    }else if (tableView.tag == 5){
//        return [self arrModel:self.arrMilitary withTableView:tableView andIndexPath:indexPath];
//    }else if(tableView.tag == 6) {
//        return [self arrModel:self.arrEnconomics withTableView:tableView andIndexPath:indexPath];
//    }else if (tableView.tag == 7){
//      return  [self arrModel:self.arrFashion withTableView:tableView andIndexPath:indexPath];
//        
//    }else{
//        return [self arrModel:self.arrHealth withTableView:tableView andIndexPath:indexPath];
//    }
    
    switch (tableView.tag) {
        case 0:
            return [self arrModel:self.arrCellData withTableView:tableView andIndexPath:indexPath];
            break;
        case 1:
            return [self arrModel:self.arrEntertainment withTableView:tableView andIndexPath:indexPath];
            break;
        case 2:
            return [self arrModel:self.arrSports withTableView:tableView andIndexPath:indexPath];
            break;
        case 3:
            return [self arrModel:self.arrCars withTableView:tableView andIndexPath:indexPath];
            break;
        case 4:
            return [self arrModel:self.arrTechonogy withTableView:tableView andIndexPath:indexPath];
            break;
        case 5:
            return [self arrModel:self.arrMilitary withTableView:tableView andIndexPath:indexPath];
            break;
        case 6:
            return [self arrModel:self.arrEnconomics withTableView:tableView andIndexPath:indexPath];
            break;
        case 7:
            return [self arrModel:self.arrFashion withTableView:tableView andIndexPath:indexPath];
            break;
            
        default:
            return [self arrModel:self.arrHealth withTableView:tableView andIndexPath:indexPath];
            break;
    }

}

- (UITableViewCell *)arrModel:(NSArray *)arr withTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
       ParseJsonModel *model = arr[indexPath.row ];
  
   // if(model.imgextra == nil){
    if(model.url == nil || [model.url isEqualToString:@"null"] || [model.url isEqualToString:@""] || model.url == NULL ){
        PressTableViewCell *cell = [PressTableViewCell cellWithTableView:tableView withIndexPath:indexPath];
                                    
        tableView.rowHeight = 0;
        return cell;
            }
    PressTableViewCell *cell = [PressTableViewCell cellWithTableView:tableView withIndexPath:indexPath];
      cell.parseJsonModel = model;
        tableView.rowHeight = 100;
        return cell;
//    }else{
//        PressImgExtraCell *cell = [PressImgExtraCell cellWithTableView:tableView];
//        cell.parseImgExtraModel = model;
//        tableView.rowHeight = 170;
//        return cell;
//    }
   
}

#pragma mark - UIPageViewControllerDataSource
// 下一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    for (NSInteger index = 0; index < _arrControllers.count; index ++) {
        QYDetailViewController *vcDetail = _arrControllers[index];
        if (vcDetail == viewController) {
            if (index + 1 < _arrControllers.count) {
                return _arrControllers[index + 1];
            }
        }
    }
    return nil;
}
// 上一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    for (NSInteger index = 0; index < _arrControllers.count; index ++) {
        QYDetailViewController *vcDetail = _arrControllers[index];
        if (vcDetail == viewController) {
            if (index - 1 >= 0) {
                return _arrControllers[index - 1];
            }
        }
    }
    return nil;
}

#pragma mark - UIPageViewControllerDelegate
/** 完成动画的时候调用 */
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    // 获取当前的控制器
    QYDetailViewController *vcDetailCurrent = self.viewControllers.firstObject;
    NSUInteger count = self.arrControllers.count;
    for (NSUInteger index = 0; index < count; index ++) {
        QYDetailViewController *vcTemp = self.arrControllers[index];
        if (vcTemp == vcDetailCurrent) {
            [self.itemView chooseIndex:index];
            break;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        if (scrollView.contentOffset.y > self.tableView.frame.size.height ){
            while (self.page < 400) {
                 self.page += 20;
            }
           
        }
   }
}
@end
