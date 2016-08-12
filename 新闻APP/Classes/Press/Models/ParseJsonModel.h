//
//  EntertainmentModel.h
//  新闻APP
//
//  Created by qingyun on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseJsonModel : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *imgsrc;
@property (nonatomic, copy)NSString *ptime;
@property (nonatomic, assign)NSInteger votecount;
@property (nonatomic, copy)NSArray *imgextra;
@property (nonatomic, copy)NSString *url;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
