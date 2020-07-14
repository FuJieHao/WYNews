//
//  NewsModel.m
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ -- %@",self.title,self.source];
}

@end
