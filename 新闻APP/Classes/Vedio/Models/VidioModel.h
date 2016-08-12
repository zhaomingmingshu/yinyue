//
//  VidioModel.h
//  新闻APP
//
//  Created by qingyun on 16/8/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface VidioModel : NSObject
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *mp4_url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *videosource;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
