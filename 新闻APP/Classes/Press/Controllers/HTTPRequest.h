//
//  HTTPRequest.h
//  新闻APP
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequest : NSObject
+ (instancetype) sharedInstance;

- (void) Get:(NSString *)strURL withPage:(NSInteger)page  success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSError *error)) failure;

@end
