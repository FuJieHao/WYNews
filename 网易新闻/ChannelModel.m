//
//  ChannelModel.m
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "ChannelModel.h"
#import <YYModel.h>


@implementation ChannelModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ -- %@",self.tname,self.tid];
}

+ (NSArray *)channels
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *dictArr = [dict objectForKey:@"tList"];
    
    NSArray *arrModel = [NSArray yy_modelArrayWithClass:[ChannelModel class] json:dictArr];
    
    [arrModel sortedArrayUsingComparator:^NSComparisonResult(ChannelModel *obj1, ChannelModel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    return arrModel;
}

@end
