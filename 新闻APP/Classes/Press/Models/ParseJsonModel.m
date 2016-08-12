//
//  EntertainmentModel.m
//  新闻APP
//
//  Created by qingyun on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ParseJsonModel.h"

@implementation ParseJsonModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if(self = [super init]){
        self.title = dict[@"title"];
        self.votecount = [dict[@"votecount"] integerValue];
        self.imgsrc = dict[@"imgsrc"];
        self.ptime= dict[@"ptime"];
        self.imgextra = dict[@"imgextra"];
        self.url = dict[@"url"];
    }
    return self;
}
@end
