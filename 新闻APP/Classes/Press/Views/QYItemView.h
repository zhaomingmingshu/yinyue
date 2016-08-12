//
//  QYItemView.h
//  Demo04_QYNews
//
//  Created by qingyun on 16/7/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYItemView : UIScrollView

/** 按钮点击事件的Block */
@property (nonatomic, copy) void (^blkDidChooseButtonAtIndex)(NSUInteger index);

/** 所有的按钮去标题 */
@property (nonatomic, copy) NSArray *arrTitles;

/** 选中指定index的Button */
- (void)chooseIndex:(NSInteger)index;

@end
