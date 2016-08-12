//
//  QYItemView.m
//  Demo04_QYNews
//
//  Created by qingyun on 16/7/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

/** Color Related */
#define QLColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])
#define QLColorRandom QLColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define QLColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "QYItemView.h"

@implementation QYItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    self.backgroundColor = [UIColor lightTextColor];
}

- (void)setArrTitles:(NSArray *)arrTitles {
    _arrTitles = [arrTitles copy];
    
    CGFloat itemWidth = 80;
    CGFloat itemHeight = self.bounds.size.height;
    
    NSUInteger count = arrTitles.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *btnItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnItem setTitle:arrTitles[index] forState:UIControlStateNormal];
        [btnItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnItem setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        [btnItem addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchDown];
        [btnItem setFrame:CGRectMake(index * itemWidth, 0, itemWidth, itemHeight)];
        btnItem.tag = index;
        [self addSubview:btnItem];
    }
    
    [self setContentSize:CGSizeMake(count * itemWidth, 1)];
}

- (void)chooseAction:(UIButton *)button {
    // 把所有的UIButton置为未选中
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.enabled = YES;
        }
    }
    // 选中用户选中的按钮, 如果contentSize的大小有一个为0, 这个方法就不起作用
    button.enabled = NO;
    
    // 让指定的区域可见
    [self scrollRectToVisible:button.frame animated:YES];
    
    // 回调Block
    if (self.blkDidChooseButtonAtIndex) {
        self.blkDidChooseButtonAtIndex(button.tag);
    }
}

- (void)chooseIndex:(NSInteger)indexChoosed {
    NSUInteger count = self.arrTitles.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *btnItem = self.subviews[index];
        if ([btnItem isKindOfClass:[UIButton class]] && btnItem.tag == indexChoosed) {
            [self chooseAction:btnItem];
            break;
        }
    }
}
//系统自定义的一个方法
- (void)willMoveToWindow:(UIWindow *)newWindow {
    NSUInteger count = self.arrTitles.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *btnItem = self.subviews[index];
        if ([btnItem isKindOfClass:[UIButton class]] && btnItem.tag == 0) {
            [self chooseAction:btnItem];
            break;
        }
    }
}

@end
