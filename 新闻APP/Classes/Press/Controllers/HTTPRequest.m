//
//  HTTPRequest.m
//  新闻APP
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HTTPRequest.h"
#import "AFNetWorking.h"
@implementation HTTPRequest
+ (instancetype) sharedInstance{
    static HTTPRequest *httpRequest;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpRequest = [[self alloc] init];
    });
    return httpRequest;
}
- (void) Get:(NSString *)strURL withPage:(NSInteger)page  success:(void(^)(NSDictionary *dic)) success failure:(void(^)(NSError *error)) failure{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [AFHTTPSessionManager manager].responseSerializer=[AFJSONResponseSerializer serializer];
    [AFHTTPSessionManager manager].responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/JavaScript",@"text/html",@"text/plain", nil];
    NSString *url = [NSString stringWithFormat:@"%@%ld-20.html",strURL, page];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",strURL);
        NSLog(@"网络请求成功1");
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败1");
        failure(error);
    }];
}

@end
