//
//  VidioModel.m
//  新闻APP
//
//  Created by qingyun on 16/8/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VidioModel.h"

@implementation VidioModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self =[super init]){
        self.title = dict[@"title"];
        self.videosource = dict[@"videosource"];
        self.mp4_url = dict[@"mp4_url"];
        self.cover = dict[@"cover"];
    }
    return self;
}
@end
