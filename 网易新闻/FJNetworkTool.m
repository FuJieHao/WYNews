//
//  FJNetworkTool.m
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJNetworkTool.h"

@implementation FJNetworkTool

+ (instancetype)sharedNetworkTool
{
    static FJNetworkTool *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 设置相对路径
        NSURL *BaseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        // 实例化Manager
        instance = [[self alloc] initWithBaseURL:BaseURL];
        
        // 增加AFN支持的文件类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    });
    
    return instance;
}

- (void)GETWithURLString:(NSString *)URLString success:(void (^)(id))success faile:(void (^)(NSError *))faile
{
    // 正真在发送网络请求的是 AFHTTPSessionManager
    [self GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // AFN的回调,默认就是在主线程
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            faile(error);
        }
    }];
}

@end
