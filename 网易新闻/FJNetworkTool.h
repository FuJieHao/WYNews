//
//  FJNetworkTool.h
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface FJNetworkTool : AFHTTPSessionManager

+ (instancetype)sharedNetworkTool;


- (void)GETWithURLString:(NSString *)URLString success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile;

@end
